% ADD K VALUES WHEN CALCUALTED
function [Fc, Gc] = InnerLoopFeedback(var)
% Kiah May
% ASEN 3801
% InnerLoopFeedback
% Created: 8/11/24

% Purpose: calculate the control vectors Fc and Gc
% Inputs: 
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

    % lateral gains
    k1_lat = 0.001276;
    k2_lat = 0.00232;
    k3_lat = 1.102e-4;

    % longitudinal gains
    k1_long = 0.001584;
    k2_long = 0.00288;
    k3_long = -1.368e-4;

    %spin
    k_spin = -.004;

    % moments
    Lc = -k2_lat*phi -k1_lat*p; % Nm
    Mc = -k2_long*theta -k1_long*q; % Nm
    Nc = -k_spin*r; % Nm

    % outputs
    Fc = [0 0 Zc];
    Gc = [Lc Mc Nc];
end
