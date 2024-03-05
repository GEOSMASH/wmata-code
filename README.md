# wmata-code
![Python version](https://img.shields.io/badge/python-3.10-blue.svg)
![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)


This repository contains all the code used for data preprocessing and modelling in the development of the Origin-Destination (OD) land use ridership model for WMATA (Washington Metropolitan Area Transit Authority).

<hr />

### [Structure]()
This project is meticulously organized to ensure reproducibility and that users and contributors can easily navigate and understand its contents. To provide a clear understanding of the repository's structure, here's a brief overview:

- #### [Data Preprocessing](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing) 
  All the notebooks must be executed sequentially, following the order in which they are arranged.
  <br/>
  <br/>
  Here's a brief overview of all the dataset  pre-processing notebooks:
  
  - ##### [Alphashape walkshed](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Alphashape%20Walkshed)
    The Alpashape_walkshed code generates the walkshed areas for six newly constructed metro stations. The input for this code includes data on the metro stations, and the alpha shape method is employed with an alpha value of 300. As a result, a new walkshed is created for each of the six new stations
        <br/> <br/>
      ```Output type: polygon geometry ```
  
 
  - ##### [Buffer Metro Stations](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Buffer%20Metro%20Station)
    Buffer_metro_stations creates a designated area surrounding each metro station. The input for this file consists of the data on metro station entrances, which is used to generate the    buffers around each station.
    <br/> <br/>
      ```Output type: polygon geometry ```

  - ##### [Jobs Classify](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Jobs%20Classify)
    jobs_classify is an R script that combines the many original job/workforce segments files for DC, MD and VA into a singular dataset for use in creating the other jobs variables included in the model.
     <br/> <br/>
      ```R script```
    
  - ##### [OSMNX Auto Travel Times](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/OSMNX%20Auto%20Travel%20Time)
    This code calculates auto network travel times between each of the OD pairs using OSMNX. We did not include this version of the auto travel times in the final model, but the inputs here are used elsewhere in data preprocessing
          <br/> <br/>
  ```Var Name: min_p_mile```
  
  - ##### [Bus Lines and Stops](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Bus%20Travel%20Time)
    bus_lines_stops contains the code to determine the number of bus lines and bus stops within the walkshed of each metro station. The inputs for this code include the walksheds, General Transit Feed Specification (GTFS) data, and walkshed names/station codes.
          <br/> <br/>
  ```Var Name: bus_stop_count```, ```bus_line_count```

  - ##### [Proportion of Jobs](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Proportion%20of%20Jobs)
    This code calculates the proportional number of all jobs in the region based on the area of the census block within the station walkshed. The inputs include the station walksheds, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.
      <br/> <br/>
  ```Var Name:  all_jobs```


  - ##### [Averaged Trains Per Hour](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Averaged%20Trains%20Per%20Hour)
    This code calculates the average number of trains per hour of the day (0 -23) per direction at each of the metro stations. 
              <br/> <br/>
  ```Var Name: AVG_TRAINS```


  - ##### [Proportion of Night and Weekend Jobs](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Proportion%20of%20Night%20and%20Weekend%20Jobs)
    This code calculates the proportional number of night and weekend jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.
              <br/> <br/>
  ```Var Name: proportion_night_weekend_jobs```


  - ##### [Ridership Data](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Ridership%20Data)
    Ridership Data contains the code to clean the original ridership data from WMATA and get the number of passengers between OD pairs for each of the ridership classes analyzed with our model. These include the full-fare riders without benefits, full-fare riders with transit benefits, senior/disabled without transit benefits and an all riders class containing those three classes combined. The input is the original ridership data provided by WMATA.
  
  - ##### [Bus Travel Times](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Bus%20Travel%20Time)
    bus_travel_time_per_track_mile_ML determines the total travel time and travel time per mile by bus for each of the station OD pairs. The input includes the bus travel times provided by WMATA, the results from the OSMNX Auto Travel Time code, and Zhila's AM dataframe for use in comparison.
      <br/> <br/>
  ```Var Name: bus_tt```

  - ##### [Distance to the Core](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Distance%20to%20the%20Core)
    metro_distances calculates the euclidean distance between each of the metro stations and the Metro Center Station which in this case acts as the core of the metro system. The only import is the station entrances shapefile.
        <br/> <br/>
  ```Var Name: distance_to_core```

  - ##### [Fare per Track Mile](https://github.com/GEOSMASH/wmata-task2/blob/main/Data%20Preprocessing/Fare%20per%20Track%20Mile/)
    Fare_per_track_mile calculates the fare per mile between each of the metro stations. Inputs include fare data from WMATA, OSMNX auto travel times and the file containing station names and their mstn codes.
            <br/> <br/>
  ```Var Name: peak_fare_per_mile2```

  - ##### [Interpolated Auto Travel Times](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Interpolated%20Auto%20Travel%20Times)
    Auto_travel_time_interpolation contains the code to generate auto travel times based on the travel times from 2015. We found that these produced better times than the results from OSMNX. The inputs include the 2015 dataframes for all three time periods, the list of track mile distances for each OD pair from WMATA and a file containing station names and mstn codes.
                <br/> <br/>
  ```Var Name: new_auto_tt2```

  - ##### [Median Household Income](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Median%20Household%20Income)
    proportion_of_median_households_income contains the code to generate the median household income for each station walkshed. The inputs include the walkshed shapefile, boundaries for the census blocks in Maryland, DC and Virginia, the block group geodataframes for Maryland, DC and Virginia and finally American Community Survey data for Maryland, DC and Viriginia.
               <br/> <br/>
  ```Var Name: Median_household_income```


  - ##### [Parking Users](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Parking%20Users)
    This code calculates the number of passengers that used parking between each station OD pair. The input is an excel file of all of the trips with whether or not they paid for parking.
                <br/> <br/>
  ```Var Name: parking_user```

  - ##### [Proportion of 9-5 Jobs](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Proportion%20of%209-5%20Jobs)
    This code calculates the proportional number of 9am-5pm jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, station entrance   points, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.
                <br/> <br/>
  ```Var Name: Total_Nine_to_Five_workers```


  - ##### [Proportion of Education Jobs](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Proportion%20of%20Education%20Jobs)
    This code calculates the proportional number of education sector jobs based on the area of the census block within the station walkshed. The inputs include the station walksheds, station entrance points, census block boundaries for DC, MD and VA, and the Excel sheet of all job categories in DC, MD and VA.
                <br/> <br/>
  ```Var Name: Proportion_education_jobs```


  - ##### [Proportion of Households](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Proportion%20of%20Households)
    This code calculates the proportional number of households based on the area of the census block within the station walkshed. The inputs include the station walksheds, household data for DC, MD and VA, and the census block boundaries for those three states.
                <br/> <br/>
  ```Var Name: Total_Households```

  - ##### [Bike Travel Time](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/bike%20travel%20time)
    Bike travel time measures the time taken in minutes to move from one metrostation to another. This data was pre-processed from Capital bikeshare's tripdata. The output is a CSV of O-D station names and the travel time in minutes
                <br/> <br/>
  ```Var Name: bike_traveltime```

  - ##### [Bikeshare Capacity](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/bikeshare%20capacity)
    This code calculates the capacity of bikeshare facilities within each metrostation walkshed in the DC, MD, VA area
                <br/> <br/>
  ```Var Name: bike_cap```


  - ##### [Bus Competitiveness Index](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/bus%20competitiveness)
  
  ```Var Name: bus_competativeness_index```

  - ##### [CTPP Jobs Data](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/CTPP%20Jobs%20Data)
    This code calculates the proportional number of jobs in the DC, MD, and VA area using the Census Transportation Planning Products (CTPP) program dataset. 
                <br/> <br/>
  ```Var Name: ctpp_jobs```
     

  - ##### [Household Income below $50k](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/HH_IncomeBelowPoverty)
    This code calculates the number of Household earning below 50k across the DC, MD, VA area. The inputs include the metro station walksheds, census block boundaries for DC, MD and VA, and 2022 U.S census data for house-hold income. The output is a csv of metrostation walkshed names and household income below the poverty using a 50k threshold.
    <br/> <br/>
  ```Var Name: hh_below_50k```

    
  - ##### [Number of Hotels](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Hotels%20Restaurants%20Entertainment)
    This code counts the number of hotels within each station walksheds, using hotels data from OSMNX. The tags are ```{hotel, motel}``` The output is a csv of hotels within each walkshed.
      <br/> <br/>
  ```Var Name: hotelcount```


  - ##### [Number of Restaurants](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Hotels%20Restaurants%20Entertainment)
    This code counts the number of restaurants withiin each station walksheds, using restaurants from OSMNX. The output is a csv of restaurants within each walkshed.
      <br/> <br/>
  ```Var Name: restaurantcount```
    
  - ##### [Number of Entertainments](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Hotels%20Restaurants%20Entertainment)
    This code counts the number of entertainment venues within each station walksheds, using entertaiment venues from OSMNX. The tags were defined as stadiums, track, swimming pool, recreation ground, casino, arts center, cinema, and community center. The output is a csv of entertainment venues within each station walkshed.
      <br/> <br/>
  ```Var Name: entertainmentcount```

  - ##### [Intercity Hub](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Intercity%20hubs)
    Intercity hub explains if a metrostation is essentially an inter-city hub based on the passenger flows across different modes like the rail, bus and flight. These were then collapse within the walkshed buffer of the metrostations. As input, the intermodal connectivity database as well as AMTRAK, MARC, and WMATA ridership data were utilized. The output is a csv of metrostation walksheds and the volume of passengers.
          <br/> <br/>
  ```Var Name: intercityhub```


  - ##### [Intersection Density](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Intersection%20Density)
    Intersection density measures the total street intersection density within the DMV area. The variable was processed from the Environment Protection Agency (EPA) smart Location Database (SLD). It also uses the census tract boundaries for the MD, DC, and VA area. The output is a csv of station names and proportional street density.
              <br/> <br/>
  ```Var Name: prop_str_dens```

  - ##### [Job Accessibility 45mins by Transit](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Job%20Accessibility%2045mins%20by%20transit%20and%20Auto)
    Job Accessibility 45mins by Transit calculates a measure of jobs or working age population within a 45 minute commute by transit. It takes as input the EPA Smart Location Data, metrostation walksheds with overlapping boundaries, as well as boundaries for census blocks in MD, DC, and VA.
           <br/> <br/>
  ```Var Name: jobs_transit```


  - ##### [Number of Convenience Stores](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/number%20of%20convenience%20stores)
    This code counts the number of convenience stores within each station walksheds, using data from OSMNX. The output is a csv of convenience store count within each walkshed.
      <br/> <br/>
  ```Var Name: convenience_storecount```
   
   - ##### [Number of Student Enrollment in High School](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Number%20of%20education%20institutions)
      This variable calculates the total number student enrollment in elementary and secondary schools within the DC, MD, VA area. It takes as input data from  The National Center for     Education Statistics' (NCES) Education Demographic and Geographic Estimate (EDGE) program, walkshed buffer for the metrostations, as well as boundaries for census blocks in the DMV. The output is a csv of station names and the total number of enrollment for high school students.
         <br/> <br/>
  ```Var Name: highschoolenroll```

  - ##### [Number of Student Enrollment in Colleges](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Number%20of%20education%20institutions)
      This code calculates the total number enrollment in colleges within the DC, MD, VA area. The output is a csv of station names and the total number of enrollment in colleges within the metrostation walksheds.
         <br/> <br/>
  ```Var Name: college_enroll```

  - ##### [Number of Households with exactly zero cars](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Number%20of%20Households%20with%20no%20car%20or%20one%20car)
    This code calculates the total number of households with exactly zero cars within the walkshed buffer of the metrostation. As input, the U.S ACS income dataset was utilized, as well as walkshed buffer and boundaries of the MD, DC, and VA area. The output is a csv with walkshed station names and the corresponding amount of households with no car.
             <br/> <br/>
  ```Var Name: hh_0_car```

  - ##### [Number of Households with exactly 1 car](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Number%20of%20Households%20with%20no%20car%20or%20one%20car)
    This code calculates the total number of households with exactly 1 car within the walkshed buffer of the metrostation. As input, the U.S ACS income dataset was utilized, as well as walkshed buffer and boundaries of the MD, DC, and VA area. The output is a csv with walkshed station names and the corresponding amount of households with exactly 1 car.
             <br/> <br/>
  ```Var Name: hh_1_car```
  
  - ##### [Number of Households with more than 1 car](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Number%20of%20Households%20with%20no%20car%20or%20one%20car)
    This code calculates the total number of households with more than 1 car within the walkshed buffer of the metrostation. As input, the U.S ACS income dataset was utilized, as well as walkshed buffer and boundaries of the MD, DC, and VA area. The output is a csv with walkshed station names and the corresponding amount of households with more than 1 car.
             <br/> <br/>
  ```Var Name: HH_more1_car```

  - ##### [Public Admin Jobs](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/Public%20Admin%20Jobs)
      Public Admin jobs measures the proportion of public adminstration jobs within the buffer of each station. For each station, the percent area of blocks within each station walkshed are     calculated, and the total number of jobs is multiplied by the percentage to get the proportional number of public admin jobs. The takes as input the jobs data, as well as census block boundaries for the DC, MD, and VA area. The output is a csv of jobs within each station walkshed.
          <br/> <br/>
  ```Var Name: pub_admin_jobs```

  - ##### [Number of Affordable Housing Units](https://github.com/GEOSMASH/wmata-task2/tree/main/Data%20Preprocessing/seniorhousing_affordability)
    This code calculates the number of Affordable housing units within the DC, MD, VA area. Data from the National Housing Preservation Database (NHPD), U.S Census blocks, and walksheds with overlapping boundaries were used to obtain the number total units of affordable housing within each station walkshed.
              <br/> <br/>
  ```Var Name: housing_units_afford```


- #### [Dataframe Creation](https://github.com/GEOSMASH/wmata-task2/tree/main/Modeling)
After running the notebooks in [Data Preprocessing](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing) directory sequentially. In the modeling directory, run the Dataframe creation notebook ```(dataframe_creation_final.ipynb)``` to generate the training dataframe which combines all of the individual variables to a single dataframe for each of the AM, PM and OFF peak time periods

  - #### [Modelling pipeline]()
    ...WIP
    <br/>
     <br/>

### [Getting Started]()
To get started, clone the repository, navigate to the project directory, explore the folders mentioned above. Each directory contains code/script and an associated output folder that would house the final pre-processed data from running the individual preprocessing routine as well as the model results. <br/><br/> Replace the Data folder with the folder containing the actual datasets. 
