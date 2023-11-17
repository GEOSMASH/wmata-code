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

def gravity(df, flows, o_vars, d_vars, od_vars, constant=True):
    if constant:
        covars = ['const'] + o_vars + d_vars + od_vars
    else:
        covars = o_vars + d_vars + od_vars
    flows, o_vars, d_vars, od_vars = inputs(df, flows, o_vars, d_vars, od_vars)
    model = Gravity(flows, o_vars, d_vars, od_vars, 'exp', constant=constant)
    summary = summarize_gravity_model(model, covars)
    return model, summary

def ols(df, flows, o_vars, d_vars, od_vars, constant=True):
    Y = df[flows]
    X = df[o_vars + d_vars + od_vars]
    if constant:
        X = sm.add_constant(X)
    model = sm.OLS(Y,X).fit()
    summary = summarize_ols_model(model)
    return model, summary

def estimate_models(df, flows, o_vars, d_vars, od_vars, constant=True):
    grav_model, grav_summary = gravity(df, flows, o_vars, d_vars, od_vars, constant=constant)
    ols_model, ols_summary = ols(df, flows, o_vars, d_vars, od_vars, constant=constant)
    df = combine_model_summaries(
        [grav_summary, ols_summary],
        ['Gravity', 'OLS'])
    return df