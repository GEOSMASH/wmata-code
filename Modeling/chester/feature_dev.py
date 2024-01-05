import pandas as pd
import geopandas as gpd
from collections import OrderedDict
from utils import *
import os

def trim_and_rename_columns(df, columns):
    df = df[list(columns.keys())]
    df = df.rename(columns=columns)
    return df

def merge_with_master(master_df, df, on=['id_o', 'id_d']):
    return master_df.merge(df, on=on, how='left')

def fill_o_values(master_df):
    df = master_df.copy()
    o_cols = [col for col in df.columns if col[-2:] == '_o']
    o_vals = df[o_cols].groupby('id_o').first()
    df = df.drop(columns=o_vals.columns)
    df = df.merge(o_vals.reset_index(), on='id_o')
    return df
 
def fill_d_values(master_df):
    df = master_df.copy()
    d_cols = [col for col in df.columns if col[-2:] == '_d']
    d_vals = df[d_cols].groupby('id_d').first()
    df = df.drop(columns=d_vals.columns)
    df = df.merge(d_vals.reset_index(), on='id_d')
    return df

def fill_nan_with_zero(master_df, columns):
    df = master_df.copy()
    for col in columns:
        df[col] = df[col].fillna(0)
    return df

def check_for_null(master_df):
    if master_df.isnull().any().any():
        null_columns = master_df.columns[master_df.isnull().any()].tolist()
        raise ValueError(f'These columns have null values: {null_columns}')

def load_base_records():
    path = os.path.join(configs.box_data_dir, 'Data/railOD_TravelTimesAndFares.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'     , 'id_o'),
        ('D_MSTN_ID'     , 'id_d'),
        ('O_PRIMARY_NAME', 'o')   ,
        ('D_PRIMARY_NAME', 'd')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    df = df[~df.o.isin(excluded_stations)]
    df = df[~df.d.isin(excluded_stations)]
    df = df[df.o != df.d]
    return df

def load_station_points():
    path = os.path.join(configs.box_data_dir, 'Data/RailStationsEntrances/RailStations2023.geojson')
    gdf = gpd.read_file(path)
    columns = OrderedDict([
        ('STATIONNAM'        , 'station_name')       ,
        ('geometry'          , 'geometry')           ,
        ])
    gdf = trim_and_rename_columns(gdf, columns)
    # Ensure station names align with those in the master df
    gdf.station_name = gdf.station_name.map(station_entrances_station_name_map)
    # Add CRS from shapefile where WMATA Lambert conformal conic defintion is stored (non-standard)
    path = os.path.join(configs.box_data_dir, 'Data/RailStationsEntrances/RailStationEntrances2023.shp')
    shapefile = gpd.read_file(path)
    gdf.crs = shapefile.crs
    # Reproject into WGS84
    gdf = gdf.to_crs(4326)
    return gdf

def add_station_points_to_base_records(master_df):
    gdf = load_station_points()
    # Merge origins
    master_df = master_df.merge(gdf.rename(columns={'station_name':'o', 'geometry':'geometry_o'}), on='o', how='left')
    # Merge origins
    master_df = master_df.merge(gdf.rename(columns={'station_name':'d', 'geometry':'geometry_d'}), on='d', how='left')
    return master_df

def load_travel_time_and_fares(master_df):
    path = os.path.join(configs.box_data_dir, 'Data/railOD_TravelTimesAndFares.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'    , 'id_o')            ,
        ('D_MSTN_ID'    , 'id_d')            ,
        ('COMP_MILE'    , 'composite_miles_od')     ,
        ('PEAK_FARE'    , 'peak_fare_od')    ,
        ('OFF_PEAK_FARE', 'off_peak_fare_od'),
        ('SD_FARE'      , 'sd_fare_od')      ,
        ('TRAVEL_TIME'  , 'travel_time_od')  ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    return master_df

