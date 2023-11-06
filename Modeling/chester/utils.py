import numpy as np
import pandas as pd
import yaml
from collections import namedtuple
import os


def load_configs():
    # Load the YAML data from the file
    path = os.path.join(os.path.dirname(__file__), 'config.yaml')
    with open(path, "r") as yaml_file:
        yaml_data = yaml.safe_load(yaml_file)
    # Define the named tuple structure (use the same keys as your dictionary)
    Configs = namedtuple("Configs", yaml_data.keys())
    # Convert the dictionary to a named tuple
    configs = Configs(**yaml_data)
    return configs

configs = load_configs()


def prep_col(col, df):
    x = df[col].values.reshape((-1,1))
    x[x == 0] = 1
    return x

def prep_cols(cols, df):
    x = np.hstack([df[col].values.reshape((-1,1)) for col in cols])
    x[x == 0] = 1
    return x

def model_summary(covars, params, pvalues, aic, R2=None, pseudoR2=None):
    df = pd.DataFrame({
            'coef': np.round(params, 2),
            'P': np.round(pvalues, 3),
        }, index=covars)
    df.loc['AIC'] = pd.Series({'coef':np.round(aic, 2)})
    if R2:
        df.loc['R2'] = pd.Series({'coef':np.round(R2, 2)})
    if pseudoR2:
        df.loc['pseudoR2'] = pd.Series({'coef':np.round(pseudoR2, 2)})
    df = df.replace(np.nan, '')
    return df

def combine_model_summaries(model_summaries, labels):
    df = pd.concat(model_summaries, axis=1)
    summary_cols = list(model_summaries[0].columns)
    tuples = [
        (labels[0], summary_cols[0]), (labels[0], summary_cols[1]),
        (labels[1], summary_cols[0]), (labels[1], summary_cols[1])
    ]
    df.columns = pd.MultiIndex.from_tuples(tuples)
    return df

def summarize_ols_model(model):
    return model_summary(
        covars=model.params.index, 
        params=model.params.values, 
        pvalues=model.pvalues.values, 
        R2=model.rsquared, 
        aic=model.aic)

def summarize_gravity_model(model, covars):
    return model_summary(
        covars=covars, 
        params=model.params, 
        pvalues=model.pvalues, 
        pseudoR2=model.pseudoR2, 
        aic=model.AIC)

def combine_model_summaries(model_summaries, labels):
    df = pd.concat(model_summaries, axis=1)
    summary_cols = list(model_summaries[0].columns)
    tuples = [
        (labels[0], summary_cols[0]), (labels[0], summary_cols[1]),
        (labels[1], summary_cols[0]), (labels[1], summary_cols[1])
    ]
    df.columns = pd.MultiIndex.from_tuples(tuples)
    df = df.replace(np.nan, '')
    return df