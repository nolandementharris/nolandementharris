function var_dot = QuadrotorEOM_Linearized(t, var, g, m, I, deltaFc, deltaGc)
% Kiah May
% ASEN 3801 Lab 4
% QuadrotorEOM_Linearized
% Created: 15/11/2024

% Lnearized equations of motion
% INPUTS:
    % t: time
    % var: state vec
    % g: gravity
    % m: mass
    % I: inertia matrix
    % deltaFc: change in forces (derived)
    % deltaGc: change in moments (derived)
% OUTPUTS:
    % var_dot: derivative state vector

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

    % Pull Zc from  deltaFc
    Zc = deltaFc(3);

    % Pull Lc,Mc,Nc from  deltaGc
    Lc = deltaGc(1);
    Mc = deltaGc(2);
    Nc = deltaGc(3);

    % pull interia values from I 
    Ix = I(1);
    Iy = I(2);
    Iz = I(3);

    % derivatives
    xdot = u;
    ydot = v;
    zdot = w;
    phi_dot = p;
    theta_dot = q;
    psi_dot = r;
    udot = g*(-theta);
    vdot = g*phi;
    wdot = Zc/m;
    p_dot = Lc/Ix;
    q_dot = Mc/Iy;
    r_dot = Nc/Iz;

    % output vector
    var_dot = [xdot ydot zdot phi_dot theta_dot psi_dot udot vdot wdot p_dot q_dot r_dot]';
    
end