def load_track_miles(master_df):
    path = os.path.join(configs.box_data_dir, 'Data/railOD_trackMiles_spring2022.xlsx')
    df = pd.read_excel(path, header=1, index_col=0)
    df = df.stack().rename_axis(('O', 'D')).reset_index(name="track_miles_od")
    columns = OrderedDict([
        ('O'                 , 'o')                  ,
        ('D'                 , 'd')                  ,
        ('track_miles_od'    , 'track_miles_od')     ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Ensure station names align with those in the master df
    df.o = df.o.map(track_miles_station_name_map)
    df.d = df.d.map(track_miles_station_name_map)
    master_df = merge_with_master(master_df, df, on=['o', 'd'])
    return master_df

def load_am_ridership(master_df):
    # path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_am_dataframe.csv')
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/am_dataframe_new2.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                  , 'id_d')                  ,
        ('ID_O'                  , 'id_o')                  ,
        # ('track_miles'           , 'track_miles_od')        , # Don't have from this source for station pairs without trips
        # ('pairs'                 , 'pairs')                 ,
        ('passengers'            , 'am_ridership_od')       ,
        # ('riders_miles'          , 'riders_miles')          ,
        ('AVG_TRAINS_D'          , 'trains_per_hr_peak_d')          ,
        ('AVG_TRAINS_O'          , 'trains_per_hr_peak_o')          ,
        # ('peak_fare_per_mile'    , 'peak_fare_per_mile')    ,
        # ('new_auto_tt2'          , 'auto_tt_od')          , # Don't have from this source for station pairs without trips
        # ('new_auto_tt_per_mile2' , 'new_auto_tt_per_mile2') ,
        # ('bus_tt_per_mile'       , 'bus_tt_per_mile_od')       ,
        ('proportionhouses_D'    , 'proportion_houses_d')    ,
        ('Total Households_D'    , 'total_households_within_half_mi_d')    ,
        ('proportionhouses_O'    , 'proportion_houses_o')    ,
        ('Total Households_O'    , 'total_households_within_half_mi_o')    ,
        ('parking_user'          , 'am_parking_user_od')    ,
        ('PARKING_CAPACITY_D'    , 'parking_capacity_d')    ,
        ('PARKING_CAPACITY_O'    , 'parking_capacity_o')    ,
        ('bus_line_count_D'      , 'bus_line_count_d')      ,
        ('bus_stop_count_D'      , 'bus_stop_count_d')      ,
        ('bus_line_count_O'      , 'bus_line_count_o')      ,
        ('bus_stop_count_O'      , 'bus_stop_count_o')      ,
        ('All_Jobs_D'            , 'total_jobs_within_half_mi_d')            ,
        ('All_Jobs_O'            , 'total_jobs_within_half_mi_o')            ,
        ('distance_to_core_D'    , 'miles_to_core_d')    ,
        ('distance_to_core_O'    , 'miles_to_core_o')    ,
        ('terminal_dummy_2023_D' , 'terminal_dummy_2023_d') ,
        ('terminal_dummy_2023_O' , 'terminal_dummy_2023_o') ,
        # ('log_passengers'        , 'log_passengers')        ,
        # ('log_riders_miles'      , 'log_riders_miles')      ,
        # ('log_AVG_TRAINS_O'      , 'log_avg_trains_o')      ,
        # ('log_AVG_TRAINS_D'      , 'log_avg_trains_d')      ,
        # ('log_peak_fare_per_mile', 'log_peak_fare_per_mile'),
        # ('log_auto_tt2'          , 'log_auto_tt2')          ,
        # ('log_auto_tt_per_mile_2', 'log_auto_tt_per_mile_2'),
        # ('log_bus_tt_per_mile'   , 'log_bus_tt_per_mile')   ,
        # ('log_proportionhouses_O', 'log_proportionhouses_o'),
        # ('log_Total Households_O', 'log_total households_o'),
        # ('log_proportionhouses_D', 'log_proportionhouses_d'),
        # ('log_Total Households_D', 'log_total households_d'),
        # ('log_parking_user'      , 'log_parking_user')      ,
        # ('log_PARKING_CAPACITY_O', 'log_parking_capacity_o'),
        # ('log_PARKING_CAPACITY_D', 'log_parking_capacity_d'),
        # ('log_bus_line_count_O'  , 'log_bus_line_count_o')  ,
        # ('log_bus_stop_count_O'  , 'log_bus_stop_count_o')  ,
        # ('log_bus_line_count_D'  , 'log_bus_line_count_d')  ,
        # ('log_bus_stop_count_D'  , 'log_bus_stop_count_d')  ,
        # ('log_All_Jobs_O'        , 'log_all_jobs_o')        ,
        # ('log_All_Jobs_D'        , 'log_all_jobs_d')        ,
        # ('log_distance_to_core_O', 'log_distance_to_core_o'),
        # ('log_distance_to_core_D', 'log_distance_to_core_d'),
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    # Fill o and d values from other pairs
    master_df = fill_o_values(master_df)
    master_df = fill_d_values(master_df)
    # Fill od values with 0
    fill_na_columns = [
        'am_ridership_od',
        'am_parking_user_od',
        ]
    master_df = fill_nan_with_zero(master_df, fill_na_columns)
    return master_df


def load_pm_ridership(master_df):
    # path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_pm_dataframe.csv')
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/pm_dataframe_new2.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'pm_ridership_od')          ,
        ('parking_user'             , 'pm_parking_user_od')          ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    fill_na_columns = [
        'pm_ridership_od',
        'pm_parking_user_od',
        ]
    master_df = fill_nan_with_zero(master_df, fill_na_columns)
    return master_df


