#!/usr/bin/env python3

"""Insert docstring here"""

__appname__ = 'NLLS_fitting.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## IMPORTS ##
import pandas as pd
import numpy as np
from lmfit import Parameters, minimize

## FUNCTIONS ##
def linear_residuals(params, t, data):
    """Calculates the residuals for the linear model to be fitted to the data points
                    
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the linear model"""
    
    B_0 = params['B_0']
    B_1 = params['B_1']

    linear_model = B_0 + B_1*t
    linear_residuals = data-linear_model

    return (linear_residuals)

def quadratic_residuals(params, t, data):
    """Calculates the residuals for the quadratic model to be fitted to the data points
                    
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the quadratic model"""
    
    B_0 = params['B_0']
    B_1 = params['B_1']
    B_2 = params['B_2']

    quadratic_model = B_0 + B_1*t + B_2*(t**2)
    quadratic_residuals = data-quadratic_model

    return (quadratic_residuals)

def cubic_residuals(params, t, data):
    """Calculates the residuals for the cubic model to be fitted to the data points
                    
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the cubic model"""
    
    B_0 = params['B_0']
    B_1 = params['B_1']
    B_2 = params['B_2']
    B_3 = params['B_3']

    cubic_model = B_0 + B_1*t + B_2*(t**2) + B_3*(t**3)
    cubic_residuals = data-cubic_model

    return (cubic_residuals)

def logistic_residuals(params, t, data):
    """Calculates the residuals for the logistic model to be fitted to the data points
                
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the logistic model"""
    
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']

    logistic_model = np.real(np.log10((N_0*N_max)/(N_0 + (N_max - N_0) * np.exp(-r_max * t))))
    logistic_residuals = data-logistic_model

    return (logistic_residuals)

def gompertz_residuals(params, t, data):
    """Calculates the residuals for the gompertz model to be fitted to the data points
            
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the gompertz model"""
    
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    gompertz_model = N_0 + (N_max - N_0) * np.exp(-np.exp(r_max * np.exp(1) * (t_lag - t)/((N_max - N_0) * np.log(10)) + 1))
    gompertz_residuals = data-gompertz_model

    return (gompertz_residuals)

def baranyi_residuals(params, t, data):
    """Calculates the residuals for the baranyi model to be fitted to the data points
        
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the baranyi model"""
    
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    baranyi_model = N_max + np.log10((-1+np.exp(r_max*t_lag) + np.exp(r_max*t))/(np.exp(r_max*t) - 1 + np.exp(r_max*t_lag) * 10**(N_max-N_0)))
    baranyi_residuals = data-baranyi_model

    return (baranyi_residuals)

def buchanan_residuals(params, t, data):
    """Calculates the residuals for the buchanan model to be fitted to the data points
    
       ARGUMENTS: 
       1 - params: parameters to be used to find the predicted data values
       2 - t: time values
       3 - data: observed data values
       
       OUTPUT:
       An array containing the residuals obtained from comparing the observed data with the predicted data found by the buchanan model"""
    
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    buchanan_model = N_0 + (t >= t_lag) * (t <= (t_lag + (N_max - N_0) * np.log(10)/r_max)) * r_max * (t - t_lag)/np.log(10) + (t >= t_lag) * (t > (t_lag + (N_max - N_0) * np.log(10)/r_max)) * (N_max - N_0)
    buchanan_residuals = data-buchanan_model

    return (buchanan_residuals)

def model_selection_metrics(residuals_Log10, data_Log10, n, p):
    """Calculates the model selection metrics
    
       ARGUMENTS:
       1 - residuals_Log10: residuals in logged form
       2 - data_Log10: observed data in logged form
       3 - n: sample size
       4 - p: number of parameters
       
       OUTPUT:
       If n/p < 40:
            if p = n - 1:
                An array containing infinity as the AIC_c value, BIC, and R_2
            else:
                An array containing AIC_c, BIC, and R_2
       else:
           An array containing AIC, BIC, and R_2"""
    
    observed = 10**(data_Log10) # linearizing the logged data
    predicted_Log10 = residuals_Log10 + data_Log10 # predicted logged data
    predicted = 10**(predicted_Log10) # linearizing predicted logged data
    res = observed - predicted # calculating linearized residuals
    rss = sum(res**2) # calculating residual sum of squares
    tss = sum((observed-np.mean(predicted))**2) # calculating total sum of squares
    AIC = n + 2 + n * np.log((2 * np.pi) / n) + n * np.log(rss) + 2 * p
    BIC = n + 2 + n * np.log((2 * np.pi) / n) + n * np.log(rss) + (np.log(n)) * (p + 1)
    R_2 = 1 - (rss / tss)
    # for small sample size to number of parameters ratio, AIC_c is calculated instead of AIC
    if n/p < 40:
        try:
            AIC_c = AIC + ((2 * p * (p + 1)) / (n - p - 1))
        except ZeroDivisionError:
            return(np.inf, BIC, R_2) # if p = n - 1, an AIC/AIC_c value of infinity is given
        
        return(AIC_c, BIC, R_2)
    return (AIC, BIC, R_2)

