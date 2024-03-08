import numpy as np
import pandas as pd
import yaml
from collections import namedtuple
import os

excluded_stations = [
    'Reston Town Center',
    'Herndon',
    'Innovation Center',
    'Dulles Airport',
    'Loudoun Gateway',
    'Ashburn',
]

track_miles_station_name_map = {
    'Addison Road': 'Addison Road',
    'Anacostia': 'Anacostia',
    'Archives': 'Archives',
    'Arlington Cemetery': 'Arlington Cemetery',
    'Ballston-MU': 'Ballston-MU',
    'Benning Road': 'Benning Road',
    'Bethesda': 'Bethesda',
    'Braddock Road': 'Braddock Road',
    'Branch Ave': 'Branch Ave',
    'Brookland-CUA': 'Brookland-CUA',
    'Capitol Heights': 'Capitol Heights',
    'Capitol South': 'Capitol South',
    'Cheverly': 'Cheverly',
    'Clarendon': 'Clarendon',
    'Cleveland Park': 'Cleveland Park',
    'College Park-U of Md': 'College Park-U of Md',
    'Columbia Heights': 'Columbia Heights',
    'Congress Heights': 'Congress Heights',
    'Court House': 'Court House',
    'Crystal City': 'Crystal City',
    'Deanwood': 'Deanwood',
    'Dunn Loring': 'Dunn Loring',
    'Dupont Circle': 'Dupont Circle',
    'East Falls Church': 'East Falls Church',
    'Eastern Market': 'Eastern Market',
    'Eisenhower Ave': 'Eisenhower Ave',
    'Farragut North': 'Farragut North',
    'Farragut West': 'Farragut West',
    'Federal Center SW': 'Federal Center SW',
    'Federal Triangle': 'Federal Triangle',
    'Foggy Bottom-GWU': 'Foggy Bottom-GWU',
    'Forest Glen': 'Forest Glen',
    'Fort Totten': 'Fort Totten',
    'Franconia-Springfield': 'Franconia-Springfield',
    'Friendship Heights': 'Friendship Heights',
    'Gallery Place': 'Gallery Place',
    'Georgia Ave-Petworth': 'Georgia Ave-Petworth',
    'Glenmont': 'Glenmont',
    'Greenbelt': 'Greenbelt',
    'Greensboro': 'Greensboro',
    'Grosvenor-Strathmore': 'Grosvenor-Strathmore',
    'Huntington': 'Huntington',
    'Judiciary Square': 'Judiciary Square',
    'King St-Old Town': 'King St-Old Town',
    "L'Enfant Plaza": "L'Enfant Plaza",
    'Landover': 'Landover',
    'Largo Town Center': 'Largo Town Center',
    'McLean': 'McLean',
    'McPherson Square': 'McPherson Sq',
    'Medical Center': 'Medical Center',
    'Metro Center': 'Metro Center',
    'Minnesota Ave': 'Minnesota Ave',
    'Morgan Boulevard': 'Morgan Boulevard',
    'Mt Vernon Sq': 'Mt Vernon Sq',
    'Navy Yard-Ballpark': 'Navy Yard-Ballpark',
    'Naylor Road': 'Naylor Road',
    'New Carrollton': 'New Carrollton',
    'NoMa-Gallaudet U': 'NoMa-Gallaudet U',
    'Pentagon': 'Pentagon',
    'Pentagon City': 'Pentagon City',
    'Potomac Ave': 'Potomac Ave',
    "Prince George's Plaza": "Prince George's Plaza",
    'Rhode Island Ave': 'Rhode Island Ave',
    'Rockville': 'Rockville',
    'Ronald Reagan Washington National Airport': 'Ronald Reagan Washington National Airport',
    'Rosslyn': 'Rosslyn',
    'Shady Grove': 'Shady Grove',
    'Shaw-Howard Univ': 'Shaw-Howard U',
    'Silver Spring': 'Silver Spring',
    'Smithsonian': 'Smithsonian',
    'Southern Ave': 'Southern Ave',
    'Spring Hill': 'Spring Hill',
    'Stadium-Armory': 'Stadium-Armory',
    'Suitland': 'Suitland',
    'Takoma': 'Takoma',
    'Tenleytown-AU': 'Tenleytown-AU',
    'Twinbrook': 'Twinbrook',
    'Tysons Corner': 'Tysons Corner',
    'U Street': 'U Street',
    'Union Station': 'Union Station',
    'Van Dorn Street': 'Van Dorn Street',
    'Van Ness-UDC': 'Van Ness-UDC',
    'Vienna': 'Vienna',
    'Virginia Square-GMU': 'Virginia Sq-GMU',
    'Waterfront': 'Waterfront',
    'West Falls Church': 'West Falls Church',
    'West Hyattsville': 'West Hyattsville',
    'Wheaton': 'Wheaton',
    'White Flint': 'White Flint',
    'Wiehle': 'Wiehle-Reston East',
    'Woodley Park': 'Woodley Park',
}

