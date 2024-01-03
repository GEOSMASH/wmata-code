import pandas as pd
import numpy as np
from spint.gravity import  BaseGravity, Gravity, Production, Attraction, Doubly
import statsmodels.api as sm
from utils import *

def inputs(df, flows, o_vars, d_vars, od_vars):
    flows = prep_col(flows, df)
    o_vars = prep_cols(o_vars, df)
    d_vars = prep_cols(d_vars, df)
    od_vars = prep_cols(od_vars, df)
    return flows, o_vars, d_vars, od_vars

def gravity(df, flows, o_vars, d_vars, od_vars, cost_func='exp', constant=True):
    if constant:
        covars = ['const'] + o_vars + d_vars + od_vars
    else:
        covars = o_vars + d_vars + od_vars
    flows, o_vars, d_vars, od_vars = inputs(df, flows, o_vars, d_vars, od_vars)
    # Force flows to be integers
    # (the inputs function will have converted zeros to very small decimals)
    flows = flows.astype(int)
    model = Gravity(flows, o_vars, d_vars, od_vars, cost_func=cost_func, constant=constant)
    summary = summarize_gravity_model(model, covars)
    return model, summary

def ols(df, flows, o_vars, d_vars, od_vars, constant=True):
    # Force flows to be integers
    # (the inputs function will have converted zeros to very small decimals)
    Y = df[flows].astype(int)
    X = df[o_vars + d_vars + od_vars]
    if constant:
        X = sm.add_constant(X)
    model = sm.OLS(Y,X).fit()
    summary = summarize_ols_model(model)
    return model, summary

def estimate_models(df, flows, o_vars, d_vars, od_vars, cost_func='exp', constant=True):
    if cost_func == None:
        cost_func = lambda x: x
    grav_model, grav_summary = gravity(df, flows, o_vars, d_vars, od_vars, cost_func=cost_func, constant=constant)
    ols_model, ols_summary = ols(df, flows, o_vars, d_vars, od_vars, constant=constant)
    df = combine_model_summaries(
        [grav_summary, ols_summary],
        ['Poisson', 'OLS'])
    return df

task_2_model_spec = {
    'flows': 'am_ridership_od',
    'o_vars': [
        'total_households_within_half_mi_1000s_o',
        'parking_capacity_o',
        'bus_line_count_o',
        'miles_to_core_o',
        'sop_totl_norm_o',
    ],
    'd_vars': [
        'all_jobs_1000s_d',
        'trains_per_hr_peak_d',
        'bus_line_count_d',
        'terminal_dummy_2023_d',
        'sop_totl_norm_d',
    ],
    'od_vars': [
        'peak_fare_per_track_mile_od',
        'am_auto_tt_per_track_mile_od',
        'bus_tt_per_track_mile_od',
        'am_parking_user_od',
        
    ],
}

task_2_no_track_mile_model_spec = {
    'flows': 'am_ridership_od',
    'o_vars': [
        'total_households_within_half_mi_1000s_o',
        'parking_capacity_o',
        'bus_line_count_o',
        'miles_to_core_o',
        # 'sop_totl_norm_o',
    ],
    'd_vars': [
        'all_jobs_d',
        'trains_per_hr_peak_d',
        'bus_line_count_d',
        'terminal_dummy_2023_d',
        # 'sop_totl_norm_d',
    ],
    'od_vars': [
        'peak_fare_od',
        'am_auto_tt_od',
        'bus_tt_od',
        'am_parking_user_od',
        
    ],
}

simplified_model_spec = {
    'flows': 'am_ridership_od',
    'o_vars': [
        'total_households_within_half_mi_1000s_o',
        'parking_capacity_o',
        'bus_line_count_o',
        'miles_to_core_o',
        'sop_totl_norm_o',
    ],
    'd_vars': [
        'all_jobs_1000s_d',
        'trains_per_hr_peak_d',
        'bus_line_count_d',
        'terminal_dummy_2023_d',
        'sop_totl_norm_d',
    ],
    'od_vars': [
        'peak_fare_od',
        'am_auto_tt_per_track_mile_od',
        'bus_tt_per_track_mile_od',
        'am_parking_user_od',
        
    ],
}