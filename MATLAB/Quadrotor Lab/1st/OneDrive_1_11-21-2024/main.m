
clc;
clear;
close all;

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
motor_forces = -[Zc/4; Zc/4; Zc/4; Zc/4];
length_vec = ones(4, length(tspan))
length_vec(1,:) = motor_forces(1);
length_vec(2,:) = motor_forces(2);
length_vec(3,:) = motor_forces(2);
length_vec(4,:) = motor_forces(2);

motor_input = transpose(length_vec);

% change this vector for different simulation conditions
var_0 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];


% motor_forces =  Fz * [1/4; 1/4; 1/4; 1/4];



var_0(4) = deg2rad(5);
t = 0;
var_dot = QuadrotorEOM(t,var_0,g,mass,I,d,km,nu,mu,motor_forces)


% [time,aircraft_state_array] = ode45(@(t,var)QuadrotorEOM(t, var, g, mass, I, d, km, nu, mu, motor_forces), tspan, var_0);
% 
% 
% figure(1)
% plot3(aircraft_state_array(:,1), aircraft_state_array(:,2), aircraft_state_array(:,3))
% hold on
% xlabel('North')
% ylabel('East')
% zlabel('Down')
% 
% fig = [1;2;3;4;5;6;7];
% col = 'b-';
% PlotAircraftSim(time, aircraft_state_array, motor_input, fig, col)