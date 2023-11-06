import pandas as pd
from collections import OrderedDict
from utils import configs
import os

def trim_and_rename_columns(df, columns):
    df = df[list(columns.keys())]
    df = df.rename(columns=columns)
    return df

def merge_with_master(master_df, df):
    return master_df.merge(df, on=['id_o', 'id_d'])

def load_base_records():
    path = os.path.join(configs.box_data_dir, 'Data/railOD_TravelTimesAndFares.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'     , 'id_o'),
        ('D_MSTN_ID'     , 'id_d'),
        ('O_PRIMARY_NAME', 'o')   ,
        ('D_PRIMARY_NAME', 'd')   ,
        ])
    return trim_and_rename_columns(df, columns)

def load_travel_time_and_fares(master_df):
    path = os.path.join(configs.box_data_dir, 'Data/railOD_TravelTimesAndFares.xlsx')
    df = pd.read_excel(path)
    columns = OrderedDict([
        ('O_MSTN_ID'    , 'id_o')            ,
        ('D_MSTN_ID'    , 'id_d')            ,
        ('COMP_MILE'    , 'distance_od')     ,
        ('PEAK_FARE'    , 'peak_fare_od')    ,
        ('OFF_PEAK_FARE', 'off_peak_fare_od'),
        ('SD_FARE'      , 'sd_fare_od')      ,
        ('TRAVEL_TIME'  , 'travel_time_od')  ,
        ])
    df = trim_and_rename_columns(df, columns)
    return merge_with_master(master_df, df)

def load_am_ridership(master_df):
    path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_am_dataframe.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                  , 'id_d')                  ,
        ('ID_O'                  , 'id_o')                  ,
        ('track_miles'           , 'track_miles_od')        ,
        # ('pairs'                 , 'pairs')                 ,
        ('passengers'            , 'am_ridership_od')       ,
        # ('riders_miles'          , 'riders_miles')          ,
        ('AVG_TRAINS_D'          , 'avg_trains_d')          ,
        ('AVG_TRAINS_O'          , 'avg_trains_o')          ,
        # ('peak_fare_per_mile'    , 'peak_fare_per_mile')    ,
        ('new_auto_tt2'          , 'new_auto_tt2')          ,
        # ('new_auto_tt_per_mile2' , 'new_auto_tt_per_mile2') ,
        # ('bus_tt_per_mile'       , 'bus_tt_per_mile')       ,
        ('proportionhouses_D'    , 'proportionhouses_d')    ,
        ('Total Households_D'    , 'total households_d')    ,
        ('proportionhouses_O'    , 'proportionhouses_o')    ,
        ('Total Households_O'    , 'total households_o')    ,
        ('parking_user'          , 'parking_user')          ,
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
    return merge_with_master(master_df, df)


def load_pm_ridership(master_df):
    path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_pm_dataframe.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'pm_ridership_od')          ,
        ])
    df = trim_and_rename_columns(df, columns)
    return merge_with_master(master_df, df)


def load_off_peak_ridership(master_df):
    path = os.path.join(configs.box_data_dir, 'new_scripts_2023/WMATA_ODLURM-main/final variable sheets/all_ridership_off_dataframe.csv')
    df = pd.read_csv(path)
    columns = OrderedDict([
        ('ID_D'                     , 'id_d')                     ,
        ('ID_O'                     , 'id_o')                     ,
        ('passengers'               , 'off_peak_ridership_od')    ,
        ])
    df = trim_and_rename_columns(df, columns)
    return merge_with_master(master_df, df)


def construct_total_ridership(master_df):
    master_df['total_ridership'] = master_df[[
        'am_ridership_od',
        'pm_ridership_od',
        'off_peak_ridership_od',
    ]].sum(axis=1)
    return master_df


def develop_features():
    df = load_base_records()
    df = load_travel_time_and_fares(df)
    df = load_am_ridership(df)
    df = load_pm_ridership(df)
    df = load_off_peak_ridership(df)
    df = construct_total_ridership(df)

    
    return df
