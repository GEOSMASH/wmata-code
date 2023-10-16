# wmata-code
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
    lorem ipsum
 
  - ##### [Buffer Metro Stations](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Buffer%20Metro%20Station)
    lorem ipsum
 
  - ##### [Bus Lines and Stops](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing/Bus%20Lines%20and%20Stops)
    lorem ipsum

  .....

- #### [Modeling](https://github.com/GEOSMASH/wmata-code/tree/main/Modeling)
After running the notebooks in [Data Preprocessing](https://github.com/GEOSMASH/wmata-code/tree/main/Data%20Preprocessing) directory sequentially. In the modeling directory, run the Dataframe creation notebook ```(dataframe_creation2.ipynb)``` first before running the r-scripts

### [Getting Started]()
To get started, clone the repository, navigate to the project directory, explore the folders mentioned above. Each directory contains code/script and an associated output folder that would house the final pre-processed data from running the individual preprocessing routine as well as the model results. <br/><br/> Replace the Data folder with the folder containing the actual datasets. 
