# Random Forest Model 
This Random Forest model has been trained on 55 features and the target feature is `passengers`. The dataframe is located at: `../Modeling/Outputs/model_data.csv`
- ### Usage:
- The model is saved as a pickle `.pkl` file. We recommend using joblib to load the model. Joblib is optimized for handling NumPy data structures and was originally part of Scikit-Learn.

- To recreate the environment, use the following command:
  
  - ```conda env create -f environment.yml```
  
- Load the pickle file and predict:
  
  - ```loaded_model = joblib.load('random_forest_model.pkl')```
    
  - ```predictions = loaded_model.predict(data)```

