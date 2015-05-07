
% Clear workspace variables, close existing figures and clear current
% console (to blank)
clear all; close all; clc;
%% MODEL LOADING AND CONFIGURATION
% The SBProj file is loaded. We create a variable m that points to the
% model of interest within that file.  We then load that model's default
% simulation ConfigSet into cs. We set the SolverType and StopTime (24
% hours in seconds)

% Load SimBiology Project file
[projFileName, projPathName] = uigetfile('*.sbproj', 'Select SimBiology project file');
if isequal(projFileName, 0)
    error('Must select a valid SBProj file!')
end
file = sbioloadproject(fullfile(projPathName, projFileName ));

    %Pathway to file on my personal laptop
% Load model of interest from file to local variable m
m = file.m1;

% Load default simulation ConfigSet from model. The ConfigSet contains
% settings that pertain to simulating our model, such as the simulation
% solving algorithm (SSA, ODE15, Sundials, etc.) and the simulation end
% time. We will simulate our model using the ODE15 solver and simulating over 24
% hours. (Note: the ConfigSet by default expresses the time in units
% seconds. The time units can be changed, but for simplicity we will simply
% express our twenty-four hours in seconds (86400 seconds.)
cs = getconfigset(m, 'default');
set(cs, 'SolverType', 'sundials');
set(cs, 'StopTime', 86400);


% Occasional outputs such as below provide progress updates
disp('[Notice] Model Initialized successfully')

% HERE IS WHERE YOU CONFIGURE ANY PARAMETER VALUES AND OTHER SETTINGS


%% Simulation Looping
% Loop through the differnet sets of parameter values
disp('[Status] Initialization and Configuration Complete.\n [Status] Begining simulations.')

        
% Ensure default values.
% results into tempResults
try
	tempResults = sbiosimulate(m, cs, [], []);
catch exception
        exception
        continue
end
data = tempResults.Data;
time = tempResults.time;
        
        

disp('[Status] Complete!')
