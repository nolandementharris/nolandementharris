function [f] = plotTestRun(test,coeff,p0,S0,p1,S1)
% This function manipulates the data in a test run in order to find the
% total force and time associated with the set and then graph the solution.
    % First, the function takes the loaded in data (in the variable 'test')
    % and seperates out the time and the measured mV of both channels.
    % Then, the error is found with polyval based on the callibration fit
    % from earlier. The interval for placing error bars are found, and the
    % line of best fit for the data is created. Finally, the total force is
    % plotted as a function of time and the error bars are added. The plot
    % is then output when called in main.
    
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