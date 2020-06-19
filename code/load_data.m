function Data = load_data()
%% Function to load raw data 
% file paths referenced to mehcoeg level. 
% Make sure it is set to current directory (using cd)

d13_data = csvread('./data/Sun_d13C_Data.csv', 1);
temp_data = csvread('../data/Temp_data.csv', 1);
sr_data = csvread('../data/Sr_data.csv', 1);

Data = struct('d13_data', d13_data, ...
              'temp_data', temp_data, ...
              'sr_data', sr_data);

end