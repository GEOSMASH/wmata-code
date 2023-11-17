import pandas as pd
from collections import OrderedDict
from utils import configs
import os

excluded_stations = [
    'Reston Town Center',
    'Herndon',
    'Innovation Center',
    'Dulles Airport',
    'Loudoun Gateway',
    'Ashburn',
]

def trim_and_rename_columns(df, columns):
    df = df[list(columns.keys())]
    df = df.rename(columns=columns)
    return df

def merge_with_master(master_df, df):
    return master_df.merge(df, on=['id_o', 'id_d'], how='left')

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
    check_for_null(df)
    return df

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
    check_for_null(master_df)
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
        ('AVG_TRAINS_D'          , 'avg_trains_d')          ,
        ('AVG_TRAINS_O'          , 'avg_trains_o')          ,
        # ('peak_fare_per_mile'    , 'peak_fare_per_mile')    ,
        # ('new_auto_tt2'          , 'auto_tt_od')          , # Don't have from this source for station pairs without trips
        # ('new_auto_tt_per_mile2' , 'new_auto_tt_per_mile2') ,
        # ('bus_tt_per_mile'       , 'bus_tt_per_mile_od')       ,
        ('proportionhouses_D'    , 'proportion_houses_d')    ,
        ('Total Households_D'    , 'total_households_d')    ,
        ('proportionhouses_O'    , 'proportion_houses_o')    ,
        ('Total Households_O'    , 'total_households_o')    ,
        ('parking_user'          , 'parking_user_od')          ,
        ('PARKING_CAPACITY_D'    , 'parking_capacity_d')    ,
        ('PARKING_CAPACITY_O'    , 'parking_capacity_o')    ,
        ('bus_line_count_D'      , 'bus_line_count_d')      ,
        ('bus_stop_count_D'      , 'bus_stop_count_d')      ,
        ('bus_line_count_O'      , 'bus_line_count_o')      ,
        ('bus_stop_count_O'      , 'bus_stop_count_o')      ,
        ('All_Jobs_D'            , 'all_jobs_d')            ,
        ('All_Jobs_O'            , 'all_jobs_o')            ,
        ('distance_to_core_D'    , 'distance_to_core_d')    ,
        ('distance_to_core_O'    , 'distance_to_core_o')    ,
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
        'parking_user_od',
        ]
    master_df = fill_nan_with_zero(master_df, fill_na_columns)
    check_for_null(master_df)
    return master_df


def load_pm_ridership(master_df):
    # path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_pm_dataframe.csv')
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/pm_dataframe_new2.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'pm_ridership_od')          ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    check_for_null(master_df)
    return master_df


def load_off_peak_ridership(master_df):
    # path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_off_dataframe.csv')
    path = os.path.join(configs.box_data_dir, 'Modeling/Outputs/off_dataframe_new2.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'off_peak_ridership_od')    ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    check_for_null(master_df)
    return master_df


def calculate_total_ridership(master_df):
    master_df['total_ridership_od'] = master_df[[
        'am_ridership_od',
        'pm_ridership_od',
        'off_peak_ridership_od',
    ]].sum(axis=1)
    check_for_null(master_df)
    return master_df


def load_bus_travel_time(master_df):
    path = os.path.join(configs.box_data_dir, 'Data Preprocessing/Bus Travel Time/output/busttpermile_ML.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'                     , 'id_d')                     ,
        ('D_MSTN_ID'                     , 'id_o')                     ,
        ('Travel Time'                   , 'bus_tt_od')                ,
        ])
    df = trim_and_rename_columns(df, columns)
    master_df = merge_with_master(master_df, df)
    check_for_null(master_df)
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
    check_for_null(master_df)
    return master_df


def calculate_interactions(master_df):
    interactions = {
        'm25_station_o*m25_station_d': ('m25_station_o','m25_station_d')
    }
    for col, (a,b) in interactions.items():
        master_df[col] = master_df[a] * master_df[b]
    check_for_null(master_df)
    return master_df


def develop_features():
    df = load_base_records()
    print(len(df))
    df = load_travel_time_and_fares(df)
    print(len(df))
    df = load_am_ridership(df)
    print(len(df))
    # df = load_pm_ridership(df)
    # print(len(df))
    # df = load_off_peak_ridership(df)
    # print(len(df))
    # df = calculate_total_ridership(df)
    # print(len(df))
    # df = load_bus_travel_time(df)
    # print(len(df))
    # df = load_m25_stations(df)
    # print(len(df))
    # df = calculate_interactions(df)
    # print(len(df))

    return df
