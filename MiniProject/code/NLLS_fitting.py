import pandas as pd
import numpy as np
from lmfit import Parameters, minimize

"""Insert docstring here"""

## FUNCTIONS ##
def linear_residuals(params, t, data):
    """Calculates the residuals for the linear model fitted to the data points"""
    B_0 = params['B_0']
    B_1 = params['B_1']

    linear_model = B_0 + B_1*t
    linear_residuals = data-linear_model

    return (linear_residuals)

def quadratic_residuals(params, t, data):
    """Calculates the residuals for the quadratic model fitted to the data points"""
    B_0 = params['B_0']
    B_1 = params['B_1']
    B_2 = params['B_2']

    quadratic_model = B_0 + B_1*t + B_2*(t**2)
    quadratic_residuals = data-quadratic_model

    return (quadratic_residuals)

def cubic_residuals(params, t, data):
    """Calculates the residuals for the cubic model fitted to the data points"""
    B_0 = params['B_0']
    B_1 = params['B_1']
    B_2 = params['B_2']
    B_3 = params['B_3']

    cubic_model = B_0 + B_1*t + B_2*(t**2) + B_3*(t**3)
    cubic_residuals = data-cubic_model

    return (cubic_residuals)

def logistic_residuals(params, t, data):
    """Calculates the residuals for the logistic model fitted to the data points"""
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']

    #logistic_model = N_0 + (N_max-N_0) / (1 + np.exp(r_max * (t_lag-t))) # cite paper
    logistic_model = np.real(np.log10((N_0*N_max)/(N_0 + (N_max - N_0) * np.exp(-r_max * t))))
    logistic_residuals = data-logistic_model

    return (logistic_residuals)

def gompertz_residuals(params, t, data):
    """Calculates the residuals for the gompertz model fitted to the data points"""
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    gompertz_model = N_0 + (N_max - N_0) * np.exp(-np.exp(r_max * np.exp(1) * (t_lag - t)/((N_max - N_0) * np.log(10)) + 1))
    gompertz_residuals = data-gompertz_model

    return (gompertz_residuals)

def baranyi_residuals(params, t, data):
    """Calculates the residuals for the baranyi model fitted to the data points"""
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    baranyi_model = N_max + np.log10((-1+np.exp(r_max*t_lag) + np.exp(r_max*t))/(np.exp(r_max*t) - 1 + np.exp(r_max*t_lag) * 10**(N_max-N_0)))
    baranyi_residuals = data-baranyi_model

    return (baranyi_residuals)

def buchanan_residuals(params, t, data):
    """Calculates the residuals for the buchanan model fitted to the data points"""
    N_max = params['N_max']
    N_0 = params['N_0']
    r_max = params['r_max']
    t_lag = params['t_lag']

    buchanan_model = N_0 + (t >= t_lag) * (t <= (t_lag + (N_max - N_0) * np.log(10)/r_max)) * r_max * (t - t_lag)/np.log(10) + (t >= t_lag) * (t > (t_lag + (N_max - N_0) * np.log(10)/r_max)) * (N_max - N_0)
    buchanan_residuals = data-buchanan_model

    return (buchanan_residuals)

## MAIN FUNCTION GOES HERE ##
modified_data = pd.read_csv("../data/ModifiedLogisticGrowthData.csv")
count = np.zeros(len(modified_data.ID.unique()))

results_df = pd.DataFrame()

