import requests
import shapely as sh
import pickle
from collections import OrderedDict
import numpy as np
import pandas as pd

def parse_results(results):
    results = results['results']
    parsed_results = {}
                
    if len(results) == 0:
        parsed_results['lat'] = 'no geocode results'
        parsed_results['lon'] = 'no geocode results'

    else:
        # Force only the first result
        results = results[:1]
    
        for i, result in enumerate(results):
            parsed_results[i] = {}
            lat = result['geometry']['location']['lat']
            lon = result['geometry']['location']['lng']
            url = f'https://maps.google.com/?q={lat},{lon}'
            parsed_results[i]['formatted_address'] = result['formatted_address']
            parsed_results[i]['lat'] = lat
            parsed_results[i]['lon'] = lon
            parsed_results[i]['location_type'] = result['geometry']['location_type']
            parsed_results[i]['maps_url'] = url

    return parsed_results

def geocode_address(address, api_key):
    geocode_url = f'https://maps.googleapis.com/maps/api/geocode/json?address={address}&key={api_key}'
    results = requests.get(geocode_url)
    results = results.json()
    results = parse_results(results)
    return results


def get_route_info(orig_lat, orig_lon, dest_lat, dest_lon, api_key, mode='driving', transit_mode=None, departure_time = 1708002000):
    """    
    Default departure time (1708002000) is Thursday, February 15, 2024 at 8am ET.
    Based on NCSG's 2024 Maryland Commuter Survey, Thursdays are the day of the week with the highest commuter demand.
    Mid-February is used as an example date because it is relatively far from commute-affecting holidays.
    Google won't successfully query transit routes for a departure time too far into the future.

    Mode options include 'driving', 'transit', 'walking', or 'bicycling'

    Transit mode options can only be used if mode is Transit. They include 'bus', 'subway', 'train' (non-subway heavy rail), 'tram' (light rail), and 'rail' (train, tram, or subway)
    """
    # With old Directions API (includes transit option)
    if transit_mode:
        geocode_url = f'https://maps.google.com/maps/api/directions/json?origin={orig_lat},{orig_lon}&destination={dest_lat},{dest_lon}&mode={mode}&transit_mode={transit_mode}&departure_time={departure_time}&key={api_key}'
    else:
        geocode_url = f'https://maps.google.com/maps/api/directions/json?origin={orig_lat},{orig_lon}&destination={dest_lat},{dest_lon}&mode={mode}&departure_time={departure_time}&key={api_key}'
    results = requests.get(geocode_url)    
    return results.json()


def query_routes(df, api_key, modes=['driving', ('transit', 'bus')], pickle_path='routing_results.pickle'):
    
    i = 0
    
    routing_results = {}
    for row in df.itertuples():
        routing_results[row.Index] = {}
        routing_results[row.Index]['lat_o'] = row.lat_o
        routing_results[row.Index]['lon_o'] = row.lon_o
        routing_results[row.Index]['lat_d'] = row.lat_d
        routing_results[row.Index]['lon_d'] = row.lon_d
        
        for mode in modes:

            # See if there is a transit mode stored in a tuple
            try:
                mode, transit_mode = mode
            except ValueError:
                transit_mode = None
        
            result = get_route_info(
                row.lat_o, row.lon_o, 
                row.lat_d, row.lon_d,
                api_key, 
                mode=mode,
                transit_mode=transit_mode,
                )
            routing_results[row.Index][mode] = result

        i += 1
        if i % 50 == 0:
            print(f'Completed {i} routes')
        
    if pickle:
        with open(pickle_path, 'wb') as handle:
            pickle.dump(routing_results, handle, protocol=pickle.HIGHEST_PROTOCOL)

    return routing_results


def open_routing_results(pickle_path='routing_results.pickle'):
    with open(pickle_path, 'rb') as handle:
        routing_results = pickle.load(handle)
    return routing_results


def decode_polyline(polyline):
    """Decodes a Polyline string into a list of lat/lng dicts.
    See the developer docs for a detailed description of this encoding:
    https://developers.google.com/maps/documentation/utilities/polylinealgorithm
    :param polyline: An encoded polyline
    :type polyline: string
    :rtype: list of dicts with lat/lng keys
    """
    points = []
    index = lat = lng = 0

    while index < len(polyline):
        result = 1
        shift = 0
        while True:
            b = ord(polyline[index]) - 63 - 1
            index += 1
            result += b << shift
            shift += 5
            if b < 0x1f:
                break
        lat += (~result >> 1) if (result & 1) != 0 else (result >> 1)

        result = 1
        shift = 0
        while True:
            b = ord(polyline[index]) - 63 - 1
            index += 1
            result += b << shift
            shift += 5
            if b < 0x1f:
                break
        lng += ~(result >> 1) if (result & 1) != 0 else (result >> 1)

        points.append({"lat": lat * 1e-5, "lng": lng * 1e-5})
        
    linestring = sh.geometry.LineString([sh.geometry.Point(point['lng'], point['lat']) for point in points])

    return linestring


