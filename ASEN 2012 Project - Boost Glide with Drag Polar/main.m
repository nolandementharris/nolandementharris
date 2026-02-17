% Author(s): Abby Moon, Nolan Harris
% Assignment title: 2012 Project 1
% Purpose: The purpose of this project is to compute the rate of change of
    % the sensors’ calibration in order to analyze a data set that contains
    % different channels of information. We also need to find the
    % associated uncertainties of this rate of change to create two linear
    % equations for the channels. We will need to apply these calibration
    % fits to the test runs in order to plot the force as a function of
    % time with associated error bars.
% Creation date: 10/23/23
% Revisions: 11/3/23

clc;
clear;
close all;

% Read In Calibration Data
matrix = readmatrix("Static Test Stand Calibration Case 3.xlsx");
weight = matrix(:,1);
offset = matrix(:,2:3);
fmv = matrix(:,4:5);

% Calculate Effective Voltage
Veffective = fmv - offset;
Veff0 = Veffective(:,1);
Veff1 = Veffective(:,2);
Vtotal = Veff0 + Veff1;

% Calculate Load Force
[Load0] = loadch(weight,Veff0,Vtotal);
[Load1] = loadch(weight,Veff1,Vtotal);

% Find Polynomial Coefficient for Calibration Data
[p0,S0] = polyfit(weight,Load0,1);
[p1,S1] = polyfit(weight,Load1,1);

% Find Error for Calibration Data
[y0,delta0] = polyval(p0,weight,S0);
[y1,delta1] = polyval(p1,weight,S1);

% Find the Line of Best Fit for Calibration Data
f = p0(1) * weight + p0(2);
g = p1(1) * weight + p1(2);

% Find the Calibration Slope
[coeff] = polyfit(weight,Vtotal,1);

% Scatter Plot and Line of Best Fit for Calibration Sensor 0
figure();
hold on;
scatter(weight,Load0)
hold on;
plot(weight,f,'Color','red')
hold on;
plot(weight,(f + (2*delta0)),'k--')
hold on;
plot(weight,(f - (2*delta0)),'k--')
hold on;
xlim([0 21]);
ylim([-1 10]);
title('Calibration Curve (Sensor 0)');
ylabel("Voltage (mV)");
xlabel("Weight (lb)");
legend('Data Points','Line of Best Fit','+ Standard Deviation', ...
    '- Standard Deviation','Location','northwest');

% Scatter Plot and Line of Best Fit for Calibration Sensor 1
figure();
hold on;
scatter(weight,Load1)
hold on;
plot(weight,g)
hold on;
plot(weight,(g + (2*delta1)),'k--')
hold on;
plot(weight,(g - (2*delta1)),'k--')
hold on;
xlim([0 21]);
ylim([-1 13]);
title('Calibration Curve (Sensor 1)');
ylabel("Voltage (mV)");
xlabel("Weight (lb)");
legend('Data Points','Line of Best Fit','+ Standard Deviation', ...
    '- Standard Deviation','Location','northwest');

