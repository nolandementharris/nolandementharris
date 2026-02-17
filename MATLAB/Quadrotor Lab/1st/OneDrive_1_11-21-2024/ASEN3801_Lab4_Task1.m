% Nolan Harris, Spencer Hoehl, Kiah May, Leya Shaw
% ASEN 3801
% Task 1
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
g = 9.81; % m/s^2
I = [Ix; Iy; Iz];
Zc = mass*g; % N
motor_forces = [Zc/4; Zc/4; Zc/4; Zc/4]; % N

%% 1.1
% Function Developed

%% 1.2
% Function Developed

% Simulate steady hover flight for 10 secs by simulating the solution to Lab 4
% Individual Assignment Problem 1. Provide a short description of the resulting
% behavior and verify that it produces equilibrium motion. Include the figure
% (Figure 7 from PlotAircraftSim.m) with the time history of all states and control
% inputs in your submission.

steady_hover = zeros(12,1);
tspan = 0:.1:10; % s
length_vec = ones(4, length(tspan));
length_vec(1,:) = motor_forces(1);
length_vec(2,:) = motor_forces(2);
length_vec(3,:) = motor_forces(3);
length_vec(4,:) = motor_forces(4);
motor_input = transpose(length_vec);

% call to ode45
[time,aircraft_state_array] = ode45(@(t,var)QuadrotorEOM(t, var, g, mass, I, d, km, nu, mu, motor_forces), tspan, steady_hover);

fig = [1;2;3;4;5;6;7];
col = 'b-';
PlotAircraftSim(time, aircraft_state_array, motor_input, fig, col)


%% 1.3 
% Use the EOM and simulation from Problem 1.2 to perform additional simulations to
% verify the results from the preliminary lab questions.

% Simulate trim flight a constant velocity translation at 5 m/s East, while
% maintaining a yaw of 0 deg. This result is the solution to Lab 4 Individual
% Assignment Problem 2. Simulate this trim state for 10 secs. Provide a short
% description of the resulting behavior and verify it produces the expected trim
% motion. Include the figure with the time history of all states and control inputs in
% your submission.

translation_yaw_0 = [0;0;0;-2.146;0;0;0;4.996;0.1872;0;0;0];
tspan = 0:.1:10; % s
length_vec = ones(4, length(tspan));
length_vec(1,:) = motor_forces(1);
length_vec(2,:) = motor_forces(2);
length_vec(3,:) = motor_forces(3);
length_vec(4,:) = motor_forces(4);
motor_input = transpose(length_vec);

% call to ode45
[time,aircraft_state_array] = ode45(@(t,var)QuadrotorEOM(t, var, g, mass, I, d, km, nu, mu, motor_forces), tspan, translation_yaw_0);

fig_2 = [8;9;10;11;12;13;14];
col = 'b-';
PlotAircraftSim(time, aircraft_state_array, motor_input, fig_2, col)

% Simulate the solution to Lab 4 Individual Assignment Problem 3. Simulate this
% trim state for 10 secs. Provide a short description of the resulting behavior and
% verify it produces the expected trim motion. Include the figure with the time
% history of all states and control inputs in your submission.

translation_yaw_90 = [0;0;0;0;2.146;0;4.996;0;0.1872;0;0;0];
tspan = 0:.1:10; % s
length_vec = ones(4, length(tspan));
length_vec(1,:) = motor_forces(1);
length_vec(2,:) = motor_forces(2);
length_vec(3,:) = motor_forces(3);
length_vec(4,:) = motor_forces(4);
motor_input = transpose(length_vec);

% call to ode45
[time,aircraft_state_array] = ode45(@(t,var)QuadrotorEOM(t, var, g, mass, I, d, km, nu, mu, motor_forces), tspan, translation_yaw_90);

fig_3 = [15;16;17;18;19;20;21];
col = 'b-';
PlotAircraftSim(time, aircraft_state_array, motor_input, fig_3, col)

