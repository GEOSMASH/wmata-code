import pandas as pd
import numpy as np
from spint.gravity import  BaseGravity, Gravity, Production, Attraction, Doubly
import statsmodels.api as sm
from utils import *

def inputs(df, flows, o_vars, d_vars, od_vars, cost):
    flows = prep_col(flows, df)
    o_vars = prep_cols(o_vars, df)
    d_vars = prep_cols(d_vars + od_vars, df)
    cost = prep_col(cost, df)
    return flows, o_vars, d_vars, cost

def gravity(df, flows, o_vars, d_vars, od_vars, cost, constant=True):
    if constant:
        covars = ['const'] + o_vars + d_vars + od_vars + [cost]
    else:
        covars = o_vars + d_vars + od_vars + [cost]
    flows, o_vars, d_vars, cost = inputs(df, flows, o_vars, d_vars, od_vars, cost)
    model = Gravity(flows, o_vars, d_vars, cost, 'exp', constant=constant)
    summary = summarize_gravity_model(model, covars)
    return model, summary

def ols(df, flows, o_vars, d_vars, od_vars, cost, constant=True):
    Y = df[flows]
    X = df[o_vars + d_vars + od_vars + [cost]]
    if constant:
        X = sm.add_constant(X)
    model = sm.OLS(Y,X).fit()
    summary = summarize_ols_model(model)
    return model, summary

def estimate_models(df, flows, o_vars, d_vars, od_vars, cost, constant=True):
    grav_model, grav_summary = gravity(df, flows, o_vars, d_vars, od_vars, cost, constant=constant)
    ols_model, ols_summary = ols(df, flows, o_vars, d_vars, od_vars, cost, constant=constant)
    df = combine_model_summaries(
        [grav_summary, ols_summary],
        ['Gravity', 'OLS'])
    return df