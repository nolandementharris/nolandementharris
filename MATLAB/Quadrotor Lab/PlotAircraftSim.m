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

% Plot figures 1-4

    % Inertial Position
    figure(fig(1))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,1), col); hold on;
    xlabel('time (s)')
    ylabel('X (m)')
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,2), col); hold on;
    xlabel('time (s)')
    ylabel('Y (m)')
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,3), col); hold on;
    xlabel('time (s)')
    ylabel('Z (m)')
    
    % Euler Angles
    figure(fig(2))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,4), col); hold on;
    xlabel('time (s)')
    ylabel('phi (rad)')
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,5), col); hold on;
    xlabel('time (s)')
    ylabel('theta (rad)')
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,6), col); hold on;
    xlabel('time (s)')
    ylabel('psi (rad)')

    % Inertial Velocity 
    figure(fig(3))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,7), col); hold on;
    xlabel('time (s)')
    ylabel('U (m/s)')
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,8), col); hold on;
    xlabel('time (s)')
    ylabel('V (m/s)')
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,9), col); hold on;
    xlabel('time (s)')
    ylabel('W (m/s)')

    % Angular Velocity
    figure(fig(4))
    subplot(3,1,1)
    plot(time,aircraft_state_array(:,10), col); hold on;
    xlabel('time (s)')
    ylabel('p (rad/s)')
    subplot(3,1,2)
    plot(time,aircraft_state_array(:,11), col); hold on;
    xlabel('time (s)')
    ylabel('q (rad/s)')
    subplot(3,1,3)
    plot(time,aircraft_state_array(:,12), col); hold on;
    xlabel('time (s)')
    ylabel('r (rad/s)')

%% Figure 5
    figure(fig(5))
    subplot(4,2,1)
    plot(time,control_input_array(1,:),col); hold on;
    xlabel('time (s)')
    ylabel('Lc (N)')
    subplot(4,2,2)
    plot(time,control_input_array(2,:),col); hold on;
    xlabel('time (s)')
    ylabel('Mc (N)')
    subplot(4,2,3)
    plot(time,control_input_array(3,:),col); hold on;
    xlabel('time (s)')
    ylabel('Nc (N)')
    subplot(4,2,4)
    plot(time,control_input_array(4,:),col); hold on;
    xlabel('time (s)')
    ylabel('Zc (N)')

%% Figure 6
    figure(fig(6))
    hold on;
    plot3(aircraft_state_array(:,1),aircraft_state_array(:,2), aircraft_state_array(:,3), col); hold on; % Unsure of which sign to put for z axis, We need to check this before moving on
    plot3(aircraft_state_array(1,1),aircraft_state_array(2,1), aircraft_state_array(3,1),'.', 'MarkerSize', 10, 'Color', 'g'); 
    plot3(aircraft_state_array(1,end),aircraft_state_array(2,end), aircraft_state_array(3,end),'.', 'MarkerSize', 10,'Color', 'r');
    xlabel('X (m)')
    ylabel('Y (m)')
    zlabel('Z (m)')

    
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
    ylabel('phi(rad)')
    subplot(8,2,9)
    plot(time,aircraft_state_array(:,5), col); hold on;
    ylabel('theta(rad)')
    subplot(8,2,11)
    plot(time,aircraft_state_array(:,6), col); hold on;
    ylabel('psi(rad)')
    subplot(8,2,13)
    plot(time,control_input_array(1,:), col); hold on;
    ylabel('f1(N)')
    subplot(8,2,15)
    plot(time,control_input_array(2,:), col); hold on;
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
    ylabel('p(rad)')
    subplot(8,2,10)
    plot(time,aircraft_state_array(:,11), col); hold on;
    ylabel('q(rad)')
    subplot(8,2,12)
    plot(time,aircraft_state_array(:,12), col); hold on;
    ylabel('r(rad)')
    subplot(8,2,14)
    plot(time,control_input_array(3,:), col); hold on;
    ylabel('f3(N)')
    subplot(8,2,16)
    plot(time,control_input_array(4,:), col); hold on;
    ylabel('f4(N)')
    
end