%% 1.4 
% Is steady hovering flight stable for the quadrotor? Determine this through simulation, and
% through the behavior of the hardware demonstration system physically, and via plots of
% translation and rotation over time. A video of the Parrot Mambo flying with no control is
% available at the link below. The data file “RSdata_nocontrol.mat” describes the behavior
% of the quadrotor in the video and is provided with this lab assignment in Canvas (read the
% document “ASEN_3128_Quadcopter_Data_File_Instructions.pdf” for instructions on
% how to work with the data contained in the .mat file).

load('RSdata_nocontrol.mat')
fig_4 = fig+(7*3);
col = 'b-';
time_data = rt_estim.time;
aircraft_state_array_data = rt_estim.signals.values;
motor_input_data = rt_motor.signals.values;
PlotAircraftSim(time_data, aircraft_state_array_data, motor_input_data, fig_4, col)

%% Save Graphs
% Part 2
% saveas(1,"plots/ASEN3801_Lab_4_Problem1_steady_hover_1.jpg");
% saveas(2,"plots/ASEN3801_Lab_4_Problem1_steady_hover_2.jpg");
% saveas(3,"plots/ASEN3801_Lab_4_Problem1_steady_hover_3.jpg");
% saveas(4,"plots/ASEN3801_Lab_4_Problem1_steady_hover_4.jpg");
% saveas(5,"plots/ASEN3801_Lab_4_Problem1_steady_hover_5.jpg");
% saveas(6,"plots/ASEN3801_Lab_4_Problem1_steady_hover_6.jpg");
% saveas(7,"plots/ASEN3801_Lab_4_Problem1_steady_hover.jpg");

% Part 3.1
% saveas(8,"plots/ASEN3801_Lab_4_Problem1_yaw_0_1.jpg");
% saveas(9,"plots/ASEN3801_Lab_4_Problem1_yaw_0_2.jpg");
% saveas(10,"plots/ASEN3801_Lab_4_Problem1_yaw_0_3.jpg");
% saveas(11,"plots/ASEN3801_Lab_4_Problem1_yaw_0_4.jpg");
% saveas(12,"plots/ASEN3801_Lab_4_Problem1_yaw_0_5.jpg");
% saveas(13,"plots/ASEN3801_Lab_4_Problem1_yaw_0_6.jpg");
% saveas(14,"plots/ASEN3801_Lab_4_Problem1_yaw_0.jpg");

% Part 3.2
% saveas(15,"plots/ASEN3801_Lab_4_Problem1_yaw_90_1.jpg");
% saveas(16,"plots/ASEN3801_Lab_4_Problem1_yaw_90_2.jpg");
% saveas(17,"plots/ASEN3801_Lab_4_Problem1_yaw_90_3.jpg");
% saveas(18,"plots/ASEN3801_Lab_4_Problem1_yaw_90_4.jpg");
% saveas(19,"plots/ASEN3801_Lab_4_Problem1_yaw_90_5.jpg");
% saveas(20,"plots/ASEN3801_Lab_4_Problem1_yaw_90_6.jpg");
% saveas(21,"plots/ASEN3801_Lab_4_Problem1_yaw_90.jpg");

% Part 4
% saveas(22,"plots/ASEN3801_Lab_4_Problem1_data_file_1.jpg");
% saveas(23,"plots/ASEN3801_Lab_4_Problem1_data_file_2.jpg");
% saveas(24,"plots/ASEN3801_Lab_4_Problem1_data_file_3.jpg");
% saveas(25,"plots/ASEN3801_Lab_4_Problem1_data_file_4.jpg");
% saveas(26,"plots/ASEN3801_Lab_4_Problem1_data_file_5.jpg");
% saveas(27,"plots/ASEN3801_Lab_4_Problem1_data_file_6.jpg");
% saveas(28,"plots/ASEN3801_Lab_4_Problem1_data_file.jpg");