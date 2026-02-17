function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col)
% This function is used to plot the results of a full simulation once it is complete. 
% INPUTS: 
    % time (length n)
    % the 12 x n array of aircraft states
    % the 4 by n array of the motor force control inputs
    % the 7 x 1 vector of figure numbers fig to plot over, 
    % col, plotting options (string)
% OUTPUTS: 
    % 7 figures:
        % 1: Position
        % 2: Euler Angles
        % 3: Inertial Vel in Body Frame
        % 4: Angular Velocity
        % 5: one figure with four subplots for each control input variable
        % 6: three-dimensional path of the aircraft, with positive height upward in the figure. 
            % This figure should indicate the start (green) and finish (red) of the path with different colored markers.
        % 7: one figure that has an 8 x 2 grid of subplots
            % The first column should have individual plots for the time 
            % history of the inertial position components, the Euler angles, 
            % and the first two control inputs. 
            % The second column has time history plots of the velocity components, 
            % angular velocity components, and last two motor forces. 

            aircraft_state_array(:,4:6) = aircraft_state_array(:,4:6) * 180/pi;
            aircraft_state_array(:,10:12) = aircraft_state_array(:,10:12) * 180/pi;


% Plot figures 1-4

    % Inertial Position
    figure(fig(1))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,1), col); hold on;
    title("Inertial X aircraft position");
    xlabel("Time (s)");
    ylabel("X Position (m)")
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,2), col); hold on;
    title("Inertial Y aircraft position");
    xlabel("Time (s)");
    ylabel("Y Position (m)")
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,3), col); hold on;
    title("Inertial Z aircraft position");
     xlabel("Time (s)");
    ylabel("Z Position (m)")
    
    % Euler Angles
    figure(fig(2))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,4), col); hold on;
    title("Euler Angles");
    xlabel("Time (s)");
    ylabel("Phi (deg)");
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,5), col); hold on;
    title("Euler Angles");
    xlabel("Time (s)");
    ylabel("Theta (deg)");
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,6), col); hold on;
    title("Euler Angles");
    xlabel("Time (s)");
    ylabel("Psi (deg)");

    % Inertial Velocity 
    figure(fig(3))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,7), col); hold on;
    title("U Inertial Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("U Velocity (m/s)");
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,8), col); hold on;
    title("Inertial Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("V Velocity (m/s)");
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,9), col); hold on;
    title("Inertial Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("W Velocity (m/s)");

    % Angular Velocity
    figure(fig(4))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,10), col); hold on;
    title("Angular Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("p (deg/s)");
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,11), col); hold on;
    title("Angular Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("q (deg/s)");
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,12), col); hold on;
    title("Angular Velocity - Body Frame");
    xlabel("Time (s)");
    ylabel("r (deg/s)");

%% Figure 5
    figure(fig(5))
    subplot(4,2,1)
    plot(time,control_input_array(:,1),col); hold on;
    subplot(4,2,2)
    plot(time,control_input_array(:,2),col); hold on;
    subplot(4,2,3)
    plot(time,control_input_array(:,3),col); hold on;
    subplot(4,2,4)
    plot(time,control_input_array(:,4),col); hold on;

%% Figure 6
    figure(fig(6))
    hold on;
    plot3(aircraft_state_array(:,1),aircraft_state_array(:,2), aircraft_state_array(:,3), col); hold on; % Unsure of which sign to put for z axis, We need to check this before moving on
    plot3(aircraft_state_array(1,1),aircraft_state_array(2,1), aircraft_state_array(3,1),'.', 'MarkerSize', 15, 'Color', 'g'); 
    plot3(aircraft_state_array(end,1),aircraft_state_array(end,2), aircraft_state_array(end,3),'.', 'MarkerSize', 15,'Color', 'r');
    xlabel('North (m)')
    ylabel('East (m)')
    zlabel('Vertical (m)')
    view(70,30)
    title("Path of Aircraft");
    
%% Figure 7
    figure()
    subplot(8,2,1)
    plot(time,aircraft_state_array(:,1), col); hold on;
    ylabel('X(m)')
    subplot(8,2,3)
    plot(time,aircraft_state_array(:,2), col); hold on;
    ylabel('Y(m)')
    subplot(8,2,5)
    plot(time,aircraft_state_array(:,3), col); hold on;
    ylabel('Z(m)')
    subplot(8,2,7)
    plot(time,aircraft_state_array(:,4), col); hold on;
    ylabel('phi(deg)')
    subplot(8,2,9)
    plot(time,aircraft_state_array(:,5), col); hold on;
    ylabel('theta(deg)')
    subplot(8,2,11)
    plot(time,aircraft_state_array(:,6), col); hold on;
    ylabel('psi(deg)')
    subplot(8,2,13)
    plot(time,control_input_array(:,1), col); hold on;
    ylabel('f1(N)')
    subplot(8,2,15)
    plot(time,control_input_array(:,2), col); hold on;
    ylabel('f2(N)')
    subplot(8,2,2)
    plot(time,aircraft_state_array(:,7), col); hold on;
    ylabel('Ue(m/s)')
    subplot(8,2,4)
    plot(time,aircraft_state_array(:,8), col); hold on;
    ylabel('Ve(m/s)')
    subplot(8,2,6)
    plot(time,aircraft_state_array(:,9), col); hold on;
    ylabel('We(m/s)')
    subplot(8,2,8)
    plot(time,aircraft_state_array(:,10), col); hold on;
    ylabel('p(deg/s)')
    subplot(8,2,10)
    plot(time,aircraft_state_array(:,11), col); hold on;
    ylabel('q(deg/s)')
    subplot(8,2,12)
    plot(time,aircraft_state_array(:,12), col); hold on;
    ylabel('r(deg/s)')
    subplot(8,2,14)
    plot(time,control_input_array(:,3), col); hold on;
    ylabel('f3(N)')
    subplot(8,2,16)
    plot(time,control_input_array(:,4), col); hold on;
    ylabel('f4(N)')
    
end