import geopandas as gpd

# Utility function to load the walksheds for urban - suburban splits into geopandas gdf and calculate the intersection.

p5 = '../../Data/unions/Union_walkshades.shp'
p75 = '../../Data/walksheds_75mile_overlapping.geojson'

def load_walksheds():
    wksp5 = gpd.read_file(p5)
    wksp75 = gpd.read_file(p75)
    
    wksp5 = wksp5.to_crs("EPSG:4326")
    wksp75 = wksp75.to_crs("EPSG:4326")
    
    wksp5['Name_1']=wksp5['Name_1'].str.replace(' : 0 - 2640','')
    wksp5['Name_1']=wksp5['Name_1'].str.replace(' : 0 - 22.4525758392805','')

    wksp75['Name_1']=wksp75['Name_1'].str.replace(' : 0 - 2640','')
    wksp75['Name_1']=wksp75['Name_1'].str.replace(' : 0 - 22.4525758392805','')
    
    return wksp5, wksp75
    
def overlay_wks(stn_var):
    wksp5, wksp75 = load_walksheds()
    intersectp5 = gpd.overlay(stn_var, wksp5, how='intersection')
    intersectp75 = gpd.overlay(stn_var, wksp75, how='intersection')
    
    return intersectp5, intersectp75

def reformat(df, col, new_col): 
    out = df.rename(columns={col:new_col})
    out.drop(col, inplace=True)
    return out