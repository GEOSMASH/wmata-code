import pandas as pd
from collections import OrderedDict
from utils import *
from feature_dev import *
import os
import warnings


def load_trips_record():
    parquet_path = 'rail_trips.parquet'
    try:
        df = pd.read_parquet(parquet_path)
    except:
        print(f'Loading from CSV')
        path = os.path.join(configs.box_data_dir, 'Data/railTrips_withBusParkingFlags_04152022-05152022.xlsx')
        with warnings.catch_warnings(record=True):
            warnings.simplefilter("always")
            df = pd.read_excel(path, engine="openpyxl")
        df.to_parquet(parquet_path)

    columns = OrderedDict([
        ('SVC_DATE'                 , 'date'),
        ('SERIAL_NBR'               , 'serial_id'),
        ('JNY_KEY'                  , 'journey_id'),
        ('START_PLACE_NAME'         , 'o'),
        ('START_TIME'               , 'start_time_o'),
        ('END_PLACE_NAME'           , 'd'),
        ('END_TIME'                 , 'end_time_d'),
        ('FARE_INSTRUMENT_ID'       , 'farecard_id'),
        ('DESCRIPTION'              , 'farecard_desc'),
        ('RIDER_CLASS'              , 'rider_class'),
        ('FUND_TYPE'                , 'fund_type'),
        ('FARE_CENTS'               , 'fare_cents'),
        ('PRIOR_TRIP_BUS_FLAG'      , 'prior_leg_bus_flag'),
        ('PRIOR_BUS_TRIP_START_TIME', 'prior_leg_bus_start_time'),
        ('NEXT_TRIP_BUS_FLAG'       , 'next_leg_bus_flag'),
        ('NEXT_BUS_TRIP_START_TIME' , 'next_leg_bus_start_time'),
        ('PARKED_AT_ORIGIN'         , 'parked_at_origin_flag'),
        ('AUTO_START_TIME'          , 'parking_start_time'),
        ('PARKED_AT_DESTINATION'    , 'parked_at_dest_flag'),
        ('AUTO_END_TIME'            , 'parking_end_time'),
        ])
    df = trim_and_rename_columns(df, columns)
    # df = df[~df.o.isin(excluded_stations)]
    # df = df[~df.d.isin(excluded_stations)]
    # df = df[df.o != df.d]
    return df