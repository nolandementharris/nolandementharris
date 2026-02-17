% Leya Shaw, Kiah May, Nolan Harris, Spencer Hoehl
% ASEN 3801
% Task 2
% Created: 15/11/2024

%% Setup
clc;
clear;
close all;

% given quantities
mass = 0.068; % kg
d = 0.060; % m
km = 0.0024;% N*m/(N)
Ix = 5.8E-5; % kg*m^2
Iy = 7.2E-5; % kg*m^2
Iz = 1.0E-4; % kg*m^2
nu = 1E-3; % N/(m/s)^2
mu = 2E-6; % N*m/(rad/s)^2
tspan = 0:.1:10; % s
g = 9.81; % m/s^2
I = [Ix; Iy; Iz];
Zc = mass*g; % N
motor_forces = [Zc/4; Zc/4; Zc/4; Zc/4]; % N

%% 2.1 
% Simulate the response of the nonlinear quadrotor equations of motion to 
% initial condition deviations from the steady hover trim state as follows 
% (use a 10 sec simulation window):
    % a) Deviation by +5 deg in roll
    % b) Deviation by +5 deg in yaw
    % c) Deviation by +0.1 rad/sec in pitch rate
    % d) Deviation by +0.1 rad/sec in yaw rate
% Plot and discuss the resulting behavior. Does it make physical sense? Do the results agree
% with your conclusion in Problem 1.4? For this problem, only include the figure with the
% time history of all states and control inputs (Figure 7 from PlotAircraftSim.m) in your
% submission.

% calculate motor input
length_vec = ones(4, length(tspan));
length_vec(1,:) = motor_forces(1);
length_vec(2,:) = motor_forces(2);
length_vec(3,:) = motor_forces(3);
length_vec(4,:) = motor_forces(4);
motor_input = transpose(length_vec);

% inital state vector
xE0 = 0;
yE0 = 0;
zE0 = 0;
phi0 = atan(nu * 5^2 / (mass * g)) + 5; % assuming degrees
theta0 = 0;
psi0 = 5; % assuming degrees
uE0 = 0;
vE0 = 5 * cosd(phi0);  
wE0 = -5 * sind(phi0); 
p0 = 0; 
q0 = 0.1; % rad/sec
r0 = 0.1; % rad/sec
Fz = mass*g / cosd(abs(phi0)); % I put this in degrees

% motor_forces =  Fz * [1/4; 1/4; 1/4; 1/4];

initialState = [xE0; yE0; zE0; phi0; theta0; psi0; uE0; vE0; wE0; p0; q0; r0];

% ODE45 calculation
[time_non, aircraft_state_array_non] = ode45(@(t,var)QuadrotorEOM(t, var, g, mass, I, d, km, nu, mu, motor_forces), tspan, initialState);

% should be comparable with the example plot on the last page of lab doc
fig = [1;2;3;4;5;6;7];
col = 'r';
PlotAircraftSim(time_non, aircraft_state_array_non, motor_input, fig, col);

%% 2.2
% Do not to plot responses from multiple deviations on
% the same plot. For example, don't plot responses to deviations +5 deg roll and +5 deg
% yaw on the same plots, but do plot linearized and nonlinear responses for +5 deg roll
% on the same plot)

% tbh, the instructions were a little confusing
% somehow we combine the linearized and nonlinear responses on the same
% plots?

% need help with these
deltaFc = [0 0 0]; 
deltaGc = [0 0 0];

[time_lin, aircraft_state_array_lin] = ode45(@(t,var)QuadrotorEOM_Linearized(t, var, g, mass, I, deltaFc, deltaGc), tspan, initialState);
% fig = [1;2;3;4;5;6;7];
PlotAircraftSim(time_lin, aircraft_state_array_lin, motor_input, fig, 'b');


%% 2.3 
% Function Developed

%% 2.4
% Function Developed

%% 2.5 
% Add the feedback controller to your nonlinear quadrotor equations of motion. Create a
% new equation of motion function with the feedback controller from Problem 2.3 in it:
% Repeat simulations for the setups in Problems 2.1.c and 2.1.d. What is the effect of this
% control law? Support your argument with new plots for each setup, overlaying the
% controlled and uncontrolled nonlinear systems.

% Function Developed

%% Save Graphs
% Part 2.1/2.2
% a (roll dev)
% saveas(1,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_1.jpg");
% saveas(2,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_2.jpg");
% saveas(3,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_3.jpg");
% saveas(4,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_4.jpg");
% saveas(5,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_5.jpg");
% saveas(6,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll_6.jpg");
% saveas(7,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_roll.jpg");

% b (yaw dev)
% saveas(8,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_1.jpg");
% saveas(9,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_2.jpg");
% saveas(10,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_3.jpg");
% saveas(11,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_4.jpg");
% saveas(12,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_5.jpg");
% saveas(13,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_6.jpg");
% saveas(14,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_.jpg");

% c (pitch rate)
% saveas(15,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_1.jpg");
% saveas(16,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_2.jpg");
% saveas(17,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_3.jpg");
% saveas(18,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_4.jpg");
% saveas(19,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_5.jpg");
% saveas(20,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate_6.jpg");
% saveas(21,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_pitch_rate.jpg");

% d (yaw rate)
% saveas(22,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_1.jpg");
% saveas(23,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_2.jpg");
% saveas(24,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_3.jpg");
% saveas(25,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_4.jpg");
% saveas(26,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_5.jpg");
% saveas(27,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate_6.jpg");
% saveas(28,"plots/ASEN3801_Lab_4_Problem2_no_control_nonlin_lin_yaw_rate.jpg");

% Part 5
% a (pitch rate)
% saveas(29,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_1.jpg");
% saveas(30,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_2.jpg");
% saveas(31,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_3.jpg");
% saveas(32,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_4.jpg");
% saveas(33,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_5.jpg");
% saveas(34,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate_6.jpg");
% saveas(35,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_pitch_rate.jpg");

% b (yaw rate)
% saveas(36,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_1.jpg");
% saveas(37,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_2.jpg");
% saveas(38,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_3.jpg");
% saveas(39,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_4.jpg");
% saveas(40,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_5.jpg");
% saveas(41,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate_6.jpg");
% saveas(42,"plots/ASEN3801_Lab_4_Problem2_control_nonlin_lin_yaw_rate.jpg");