% Test Run 21
    % Load in Data
    test_21 = load('testrun21.mat');

    % Find and Graph Usable Data
    [f_21] = plotTestRun(test_21,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 21')

% Test Run 22
    % Load in Data
    test_22 = load('testrun22.mat');

    % Find and Graph Usable Data
    [f_22] = plotTestRun(test_22,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 22')

% Test Run 23
    % Load in Data
    test_23 = load('testrun23.mat');

    % Find and Graph Usable Data
    [f_23] = plotTestRun(test_23,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 23')

% Test Run 24
    % Load in Data
    test_24 = load('testrun24.mat');

    % Find and Graph Usable Data
    [f_24] = plotTestRun(test_24,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 24')

% Test Run 25
    % Load in Data
    test_25 = load('testrun25.mat');

    % Find and Graph Usable Data
    [f_25] = plotTestRun(test_25,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 25')

% Test Run 26
    % Load in Data
    test_26 = load('testrun26.mat');

    % Find and Graph Usable Data
    [f_26] = plotTestRun(test_26,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 26')

% Test Run 27
    % Load in Data
    test_27 = load('testrun27.mat');

    % Find and Graph Usable Data
    [f_27] = plotTestRun(test_27,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 27')

% Test Run 28
    % Load in Data
    test_28 = load('testrun28.mat');

    % Find and Graph Usable Data
    [f_28] = plotTestRun(test_28,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 28')

% Test Run 29
    % Load in Data
    test_29 = load('testrun29.mat');

    % Find and Graph Usable Data
    [f_29] = plotTestRun(test_29,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 29')

% Test Run 30
    % Load in Data
    test_30 = load('testrun30.mat');

    % Find and Graph Usable Data
    [f_30] = plotTestRun(test_30,coeff,p0,S0,p1,S1);

    % Label Graph
    title('Test Run 30')

% FUNCTION DEFINIIONS
    % loadch Function
    function [load] = loadch(appliedload,eff,efftotal)
    % This function finds weighted average of the load applied to each
    % individual cell.
        % First, the function will create a load vector of the same size as
        % the input weight vector. Then, a for loop is ran to multiply each
        % applied load by the effective voltage divided by the total
        % voltage for a certain channel.
    
        % Create a Zero Vector for the Final Weighted Load
        load = zeros(size(appliedload));
        
        % Calculate the Final Weighted Load
        for i = 1:length(appliedload)
            load(i) = appliedload(i) * (eff(i)/efftotal(i));
        end
    
    end
    
    % plotTestRun Function
    function [f] = plotTestRun(test,coeff,p0,S0,p1,S1)
    % This function manipulates the data in a test run in order to find the
    % total force and time associated with the set and then graph the
    % solution.
        % First, the function takes the loaded in data (in the variable
        % 'test') and seperates out the time and the measured mV of both
        % channels. Then, the error is found with polyval based on the
        % Calibration fit from earlier. The interval for placing error
        % bars are found, and the line of best fit for the data is created.
        % Finally, the total force is plotted as a function of time and the
        % error bars are added. The plot is then output when called in 
        % main.
        
        % Seperate Data
        mv = test.mV;
        mv0 = mv(:,1);
        mv1 = mv(:,2);
        time = test.time;
        mvTotal = mv0 + mv1;
        load = mvTotal/coeff(1);
    
        % Create Error
        [y0,delta0] = polyval(p0,time,S0);
        [y1,delta1] = polyval(p1,time,S1);
        deltaTotal = (2 * delta0) + (2 * delta1);
        
        % Create Inverval for Error Bars
        plotDT = deltaTotal;
        N = length(time);
        for j = 1:N
            j1 = 1:100:N;
            if j ~= j1
                plotDT(j) = NaN;
            end
        end
    
        % Create Line of Best Fit for Dataset
        force0 = p0(1) * load + p0(2);
        force1 = p1(1) * load + p1(2);
        forceTotal = force0 + force1;
    
        % Find Peak Thrust and Error Bounds
            % Find Maximum Force Value
            peakThrust = max(forceTotal);
            
            % Find the Associated Error at this Force Value
            L = length(forceTotal);
            for i = 1:L
                if peakThrust == forceTotal(i)
                    peakDT = deltaTotal(i);
                end
            end
    
        % Plot Test Run
        f = figure();
        hold on;
        errorbar(time,forceTotal,plotDT,'Color','blue')
        hold on;
        plot(time,forceTotal,'Color','red')
        hold on;
        string = ['Peak Thrust = ' num2str(peakThrust), ' lb, +/- ', num2str(peakDT) ' lb'];
        t = text(3,30,string);
        t.FontSize = 10;
        xlim([-1 9])
        xlabel('Time (s)')
        ylabel('Force (lb)')
        legend('Error Bars','Force Data')
    
    end
