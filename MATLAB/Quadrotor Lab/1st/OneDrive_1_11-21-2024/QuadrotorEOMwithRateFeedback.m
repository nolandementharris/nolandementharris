function var_dot = QuadrotorEOMwithRateFeedback(t, var, g, m, I, nu, mu)
% Kiah May
% ASEN 3801 Lab 4
% Created: 15/11/2024
% INPUTS: 
    % t: time
    % var: state vec
    % g: gravity
    % m: mass
    % I: inertial 
    % nu: Aerodynamic force coefficient
    % mu: Aerodynamic moment coefficient
% OUTPUTS:
    % var_dot: derivitive state vector

    [Fc, Gc] = RotationDerivativeFeedback(var, m, g);
    motorForces = ComputeMotorForces(Fc, Gc, d, km);
    var_dot = QuadrotorEOM(t, var, g, m, I, d, km, nu, mu, motorForces);

end