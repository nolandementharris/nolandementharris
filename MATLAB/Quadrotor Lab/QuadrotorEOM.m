function var_dot = QuadrotorEOM(t, var, g, m, I, d, km, nu, mu, motor_forces)
% Purpose: Create a simulation of a quadrotor in Matlab using ode45
% Inputs: 
%       t: time
%       var: state vec
%       g: gravity (kg m/s^2)
%       m: mass (kg)
%       I: 3x1 matrix of inertias 
%       d: Radial distance from CG to propeller (m)
%       km: Control moment coefficient
%       nu: Aerodynamic force coefficient
%       mu: Aerodynamic moment coefficient
%       motor_forces: forces from each motor
% Outputs:
%       var_dot: derivitive state vector

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
    
    % calcuatle control forces from given matrix
    control = [-1 -1 -1 -1; 
               -d/sqrt(2) -d/sqrt(2) d/sqrt(2) d/sqrt(2); 
                d/sqrt(2) -d/sqrt(2) -d/sqrt(2) d/sqrt(2); 
                km -km km -km];
    control_forces = control*motor_forces;

    % pull each of the four control forces from the matrix
    Zc = control_forces(1);
    Lc = control_forces(2);
    Mc = control_forces(3);
    Nc = control_forces(4);
    
    % DCM Matrix
    DCM = [cos(theta)*cos(psi)    sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi)      cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi);
           cos(theta)*sin(psi)    sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi)      cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
           -sin(theta)            sin(phi)*cos(theta)                                 cos(phi)*cos(theta)];
    position_dot = DCM*[u;v;w];
    
    % pull positions from DCM
    x_dot = position_dot(1);
    y_dot = position_dot(2);
    z_dot = position_dot(3);
    
    % DCM Angles 
    DCM_angles = [1     sin(phi)*tan(theta)     cos(phi)*tan(theta);
                  0     cos(phi)                -sin(phi);
                  0       sin(phi)*sec(theta)     cos(phi)*sec(theta)];
    angles_dot = DCM_angles*[p;q;r];
   
    % pull angles from DCM
    phi_dot = angles_dot(1);
    theta_dot = angles_dot(2);
    psi_dot = angles_dot(3);

    % calcuate the forces in each direction
    forces = -nu * sqrt(u^2 + v^2 + w^2) * [u; v; w];

    % pull each of the forces
    X = forces(1);
    Y = forces(2);
    Z = forces(3);
    
    % caluclate u,v,w dot
    u_dot = r*v -q*w + g*(-sin(theta)) + 1/m*X;
    v_dot = p*w -r*u + g*(cos(theta)*sin(phi)) +1/m*Y;
    w_dot = q*u -p*v + g*(cos(theta)*cos(phi)) +1/m*Z + 1/m*Zc;

    % calcualtate moments and pull individual moments
    moments = -mu * sqrt(p^2 + q^2 + r^2) * [p; q; r];
    L = moments(1);
    M = moments(2);
    N = moments(3);
    
    % pull interia values from I 
    Ix = I(1);
    Iy = I(2);
    Iz = I(3);

    % calcualte p, q, r dot
    p_dot = (Iy-Iz)/Ix *q*r + L/Ix + Lc/Ix;
    q_dot = (Iz-Ix)/Iy *p*r + M/Iy + Mc/Iy;
    r_dot = (Ix-Iy)/Iz *p*q + N/Iz + Nc/Iz;
    
    % output vector
    var_dot = [x_dot; y_dot; z_dot; phi_dot; theta_dot; psi_dot; u_dot; v_dot; w_dot; p_dot; q_dot; r_dot];

end
