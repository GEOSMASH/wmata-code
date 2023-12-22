# wmata-code
![Python version](https://img.shields.io/badge/python-3.10-blue.svg)
![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)


This repository contains all the code used for data preprocessing and modelling in the development of the Origin-Destination (OD) land use ridership model for WMATA (Washington Metropolitan Area Transit Authority).

<hr />

### [Structure]()
This project is meticulously organized to ensure reproducibility and that users and contributors can easily navigate and understand its contents. To provide a clear understanding of the repository's structure, here's a brief overview:

- #### [Data Preprocessing](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing) 
  All the notebooks must be executed sequentially, following the order in which they are arranged.
  <br/>
  <br/>
  Here's a brief overview of all the dataset  pre-processing notebooks:
  - ##### [Alphashape walkshed](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Alphashape%20Walkshed)
    The Alpashape_walkshed code generates the walkshed areas for six newly constructed metro stations. The input for this code includes data on the metro stations, and the alpha shape method is employed with an alpha value of 300. As a result, a new walkshed is created for each of the six new stations.
 
  - ##### [Buffer Metro Stations](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Buffer%20Metro%20Station)
    Buffer_metro_stations creates a designated area surrounding each metro station. The input for this file consists of the data on metro station entrances, which is used to generate the    buffers around each station.

  - ##### [Jobs Classify](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Jobs%20Classify)
    jobs_classify is an R script that combines the many original job/workforce segments files for DC, MD and VA into a singular dataset for use in creating the other jobs variables included in the model. 
    
  - ##### [OSMNX Auto Travel Times](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/OSMNX%20Auto%20Travel%20Time)
    This code calculates auto network travel times between each of the OD pairs using OSMNX. We did not include this version of the auto travel times in the final model, but the inputs here are used elsewhere in data preprocessing
  
  - ##### [Bus Lines and Stops](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Bus%20Travel%20Time)
    bus_lines_stops contains the code to determine the number of bus lines and bus stops within the walkshed of each metro station. The inputs for this code include the walksheds, General Transit Feed Specification (GTFS) data, and walkshed names/station codes.
  
  - ##### [Bus Travel Times](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Bus%20Travel%20Time)
    bus_travel_time_per_track_mile_ML determines the total travel time and travel time per mile by bus for each of the station OD pairs. The input includes the bus travel times provided by WMATA, the results from the OSMNX Auto Travel Time code, and Zhila's AM dataframe for use in comparison.
    
  - ##### [Distance to the Core](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Distance%20to%20the%20Core)
    metro_distances calculates the euclidean distance between each of the metro stations and the Metro Center Station which in this case acts as the core of the metro system. The only import is the station entrances shapefile.

  - ##### [Fare per Track Mile](https://github.com/GEOSMASH/wmata-code/blob/main/Data%20Preprocessing/Fare%20per%20Track%20Mile/)
    Fare_per_track_mile calculates the fare per mile between each of the metro stations. Inputs include fare data from WMATA, OSMNX auto travel times and the file containing station names and their mstn codes.

  - ##### [Interpolated Auto Travel Times](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Interpolated%20Auto%20Travel%20Times)
    Auto_travel_time_interpolation contains the code to generate auto travel times based on the travel times from 2015. We found that these produced better times than the results from OSMNX. The inputs include the 2015 dataframes for all three time periods, the list of track mile distances for each OD pair from WMATA and a file containing station names and mstn codes.

  - ##### [Median Household Income](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Median%20Household%20Income)
    proportion_of_median_households_income contains the code to generate the median household income for each station walkshed. The inputs include the walkshed shapefile, boundaries for the census blocks in Maryland, DC and Virginia, the block group geodataframes for Maryland, DC and Virginia and finally American Community Survey data for Maryland, DC and Viriginia.

  - ##### [Parking Users](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Parking%20Users)
    This code calculates the number of passengers that used parking between each station OD pair. The input is an excel file of all of the trips with whether or not they paid for parking.

  - ##### [Proportion of 9-5 Jobs](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Proportion%20of%209-5%20Jobs)
    This code calculates the proportional number of 9am-5pm jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, station entrance points, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.

  - ##### [Proportion of Education Jobs](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Proportion%20of%20Education%20Jobs)
    This code calculates the proportional number of education sector jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, station entrance points, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.

  - ##### [Proportion of Households](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Proportion%20of%20Households)
    This code calculates the proportional number of households based on the area of the census block within the station walkshed. The inputs include the station walksheds, household data for DC, MD and VA, and the census block boundaries for those three states.

  - ##### [Proportion of Jobs](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Proportion%20of%20Jobs)
    This code calculates the proportional number of all jobs in the region based on the area of the census block within the station walkshed. The inputs include the station walksheds, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.

  - ##### [Proportion of Night and Weekend Jobs](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Proportion%20of%20Night%20and%20Weekend%20Jobs)
    This code calculates the proportional number of night and weekend jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.

  - ##### [Ridership Data](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Ridership%20Data)
    Ridership Data contains the code to clean the original ridership data from WMATA and get the number of passengers between OD pairs for each of the ridership classes analyzed with our model. These include the full-fare riders without benefits, full-fare riders with transit benefits, senior/disabled without transit benefits and an all riders class containing those three classes combined. The input is the original ridership data provided by WMATA.
    
- #### [Modeling](https://github.com/GEOSMASH/wmata-code/tree/main/Modeling)
After running the notebooks in [Data Preprocessing](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing) directory sequentially. In the modeling directory, run the Dataframe creation notebook ```(dataframe_creation2.ipynb)``` first before running the r-scripts

### [Getting Started]()
To get started, clone the repository, navigate to the project directory, explore the folders mentioned above. Each directory contains code/script and an associated output folder that would house the final pre-processed data from running the individual preprocessing routine as well as the model results. <br/><br/> Replace the Data folder with the folder containing the actual datasets. 