income_station_name_map = {
    'ADDISON ROAD-SEAT PLEASANT': 'Addison Road',
    'ANACOSTIA': 'Anacostia',
    'ARCHIVES-NAVY MEMORIAL-PENN QUARTER': 'Archives',
    'ARLINGTON CEMETERY': 'Arlington Cemetery',
    'Ashburn': 'Ashburn',
    'BALLSTON-MU': 'Ballston-MU',
    'BENNING ROAD': 'Benning Road',
    'BETHESDA': 'Bethesda',
    'BRADDOCK ROAD': 'Braddock Road',
    'BRANCH AVE': 'Branch Ave',
    'BROOKLAND-CUA': 'Brookland-CUA',
    'CAPITOL HEIGHTS': 'Capitol Heights',
    'CAPITOL SOUTH': 'Capitol South',
    'CHEVERLY': 'Cheverly',
    'CLARENDON': 'Clarendon',
    'CLEVELAND PARK': 'Cleveland Park',
    'COLLEGE PARK-U OF MD': 'College Park-U of Md',
    'COLUMBIA HEIGHTS': 'Columbia Heights',
    'CONGRESS HEIGHTS': 'Congress Heights',
    'COURT HOUSE': 'Court House',
    'CRYSTAL CITY': 'Crystal City',
    'DEANWOOD': 'Deanwood',
    'DUNN LORING-MERRIFIELD': 'Dunn Loring',
    'DUPONT CIRCLE': 'Dupont Circle',
    'EAST FALLS CHURCH': 'East Falls Church',
    'EASTERN MARKET': 'Eastern Market',
    'EISENHOWER AVENUE': 'Eisenhower Ave',
    'FARRAGUT NORTH': 'Farragut North',
    'FARRAGUT WEST': 'Farragut West',
    'FEDERAL CENTER SW': 'Federal Center SW',
    'FEDERAL TRIANGLE': 'Federal Triangle',
    'FOGGY BOTTOM-GWU': 'Foggy Bottom-GWU',
    'FOREST GLEN': 'Forest Glen',
    'FORT TOTTEN': 'Fort Totten',
    'FRANCONIA-SPRINGFIELD': 'Franconia-Springfield',
    'FRIENDSHIP HEIGHTS': 'Friendship Heights',
    'GALLERY PL-CHINATOWN': 'Gallery Place',
    'GEORGIA AVE-PETWORTH': 'Georgia Ave-Petworth',
    'GLENMONT': 'Glenmont',
    'GREENBELT': 'Greenbelt',
    'GREENSBORO': 'Greensboro',
    'GROSVENOR-STRATHMORE': 'Grosvenor-Strathmore',
    'Herndon': 'Herndon',
    'HUNTINGTON': 'Huntington',
    'Innovation Center': 'Innovation Center',
    'JUDICIARY SQUARE': 'Judiciary Square',
    'KING ST-OLD TOWN': 'King St-Old Town',
    "L'ENFANT PLAZA": "L'Enfant Plaza",
    'LANDOVER': 'Landover',
    'LARGO TOWN CENTER': 'Largo Town Center',
    'Loudoun Gateway': 'Loudoun Gateway',
    'MCLEAN': 'McLean',
    'MCPHERSON SQUARE': 'McPherson Sq',
    'MEDICAL CENTER': 'Medical Center',
    'METRO CENTER': 'Metro Center',
    'MINNESOTA AVE': 'Minnesota Ave',
    'MORGAN BOULEVARD': 'Morgan Boulevard',
    'MT VERNON SQ 7TH ST-CONVENTION CENTER': 'Mt Vernon Sq',
    'NAVY YARD-BALLPARK': 'Navy Yard-Ballpark',
    'NAYLOR ROAD': 'Naylor Road',
    'NEW CARROLLTON': 'New Carrollton',
    'NOMA-GALLAUDET': 'NoMa-Gallaudet U',
    'PENTAGON': 'Pentagon',
    'PENTAGON CITY': 'Pentagon City',
    'POTOMAC AVE': 'Potomac Ave',
    "PRINCE GEORGE'S PLAZA": "Prince George's Plaza",
    'RHODE ISLAND AVE-BRENTWOOD': 'Rhode Island Ave',
    'ROCKVILLE': 'Rockville',
    'RONALD REAGAN WASHINGTON NATIONAL AIRPORT': 'Ronald Reagan Washington National Airport',
    'ROSSLYN': 'Rosslyn',
    'Reston Town Center': 'Reston Town Center',
    'SHADY GROVE': 'Shady Grove',
    'SHAW-HOWARD U': 'Shaw-Howard U',
    'SILVER SPRING': 'Silver Spring',
    'SMITHSONIAN': 'Smithsonian',
    'SOUTHERN AVENUE': 'Southern Ave',
    'SPRING HILL': 'Spring Hill',
    'STADIUM-ARMORY': 'Stadium-Armory',
    'SUITLAND': 'Suitland',
    'TAKOMA': 'Takoma',
    'TENLEYTOWN-AU': 'Tenleytown-AU',
    'TWINBROOK': 'Twinbrook',
    'TYSONS CORNER': 'Tysons Corner',
    'U STREET/AFRICAN-AMER CIVIL WAR MEMORIAL/CARDOZO': 'U Street',
    'UNION STATION': 'Union Station',
    'VAN DORN STREET': 'Van Dorn Street',
    'VAN NESS-UDC': 'Van Ness-UDC',
    'VIENNA/FAIRFAX-GMU': 'Vienna',
    'VIRGINIA SQUARE-GMU': 'Virginia Sq-GMU',
    'WATERFRONT': 'Waterfront',
    'WEST FALLS CHURCH-VT/UVA': 'West Falls Church',
    'WEST HYATTSVILLE': 'West Hyattsville',
    'WHEATON': 'Wheaton',
    'WHITE FLINT': 'White Flint',
    'WIEHLE-RESTON EAST': 'Wiehle-Reston East',
    'WOODLEY PARK-ZOO/ADAMS MORGAN': 'Woodley Park',
    'Washington Dulles International Airport': 'Dulles Airport',
}