def aggregate_legs(legs):
    leg_summaries = []
    step_summaries = []
    
    for i, _ in enumerate(legs):
        
        # Summarize leg-level attributes
        leg_summary = {}
        leg_summary['distance'] = legs[i]['distance']['value']
        leg_summary['duration'] = legs[i]['duration']['value']
        if 'duration_in_traffic' in legs[i]:
            leg_summary['duration_in_traffic'] = legs[i]['duration_in_traffic']['value']
        leg_summaries.append(leg_summary)
        
        # Summarize step-level attributes
        for j, _ in enumerate(legs[i]['steps']):
            step_summary = {}
            step_summary['distance'] = legs[i]['steps'][j]['distance']['value']
            step_summary['duration'] = legs[i]['steps'][j]['duration']['value']
            if legs[i]['steps'][j]['travel_mode'] == 'TRANSIT':
                step_summary['travel_mode'] = legs[i]['steps'][j]['transit_details']['line']['vehicle']['type']
            else:
                step_summary['travel_mode'] = legs[i]['steps'][j]['travel_mode']
            step_summaries.append(step_summary)
    
    # Aggregate leg distances and durations
    leg_summaries = pd.DataFrame(leg_summaries).sum()
    
    # Aggregate step distances and durations within submodes
    step_summaries = pd.DataFrame(step_summaries)
    transit_modes = {
        'BUS':'bus',
        'HEAVY_RAIL':'heavy_rail',
        'SUBWAY':'subway',
        'TRAM':'tram',
        'WALKING':'walking',
    }
    step_summaries.travel_mode = step_summaries.travel_mode.map(transit_modes)
    step_summaries = step_summaries.groupby('travel_mode').sum().to_dict('index')
    
    return leg_summaries, step_summaries


def summarize_routes(routing_results):  
    
    summary_template = OrderedDict([
        ('lat_o', np.nan),
        ('lon_o', np.nan),
        ('lat_d', np.nan),
        ('lon_d', np.nan),

        ('google_driving_minutes', np.nan),
        ('google_driving_miles', np.nan),
        ('google_driving_path', np.nan), # Store paths as well-known text?
       
        ('google_transit_minutes', np.nan),
        ('google_transit_miles', np.nan),
        ('google_transit_path', np.nan),
        
        ('google_transit_bus_minutes', np.nan),
        ('google_transit_bus_miles', np.nan),

        ('google_transit_heavy_rail_minutes', np.nan),
        ('google_transit_heavy_rai_miles', np.nan),

        ('google_transit_subway_minutes', np.nan),
        ('google_transit_subway_miles', np.nan),

        ('google_transit_tram_minutes', np.nan),
        ('google_transit_tram_miles', np.nan),
        
        ('google_transit_walking_minutes', np.nan),
        ('google_transit_walking_miles', np.nan),
        
        ('google_transit_waiting_minutes', np.nan),
        
        ('google_bicycling_minutes', np.nan),
        ('google_bicycling_miles', np.nan),
        ('google_bicycling_path', np.nan),
        
        ('google_walking_minutes', np.nan),
        ('google_walking_miles', np.nan),
        ('google_walking_path', np.nan),
    ])
    
    # Initiate dictionary to store summaries
    record_summaries = {}
    
    # Iterate through all record_ids
    for record_id in routing_results.keys():
        # Make a copy of the summary template to store results
        record_summary = summary_template.copy()
        # Iterate through modes
        
        record_summary['lat_o'] = routing_results[record_id]['lat_o']
        record_summary['lon_o'] = routing_results[record_id]['lon_o']
        record_summary['lat_d'] = routing_results[record_id]['lat_d']
        record_summary['lon_d'] = routing_results[record_id]['lon_d']

        modes = [x for x in ['driving','transit','bicycling','walking'] if x in routing_results[record_id]]

        for mode in modes:
            # Process modes with available routes
            if len(routing_results[record_id][mode]['routes']) > 0:
                
                # Aggregate legs and steps
                leg_summaries, step_summaries = aggregate_legs(routing_results[record_id][mode]['routes'][0]['legs'])
                
                # Store summary information for legs
                record_summary[f'google_{mode}_minutes'] = leg_summaries.duration / 60
                record_summary[f'google_{mode}_miles'] = leg_summaries.distance / 1609.34
                record_summary[f'google_{mode}_path'] = routing_results[record_id][mode]['routes'][0]['overview_polyline']['points']
                
                # For transit, store summary information for steps
                if mode == 'transit':
                    if 'bus' in step_summaries:
                        record_summary['google_transit_bus_minutes'] = step_summaries['bus']['duration'] / 60
                        record_summary['google_transit_bus_miles'] = step_summaries['bus']['distance'] / 60
                    if 'heavy_rail' in step_summaries:
                        record_summary['google_transit_heavy_rail_minutes'] = step_summaries['heavy_rail']['duration'] / 60
                        record_summary['google_transit_heavy_rail_miles'] = step_summaries['heavy_rail']['distance'] / 60
                    if 'subway' in step_summaries:
                        record_summary['google_transit_subway_minutes'] = step_summaries['subway']['duration'] / 60
                        record_summary['google_transit_subway_miles'] = step_summaries['subway']['distance'] / 60
                    if 'tram' in step_summaries:
                        record_summary['google_transit_tram_minutes'] = step_summaries['tram']['duration'] / 60
                        record_summary['google_transit_tram_miles'] = step_summaries['tram']['distance'] / 60
                    if 'walking' in step_summaries:
                        record_summary['google_transit_walking_minutes'] = step_summaries['walking']['duration'] / 60
                        record_summary['google_transit_walking_miles'] = step_summaries['walking']['distance'] / 60
                    total_step_duration = pd.DataFrame(step_summaries).T.duration.sum()
                    record_summary['google_transit_waiting_minutes'] = (leg_summaries.duration / 60) - (total_step_duration / 60) 
                
                # Store summaries under the record_id
                record_summaries[record_id] = record_summary
        
    # Convert to a dataframe
    record_summaries = pd.DataFrame.from_dict(record_summaries).T
    
    # Convert all numeric columns to numeric dtypes
    for col in record_summaries.columns:
        record_summaries[col] = pd.to_numeric(record_summaries[col], errors='ignore')
    # Round numeric values
    record_summaries = record_summaries.round(2)

    # Reset index
    record_summaries = record_summaries.reset_index(drop=True)
    
    return record_summaries