## CONSTANTS ##
modified_data = pd.read_csv("../data/ModifiedLogisticGrowthData.csv") # load modified dataset
results_df = pd.DataFrame() # create a pandas dataframe which will be used at the end to store results
count = np.zeros(7) # to count the number of times each model failed to converge

## ANALYSIS ##
for i in modified_data.ID.unique():

    # define a subset of the data at each iteration based on the IDs
    data_subset = modified_data[modified_data['ID'] == i]

    # isolate first 50% of data to fit a straight-line for r_max
    PopBio_50 = data_subset.PopBio_Log10.iloc[0:int(np.ceil(0.5*len(data_subset)))]
    Time_50 = data_subset.Time.iloc[0:int(np.ceil(0.5*len(data_subset)))]

    # finding starting values
    N_max = max(data_subset.PopBio_Log10) # largest abundance value in the dataset
    N_0 = data_subset.PopBio_Log10.iloc[0] # first abundance value in the dataset
    lm_fit = np.polyfit(Time_50, PopBio_50, deg = 1) # fitting a linear model
    r_max = lm_fit[0] # taking the slope of the fitted model as a value for r_max
    b_intercept = lm_fit[1]
    t_lag = (N_0 - b_intercept) / r_max # taking the intersection point between the straight-line and y = N_0 as a value for t_lag

    # creating a library of parameters for the phenomenological models
    params_phenomenological = Parameters()
    params_phenomenological.add(name = 'B_0', value = 1)
    params_phenomenological.add(name = 'B_1', value = 1)
    params_phenomenological.add(name = 'B_2', value = 1)
    params_phenomenological.add(name = 'B_3', value = 1)

    # creating a library of parameters for the mechanistic models
    params_mechanistic = Parameters()
    params_mechanistic.add(name = 'N_max', value = N_max)
    params_mechanistic.add(name = 'N_0', value = N_0)
    params_mechanistic.add(name = 'r_max', value = r_max)
    params_mechanistic.add(name = 't_lag', value = t_lag)

    # saving logged abundance and time values
    abundance_Log10 = np.array(data_subset.PopBio_Log10)
    t = np.array(data_subset.Time)
    
    ## NLLS FITTING ##

    # performing NLLS fitting and saving estimated parameters into variables
    try:
        linear_out = minimize(linear_residuals, params_phenomenological, args=(t, abundance_Log10))
        linear_params = list(linear_out.params.valuesdict().values())[0:2]
    except ValueError:
        linear_params = [0, 0]
        count[0] = count[0] + 1
    try:
        quadratic_out = minimize(quadratic_residuals, params_phenomenological, args=(t, abundance_Log10))
        quadratic_params = list(quadratic_out.params.valuesdict().values())[0:3]
    except ValueError:
        quadratic_params = [0, 0, 0]
        count[1] = count[1] + 1
    try:
        cubic_out = minimize(cubic_residuals, params_phenomenological, args=(t, abundance_Log10))
        cubic_params = list(cubic_out.params.valuesdict().values())
    except ValueError:
        cubic_params = [0, 0, 0, 0]
        count[2] = count[2] + 1
    try:
        logistic_out = minimize(logistic_residuals, params_mechanistic, args=(t, abundance_Log10))
        logistic_params = list(logistic_out.params.valuesdict().values())[0:3]
    except ValueError:
        logistic_params = [0, 0, 0]
        count[3] = count[3] + 1
    try:
        gompertz_out = minimize(gompertz_residuals, params_mechanistic, args=(t, abundance_Log10))
        gompertz_params = list(gompertz_out.params.valuesdict().values())
    except ValueError:
        gompertz_params = [0, 0, 0, 0]
        count[4] = count[4] + 1
    try:
        baranyi_out = minimize(baranyi_residuals, params_mechanistic, args=(t, abundance_Log10))
        baranyi_params = list(baranyi_out.params.valuesdict().values())
    except ValueError:
        baranyi_params = [0, 0, 0, 0]
        count[5] = count[5] + 1
    try:
        buchanan_out = minimize(buchanan_residuals, params_mechanistic, args=(t, abundance_Log10))
        buchanan_params = list(buchanan_out.params.valuesdict().values())
    except ValueError:
        buchanan_params = [0, 0, 0, 0]
        count[6] = count[6] + 1

    ## MODEL SELECTION ##

    # calculating model selection metrics of each model
    try:
        linear_metrics = list(model_selection_metrics(residuals_Log10 = linear_out.residual, 
                                                      data_Log10 = abundance_Log10, 
                                                      n = len(data_subset),
                                                      p = len(linear_params)))
    except (ValueError, NameError):
        linear_metrics = [0, 0, 0]
    try:
        quadratic_metrics = list(model_selection_metrics(residuals_Log10 = quadratic_out.residual, 
                                                         data_Log10 = abundance_Log10, 
                                                         n = len(data_subset),
                                                         p = len(quadratic_params)))
    except (ValueError, NameError):
        quadratic_metrics = [0, 0, 0]
    try:
        cubic_metrics = list(model_selection_metrics(residuals_Log10 = cubic_out.residual, 
                                                     data_Log10 = abundance_Log10, 
                                                     n = len(data_subset),
                                                     p = len(cubic_params)))
    except (ValueError, NameError):
        cubic_metrics = [0, 0, 0]
    try:
        logistic_metrics = list(model_selection_metrics(residuals_Log10 = logistic_out.residual, 
                                                        data_Log10 = abundance_Log10, 
                                                        n = len(data_subset),
                                                        p = len(logistic_params)))
    except (ValueError, NameError):
        logistic_metrics = [0, 0, 0]
    try:
        gompertz_metrics = list(model_selection_metrics(residuals_Log10 = gompertz_out.residual, 
                                                        data_Log10 = abundance_Log10, 
                                                        n = len(data_subset),
                                                        p = len(gompertz_params)))
    except (ValueError, NameError):
        gompertz_metrics = [0, 0, 0]
    try:
        baranyi_metrics = list(model_selection_metrics(residuals_Log10 = baranyi_out.residual, 
                                                       data_Log10 = abundance_Log10, 
                                                       n = len(data_subset),
                                                       p = len(baranyi_params)))
    except (ValueError, NameError):
        baranyi_metrics = [0, 0, 0]
    try:
        buchanan_metrics = list(model_selection_metrics(residuals_Log10 = buchanan_out.residual, 
                                                        data_Log10 = abundance_Log10, 
                                                        n = len(data_subset),
                                                        p = len(buchanan_params)))
    except (ValueError, NameError):
        buchanan_metrics = [0, 0, 0]
    
    ## STORING RESULTS ##

    # creating a dictionary with model name, parameters, and model selection metrics as keys to store results
    results_dict = dict.fromkeys(['model', 'B_0', 'B_1', 'B_2', 'B_3', 'N_max', 'N_0', 'r_max', 't_lag', 'AIC/AIC_c', 'BIC', 'R_2'])

    # populating keys with values
    results_dict['model'] = ['linear', 'quadratic', 'cubic', 'logistic', 'gompertz', 'baranyi', 'buchanan']
    results_dict['B_0'] = [linear_params[0], quadratic_params[0], cubic_params[0], 0, 0, 0, 0]
    results_dict['B_1'] = [linear_params[1], quadratic_params[1], cubic_params[1], 0, 0, 0, 0]
    results_dict['B_2'] = [0, quadratic_params[2], cubic_params[2], 0, 0, 0, 0]
    results_dict['B_3'] = [0, 0, cubic_params[3], 0, 0, 0, 0]
    results_dict['N_max'] = [0, 0, 0, logistic_params[0], gompertz_params[0], baranyi_params[0], buchanan_params[0]]
    results_dict['N_0'] = [0, 0, 0, logistic_params[1], gompertz_params[1], baranyi_params[1], buchanan_params[1]]
    results_dict['r_max'] = [0, 0, 0, logistic_params[2], gompertz_params[2], baranyi_params[2], buchanan_params[2]]
    results_dict['t_lag'] = [0, 0, 0, 0, gompertz_params[3], baranyi_params[3], buchanan_params[3]]
    results_dict['AIC/AIC_c'] = [linear_metrics[0], quadratic_metrics[0], cubic_metrics[0], logistic_metrics[0], gompertz_metrics[0], baranyi_metrics[0], buchanan_metrics[0]]
    results_dict['BIC'] = [linear_metrics[1], quadratic_metrics[1], cubic_metrics[1], logistic_metrics[1], gompertz_metrics[1], baranyi_metrics[1], buchanan_metrics[1]]
    results_dict['R_2'] = [linear_metrics[2], quadratic_metrics[2], cubic_metrics[2], logistic_metrics[2], gompertz_metrics[2], baranyi_metrics[2], buchanan_metrics[2]]

    # transfering stored values from the dictionary to the pandas dataframe created at the beginning
    results_df = pd.concat([results_df, pd.DataFrame.from_dict(results_dict)])
    results_df = results_df[['model', 'B_0', 'B_1', 'B_2', 'B_3', 'N_max', 'N_0', 'r_max', 't_lag', 'AIC/AIC_c', 'BIC', 'R_2']]

    # Note: storing the results in a dictionary and then converting it to a dataframe may seem extra work, 
    # but it actually saves a significant amount of time compared to direct storing of values in a dataframe

# creating an ID array for each unique group
ID = np.repeat(range(305), 7) + 1
# creating an ID array for the models (coding the models numerically from 1 to 7)
model_ID = np.tile(range(7), 305) + 1

# adding the two arrays as columns in the dataframe
results_df.insert(0, "ID", ID, True)
results_df.insert(1, "model_ID", model_ID, True)

# saving the dataframe as a csv file
results_df.to_csv('../data/results.csv', index = False)