job_station_name_map = {
    'ADDISON ROAD-SEAT PLEASANT': 'Addison Road',
    'ANACOSTIA': 'Anacostia',
    'ARCHIVES-NAVY MEMORIAL-PENN QUARTER': 'Archives',
    'ARLINGTON CEMETERY': 'Arlington Cemetery',
    'ASHBURN': 'Ashburn',
    'BALLSTON-MU': 'Ballston-MU',
    'BENNING ROAD': 'Benning Road',
    'BETHESDA': 'Bethesda',
    'BRADDOCK ROAD': 'Braddock Road',
    'BRANCH AVE': 'Branch Ave',
    'BROOKLAND-CUA': 'Brookland-CUA',
    'CAPITOL HEIGHTS': 'Capitol Heights',
    'CAPITOL SOUTH': 'Capitol South',
    'CHEVERLY': 'Cheverly',
    'CLARENDON': 'Clarendon',
    'CLEVELAND PARK': 'Cleveland Park',
    'COLLEGE PARK-U OF MD': 'College Park-U of Md',
    'COLUMBIA HEIGHTS': 'Columbia Heights',
    'CONGRESS HEIGHTS': 'Congress Heights',
    'COURT HOUSE': 'Court House',
    'CRYSTAL CITY': 'Crystal City',
    'DEANWOOD': 'Deanwood',
    'DUNN LORING-MERRIFIELD': 'Dunn Loring',
    'DUPONT CIRCLE': 'Dupont Circle',
    'EAST FALLS CHURCH': 'East Falls Church',
    'EASTERN MARKET': 'Eastern Market',
    'EISENHOWER AVENUE': 'Eisenhower Ave',
    'FARRAGUT NORTH': 'Farragut North',
    'FARRAGUT WEST': 'Farragut West',
    'FEDERAL CENTER SW': 'Federal Center SW',
    'FEDERAL TRIANGLE': 'Federal Triangle',
    'FOGGY BOTTOM-GWU': 'Foggy Bottom-GWU',
    'FOREST GLEN': 'Forest Glen',
    'FORT TOTTEN': 'Fort Totten',
    'FRANCONIA-SPRINGFIELD': 'Franconia-Springfield',
    'FRIENDSHIP HEIGHTS': 'Friendship Heights',
    'GALLERY PLACE-CHINATOWN': 'Gallery Place',
    'GEORGIA AVENUE-PETWORTH': 'Georgia Ave-Petworth',
    'GLENMONT': 'Glenmont',
    'GREENBELT': 'Greenbelt',
    'GREENSBORO': 'Greensboro',
    'GROSVENOR-STRATHMORE': 'Grosvenor-Strathmore',
    'HERNDON': 'Herndon',
    'HUNTINGTON': 'Huntington',
    'INNOVATION CENTER': 'Innovation Center',
    'JUDICIARY SQUARE': 'Judiciary Square',
    'KING STREET-OLD TOWN': 'King St-Old Town',
    "L'ENFANT PLAZA": "L'Enfant Plaza",
    'LANDOVER': 'Landover',
    'DOWNTOWN LARGO': 'Largo Town Center',
    'LOUDOUN GATEWAY': 'Loudoun Gateway',
    'MCLEAN': 'McLean',
    'MCPHERSON SQUARE': 'McPherson Sq',
    'MEDICAL CENTER': 'Medical Center',
    'METRO CENTER': 'Metro Center',
    'MINNESOTA AVENUE': 'Minnesota Ave',
    'MORGAN BOULEVARD': 'Morgan Boulevard',
    'MT VERNON SQ 7TH ST-CONVENTION CENTER': 'Mt Vernon Sq',
    'NAVY YARD-BALLPARK': 'Navy Yard-Ballpark',
    'NAYLOR ROAD': 'Naylor Road',
    'NEW CARROLLTON': 'New Carrollton',
    'NOMA-GALLAUDET U': 'NoMa-Gallaudet U',
    'PENTAGON': 'Pentagon',
    'PENTAGON CITY': 'Pentagon City',
    'POTOMAC AVE': 'Potomac Ave',
    'HYATTSVILLE CROSSING': "Prince George's Plaza",
    'RHODE ISLAND AVE-BRENTWOOD': 'Rhode Island Ave',
    'ROCKVILLE': 'Rockville',
    'RONALD REAGAN WASHINGTON NATIONAL AIRPORT': 'Ronald Reagan Washington National Airport',
    'RESTON': 'Reston Town Center',
    'ROSSLYN': 'Rosslyn',
    'SHADY GROVE': 'Shady Grove',
    'SHAW-HOWARD UNIVERSITY': 'Shaw-Howard U',
    'SILVER SPRING': 'Silver Spring',
    'SMITHSONIAN': 'Smithsonian',
    'SOUTHERN AVENUE': 'Southern Ave',
    'SPRING HILL': 'Spring Hill',
    'STADIUM-ARMORY': 'Stadium-Armory',
    'SUITLAND': 'Suitland',
    'TAKOMA': 'Takoma',
    'TENLEYTOWN-AU': 'Tenleytown-AU',
    'TWINBROOK': 'Twinbrook',
    'TYSONS': 'Tysons Corner',
    'U STREET/AFRICAN-AMER CIVIL WAR MEMORIAL/CARDOZO': 'U Street',
    'UNION STATION': 'Union Station',
    'VAN DORN STREET': 'Van Dorn Street',
    'VAN NESS-UDC': 'Van Ness-UDC',
    'VIENNA/FAIRFAX-GMU': 'Vienna',
    'VIRGINIA SQUARE-GMU': 'Virginia Sq-GMU',
    'WATERFRONT': 'Waterfront',
    'WEST FALLS CHURCH-VT/UVA': 'West Falls Church',
    'WEST HYATTSVILLE': 'West Hyattsville',
    'WHEATON': 'Wheaton',
    'NORTH BETHESDA': 'White Flint',
    'WIEHLE-RESTON EAST': 'Wiehle-Reston East',
    'WOODLEY PARK-ZOO/ADAMS MORGAN': 'Woodley Park',
    'WASHINGTON DULLES INTERNATIONAL AIRPORT': 'Dulles Airport',
}

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
    df = df.copy()
    x = df[col].values.reshape((-1,1))
    x[x == 0] = 0.000001
    return x

def prep_cols(cols, df):
    df = df.copy()
    x = np.hstack([df[col].values.reshape((-1,1)) for col in cols])
    x[x == 0] = 0.000001
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