for i in modified_data.ID.unique():

    data_subset = modified_data[modified_data['ID'] == i]

    PopBio_50 = data_subset.PopBio_Log10.iloc[0:int(np.ceil(0.5*len(data_subset)))]
    Time_50 = data_subset.Time.iloc[0:int(np.ceil(0.5*len(data_subset)))]

    N_max = max(data_subset.PopBio_Log10)
    N_0 = data_subset.PopBio_Log10.iloc[0]
    lm_fit = np.polyfit(Time_50, PopBio_50, deg = 1)
    r_max = lm_fit[0]
    b_intercept = lm_fit[1]
    t_lag = (N_0 - b_intercept) / r_max

    ## NLLS FITTING ##
    params_phenomenological = Parameters()
    params_phenomenological.add(name = 'B_0', value = 1)
    params_phenomenological.add(name = 'B_1', value = 1)
    params_phenomenological.add(name = 'B_2', value = 1)
    params_phenomenological.add(name = 'B_3', value = 1)

    params_mechanistic = Parameters()
    params_mechanistic.add(name = 'N_max', value = N_max)
    params_mechanistic.add(name = 'N_0', value = N_0)
    params_mechanistic.add(name = 'r_max', value = r_max)
    params_mechanistic.add(name = 't_lag', value = t_lag)

    abundance_Log10 = np.array(data_subset.PopBio_Log10)
    t = np.array(data_subset.Time)
    
    ## finding params ##
    try:
        linear_out = minimize(linear_residuals, params_phenomenological, args=(t, abundance_Log10))
        linear_params = list(linear_out.params.valuesdict().values())[0:2]
    except ValueError:
        count[i-1] = count[i-1] + 1
    try:
        quadratic_out = minimize(quadratic_residuals, params_phenomenological, args=(t, abundance_Log10))
        quadratic_params = list(quadratic_out.params.valuesdict().values())[0:3]
    except ValueError:
        count[i-1] = count[i-1] + 1
    try:
        cubic_out = minimize(cubic_residuals, params_phenomenological, args=(t, abundance_Log10))
        cubic_params = list(cubic_out.params.valuesdict().values())
    except ValueError:
        count[i-1] = count[i-1] + 1
    try:
        logistic_out = minimize(logistic_residuals, params_mechanistic, args=(t, abundance_Log10))
        logistic_params = list(logistic_out.params.valuesdict().values())[0:3]
    except ValueError:
        count[i-1] = count[i-1] + 1
    try:
        gompertz_out = minimize(gompertz_residuals, params_mechanistic, args=(t, abundance_Log10))
        gompertz_params = list(gompertz_out.params.valuesdict().values())
    except ValueError:
        count[i-1] = count[i-1] + 1
    try:
        baranyi_out = minimize(baranyi_residuals, params_mechanistic, args=(t, abundance_Log10))
        baranyi_params = list(baranyi_out.params.valuesdict().values())
    except ValueError:
        pass
        #count[i-1] = count[i-1] + 1
    try:
        buchanan_out = minimize(buchanan_residuals, params_mechanistic, args=(t, abundance_Log10))
        buchanan_params = list(buchanan_out.params.valuesdict().values())
    except ValueError:
        count[i-1] = count[i-1] + 1

    ## UPDATE PARAMETER VALUES ##
    try:
        linear_params
    except NameError:
        linear_params = [0, 0]
    try:
        quadratic_params
    except NameError:
        quadratic_params = [0, 0, 0]
    try:
        cubic_params
    except NameError:
        cubic_params = [0, 0, 0, 0]
    try:
        logistic_params
    except NameError:
        logistic_params = [0, 0, 0]
    try:
        gompertz_params
    except NameError:
        gompertz_params = [0, 0, 0, 0]
    try:
        baranyi_params
    except NameError:
        baranyi_params = [0, 0, 0, 0]
    try:
        buchanan_params
    except NameError:
        buchanan_params = [0, 0, 0, 0]

    ## MODEL SELECTION ##

    ## calculating AIC/BIC/R^2 of each model ##
    def model_selection_metrics(residuals_Log10, data_Log10, n, p):
        """Calculating the model selection metrics"""
        observed = 10**(data_Log10)
        predicted_Log10 = residuals_Log10 + data_Log10
        predicted = 10**(predicted_Log10)
        res = observed - predicted
        rss = sum(res**2)
        tss = sum((observed-np.mean(predicted))**2)

        AIC = n + 2 + n * np.log((2 * np.pi) / n) + n * np.log(rss) + 2 * p
        BIC = n + 2 + n * np.log((2 * np.pi) / n) + n * np.log(rss) + (np.log(n)) * (p + 1)
        R_2 = 1 - (rss / tss)

        if n/p < 40:
            try:
                AIC_c = AIC + ((2 * p * (p + 1)) / (n - p - 1))
            except ZeroDivisionError:
                return(np.inf, BIC, R_2)
            
            return(AIC_c, BIC, R_2)

        return (AIC, BIC, R_2)

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
    
    results_dict = dict.fromkeys(['model', 'B_0', 'B_1', 'B_2', 'B_3', 'N_max', 'N_0', 'r_max', 't_lag', 'AIC/AIC_c', 'BIC', 'R_2'])

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

    results_df = pd.concat([results_df, pd.DataFrame.from_dict(results_dict)])
    results_df = results_df[['model', 'B_0', 'B_1', 'B_2', 'B_3', 'N_max', 'N_0', 'r_max', 't_lag', 'AIC/AIC_c', 'BIC', 'R_2']]

ID = np.repeat(range(305), 7) + 1
model_ID = np.tile(range(7), 305) + 1

results_df.insert(0, "ID", ID, True)
results_df.insert(1, "model_ID", model_ID, True)

results_df.to_csv('../data/results.csv', index = False)
