% ADD K VALUES WHEN CALCUALTED
function [Fc, Gc] = VelocityReferenceFeedback(t, var)
% Kiah May
% ASEN 3801
% VelocityReferenceFeedback
% Created: 8/11/24

% Purpose: calculate the control vectors Fc and Gc
% Inputs: 
%       t: time
%       var: state vec
% Outputs:
%       Fc: Control Force [N]
%       Gc: Control Moment [Nm]

    % declare mass and gravity
    mass = 0.068; % kg
    g = 9.81; % m/s^2
    
    % control force 
    Zc = -mass*g; % N

    % pull variables from var
    x = var(1);
    y = var(2);
    z = var(3);
    phi = var(4);
    theta = var(5);
    psi = var(6);
    u = var(7);
    v = var(8);
    w = var(9);
    p = var(10);
    q = var(11);
    r = var(12);
    V = [u v w];

    % lateral gains
    k1_lat = 0.001276;
    k2_lat = 0.00232;
    k3_lat = 1.102e-4;

    % longitudinal gains
    k1_long = 0.001584;
    k2_long = 0.00288;
    k3_long = -1.368e-4;

    % Find motor control forces
    [Fc, Gc] = InnerLoopFeedback(var);

    % Reference Velocity
        % Input the change in inertial position
        delta_y = 0;
        delta_x = 1;
    t_lim = 2;
        if t < t_lim
            V_reference = [delta_x/t_lim, delte_y/t_lim, 0];
        else
            V_reference = [0,0,0];
        end

    % NEED TO DETERMINE HOW TO CALCUATE LC AND MC BASED ON LAT AND LONG
    Lc = k3_lat*(V-V_reference) + -k2_lat*phi + -k1_lat*p; % Nm
    Mc = k3_long*(V-V_reference) + -k2_long*theta + -k1_long*q; % Nm
    Nc = 0; % Nm

    % outputs
    
    Gc = [Lc; Mc; Nc];
end