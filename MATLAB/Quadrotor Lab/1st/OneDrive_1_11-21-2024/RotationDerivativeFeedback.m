function [Fc, Gc] = RotationDerivativeFeedback(var, m, g)
% Kiah May
% ASEN 3801
% Created: 15/11/2024
% Calculate the control vectors Fc and Gc. 
% INPUTS: The function takes as input
    % var: 12x1 aircraft state, 
    % m: aircraft mass
    % g: gravitational acceleration
% OUTPUT:
    % Control Vectors: Fc and Gc
% The control force in the body z-direction should still equal the weight of the quadrotor. 
% Set the control moments about each body axis proportional to the rotational 
% rates about their respective axes, but in the opposite sign of the angular 
% velocity with a gain of 0.004 Nm/(rad/sec)

%given gain
gain = 0.004; % Nm/(rad/sec)

% pull p,q,r, from the state vector
p = var(10);
q = var(11);
r = var(12);

% calculate Zc
Zc = -m*g;

% calculate Lc,Mc,Nc
Lc = -gain * p; 
Mc = -gain * q;
Nc = -gain * r;

Fc = [0 0 Zc];
Gc = [Lc Mc Nc];

end