def load_off_peak_ridership(master_df):
    # path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_off_dataframe.csv')
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/off_dataframe_new2.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'off_peak_ridership_od')    ,
        ('parking_user'             , 'off_peak_parking_user_od')          ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    fill_na_columns = [
        'off_peak_ridership_od',
        'off_peak_parking_user_od',
        ]
    master_df = fill_nan_with_zero(master_df, fill_na_columns)
    return master_df


def calculate_total_ridership_and_parking_users(master_df):
    master_df['total_ridership_od'] = master_df[[
        'am_ridership_od',
        'pm_ridership_od',
        'off_peak_ridership_od',
    ]].sum(axis=1)
    master_df['total_parking_user_od'] = master_df[[
        'am_parking_user_od',
        'pm_parking_user_od',
        'off_peak_parking_user_od',
    ]].sum(axis=1)
    return master_df


def load_am_auto_travel_time(master_df):
    path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Interpolated Auto Travel Times/output/am_interpolated_auto_times.csv')
    df = pd.read_csv(path)
    df['id_o'] = df.pairs.apply(lambda x: x.split('0M')[0])
    df['id_d'] = df.pairs.apply(lambda x: 'M' + x.split('0M')[1])
    columns = OrderedDict([
        ('id_o'                     , 'id_o')                     ,
        ('id_d'                     , 'id_d')                     ,
        ('new_auto_tt2'             , 'am_auto_tt_od')            ,
        ('new_auto_tt_per_mile2'    , 'am_auto_tt_per_track_mile_od')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    return master_df


def load_pm_auto_travel_time(master_df):
    path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Interpolated Auto Travel Times/output/pm_interpolated_auto_times.csv')
    df = pd.read_csv(path)
    df['id_o'] = df.pairs.apply(lambda x: x.split('0M')[0])
    df['id_d'] = df.pairs.apply(lambda x: 'M' + x.split('0M')[1])
    columns = OrderedDict([
        ('id_o'                     , 'id_o')                     ,
        ('id_d'                     , 'id_d')                     ,
        ('new_auto_tt2'             , 'pm_auto_tt_od')            ,
        ('new_auto_tt_per_mile2'    , 'pm_auto_tt_per_track_mile_od')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    # Fill blank values with am travel times
    master_df.pm_auto_tt_od = master_df.pm_auto_tt_od.fillna(master_df.am_auto_tt_od)
    return master_df


def load_off_peak_auto_travel_time(master_df):
    path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Interpolated Auto Travel Times/output/off_interpolated_auto_times.csv')
    df = pd.read_csv(path)
    df['id_o'] = df.pairs.apply(lambda x: x.split('0M')[0])
    df['id_d'] = df.pairs.apply(lambda x: 'M' + x.split('0M')[1])
    columns = OrderedDict([
        ('id_o'                     , 'id_o')                           ,
        ('id_d'                     , 'id_d')                           ,
        ('new_auto_tt2'             , 'off_peak_auto_tt_od')            ,
        ('new_auto_tt_per_mile2'    , 'off_peak_auto_tt_per_track_mile_od')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    return master_df


def load_bus_travel_time(master_df):
    # path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Bus Travel Time/output/busttpermile_ML.xlsx')
    path = os.path.join(configs.box_data_dir, 'Data/OD Bus Travel Times Flat MSTN.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'                     , 'id_d')                     ,
        ('D_MSTN_ID'                     , 'id_o')                     ,
        ('Travel Time'                   , 'bus_tt_od')                ,
        ('Transfers'                     , 'bus_transfers_od')         ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    fill_na_columns = [
        'bus_transfers_od',
        ]
    master_df = fill_nan_with_zero(master_df, fill_na_columns)
    master_df = fill_nan_with_ols(master_df, 'off_peak_auto_tt_od', 'bus_tt_od')
    return master_df


def load_auto_miles(master_df):
    path = os.path.join(configs.box_data_dir, 'Data/25_35_drive_times_distances.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('origins'                  , 'o')               ,
        ('destinations'             , 'd')               ,
        ('speed_mph'                , 'auto_speed_od')   ,
        ('distance'                 , 'auto_miles_od')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    df.o = df.o.map(auto_miles_station_name_map)
    df.d = df.d.map(auto_miles_station_name_map)
    master_df = merge_with_master(master_df, df, on=['o', 'd'])
    return master_df


def load_m25_stations(master_df):
    master_df = master_df.copy()
    path = os.path.join(configs.box_data_dir, 'Auto _ bus travel time+M25 station/Rail Stations with M25.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('ID'                     , 'id')                     ,
        ('METRO2025'              , 'm25_station')            ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Merge origins
    master_df = master_df.merge(df.rename(columns={'m25_station':'m25_station_o', 'id':'id_o'}), on='id_o', how='left')
    master_df.m25_station_o = master_df.m25_station_o.fillna(0)
    # Merge destinations
    master_df = master_df.merge(df.rename(columns={'m25_station':'m25_station_d', 'id':'id_d'}), on='id_d', how='left')
    master_df.m25_station_d = master_df.m25_station_d.fillna(0)
    return master_df


def load_median_hh_income(master_df):
    master_df = master_df.copy()
    path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Median Household Income/output/proportional_walkshed_household_income_updated.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('Name_1'                     , 'station')            ,
        ('Median household income'    , 'median_hh_income')   ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Fill nan with average across column
    df.median_hh_income = df.median_hh_income.fillna(df.median_hh_income.mean())
    # Ensure station names align with those in the master df
    df.station = df.station.map(income_station_name_map)
    # Merge origins
    master_df = master_df.merge(df.rename(columns={'median_hh_income':'median_hh_income_o', 'station':'o'}), on='o', how='left')
    # Merge destinations
    master_df = master_df.merge(df.rename(columns={'median_hh_income':'median_hh_income_d', 'station':'d'}), on='d', how='left')
    return master_df


def load_nine_to_five_jobs(master_df):
    master_df = master_df.copy()
    path = os.path.join(configs.box_data_dir, 'Summation_ninetofive_workers/number ninetofive_workers_stations.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('STATIONNM'                     , 'station')            ,
        ('Total Nine to Five workers'    , 'nine_to_five_jobs')  ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Ensure station names align with those in the master df
    df.station = df.station.map(job_station_name_map)
    # Merge origins
    master_df = master_df.merge(df.rename(columns={'nine_to_five_jobs':'nine_to_five_jobs_o', 'station':'o'}), on='o', how='left')
    # Merge destinations
    master_df = master_df.merge(df.rename(columns={'nine_to_five_jobs':'nine_to_five_jobs_d', 'station':'d'}), on='d', how='left')
    return master_df


def load_night_and_weekend_jobs(master_df):
    master_df = master_df.copy()
    path = os.path.join(configs.box_data_dir, 'Summation_nightjob_bufstation/number of nightjobs_stations.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('STATIONNM'                     , 'station')            ,
        ('Total night and Weekend Jobs'  , 'night_weekend_jobs') ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Ensure station names align with those in the master df
    df.station = df.station.map(job_station_name_map)
    # Merge origins
    master_df = master_df.merge(df.rename(columns={'night_weekend_jobs':'night_weekend_jobs_o', 'station':'o'}), on='o', how='left')
    # Merge destinations
    master_df = master_df.merge(df.rename(columns={'night_weekend_jobs':'night_weekend_jobs_d', 'station':'d'}), on='d', how='left')
    return master_df


def load_school_jobs(master_df):
    master_df = master_df.copy()
    path = os.path.join(configs.box_data_dir, 'Summation_educationjobs_bufstation/number of education_jobs_stations.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('STATIONNM'                     , 'station')            ,
        ('education jobs'                , 'school_jobs')        ,
        ])
    df = trim_and_rename_columns(df, columns)
    # Ensure station names align with those in the master df
    df.station = df.station.map(job_station_name_map)
    # Merge origins
    master_df = master_df.merge(df.rename(columns={'school_jobs':'school_jobs_o', 'station':'o'}), on='o', how='left')
    # Merge destinations
    master_df = master_df.merge(df.rename(columns={'school_jobs':'school_jobs_d', 'station':'d'}), on='d', how='left')
    return master_df


def load_sop(master_df):
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/am_dataframe_sop.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                  , 'id_d')                  ,
        ('ID_O'                  , 'id_o')                  ,
        ('form3norm_x'           , 'sop_form_norm_o')       ,
        ('dens2norm_x'           , 'sop_dens_norm_o')       ,
        ('prox3norm_x'           , 'sop_prox_norm_o')       ,
        ('conn6norm_x'           , 'sop_conn_norm_o')       ,
        ('parks2norm_x'          , 'sop_park_norm_o')       ,
        ('peds4norm_x'           , 'sop_peds_norm_o')       ,
        ('safenorm_x'            , 'sop_safe_norm_o')       ,
        ('traffic5norm_x'        , 'sop_traf_norm_o')       ,
        ('aesttot3norm_x'        , 'sop_aest_norm_o')       ,
        ('paf2norm_x'            , 'sop_recr_norm_o')       ,
        ('sop7norm_x'            , 'sop_totl_norm_o')       ,
        ('form3norm_y'           , 'sop_form_norm_d')       ,
        ('dens2norm_y'           , 'sop_dens_norm_d')       ,
        ('prox3norm_y'           , 'sop_prox_norm_d')       ,
        ('conn6norm_y'           , 'sop_conn_norm_d')       ,
        ('parks2norm_y'          , 'sop_park_norm_d')       ,
        ('peds4norm_y'           , 'sop_peds_norm_d')       ,
        ('safenorm_y'            , 'sop_safe_norm_d')       ,
        ('traffic5norm_y'        , 'sop_traf_norm_d')       ,
        ('aesttot3norm_y'        , 'sop_aest_norm_d')       ,
        ('paf2norm_y'            , 'sop_recr_norm_d')       ,
        ('sop7norm_y'            , 'sop_totl_norm_d')       ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    # Fill o and d values from other pairs
    master_df = fill_o_values(master_df)
    master_df = fill_d_values(master_df)
    # Fill nan with averages across columns
    # This is necessary because the Arlington Cemetary and National Airport stations have no SOP scores
    for _, col in columns.items():
        if 'sop' in col:
            master_df[col] = master_df[col].fillna(master_df[col].mean())
    return master_df


def calculate_sums_from_columns(master_df):
    sums = {
        'all_jobs_o': ('nine_to_five_jobs_o', 'night_weekend_jobs_o'),
        'all_jobs_d': ('nine_to_five_jobs_d', 'night_weekend_jobs_d'),
    }
    for col, (a,b) in sums.items():
        master_df[col] = master_df[a] + master_df[b]
    return master_df

def calculate_rates_from_constants(master_df):
    rates = {
        'total_households_within_half_mi_1000s_o': ('total_households_within_half_mi_o', 1000),
        'total_households_within_half_mi_1000s_d': ('total_households_within_half_mi_d', 1000),
        'all_jobs_1000s_o': ('all_jobs_o', 1000),
        'all_jobs_1000s_d': ('all_jobs_d', 1000),
    }
    for col, (a,b) in rates.items():
        master_df[col] = master_df[a] / b
    return master_df


def calculate_rates_from_columns(master_df):
    rates = {
        'peak_fare_per_track_mile_od': ('peak_fare_od','track_miles_od'),
        'off_peak_fare_per_track_mile_od': ('off_peak_fare_od','track_miles_od'),
        'bus_tt_per_track_mile_od': ('bus_tt_od', 'track_miles_od'),
    }
    for col, (a,b) in rates.items():
        master_df[col] = master_df[a] / master_df[b]
    return master_df


def calculate_interactions(master_df):
    interactions = {
        'm25_station_o*m25_station_d': ('m25_station_o','m25_station_d'),
    }
    for col, (a,b) in interactions.items():
        master_df[col] = master_df[a] * master_df[b]
    return master_df


def calculate_ln_transformations(master_df):
    transformations = [
        'peak_fare_per_track_mile_od',
        'off_peak_fare_per_track_mile_od',
        'am_auto_tt_per_track_mile_od',
        'pm_auto_tt_per_track_mile_od',
        'off_peak_auto_tt_per_track_mile_od',
        'bus_tt_per_track_mile_od',
        'am_parking_user_od',
        'pm_parking_user_od',
        'off_peak_parking_user_od',
        'total_households_within_half_mi_1000s_o',
        'total_households_within_half_mi_1000s_d',
    ]
    for var in transformations:
        master_df[f'ln_{var}'] = np.log(master_df[var])
        # replace inf with 0
        master_df[f'ln_{var}'] = master_df[f'ln_{var}'].replace([np.inf, -np.inf], 0)
    return master_df


def develop_features():
    np.seterr(divide = 'ignore')
    df = load_base_records()
    dev_functions = [
        add_station_points_to_base_records,
        load_travel_time_and_fares,
        load_track_miles,
        load_am_ridership,
        load_pm_ridership,
        load_off_peak_ridership,
        calculate_total_ridership_and_parking_users,
        load_am_auto_travel_time,
        load_pm_auto_travel_time,
        load_off_peak_auto_travel_time,
        load_bus_travel_time,
        load_auto_miles,
        load_m25_stations,
        load_median_hh_income,
        load_nine_to_five_jobs,
        load_night_and_weekend_jobs,
        load_school_jobs,
        load_sop,
        calculate_sums_from_columns,
        calculate_rates_from_constants,
        calculate_rates_from_columns,
        calculate_interactions,
        calculate_ln_transformations,
        ]
    print(f'{len(df)} initial records')
    for func in dev_functions:
        df = func(df)
        check_for_null(df)
        print(f'{len(df)} complete records from {func.__name__}')
    np.seterr(divide = 'warn')
    return df