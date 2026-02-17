function var_dot = QuadrotorEOM_Non_Linear(time,var, g, m, I, d, km, nu, mu)
% Nolan Harris
% ASEN 3801 Lab 4
% QuadrotorEOM_Non_Linear
% Created: 21/11/2024

% Find Motor Forces
[Fc, Gc] = InnerLoopFeedback(var);
motor_forces = ComputeMotorForces(Fc,Gc,d,km);

% Call Quadrotor EOM 
var_dot = QuadrotorEOM(time,var,g,m,I,d,km,nu,mu,motor_forces);


end

