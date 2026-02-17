function motor_forces = ComputeMotorForces(Fc, Gc, d, km)
% Nolan Harris
% ASEN 3801
% InnerLoopFeedback
% Created: 8/11/24
% Calculate the motor thrust forces given the control force and moments
% INPUTS: 
    % Fc: control thrust vector
    % Gc: control moment vector 
    % d: distance from aircraft CG to each rotor 
    % km: is the control moment coefficient.
% OUTPUTS: 
    % motor_forces: i4 x 1 column vector [f 1 , f 2 , f 3 , f4 ]^T .

    % moment coefficient matrix
    moment_mat_coeff = [-1 -1 -1 -1; 
                        -d/sqrt(2), -d/sqrt(2),  d/sqrt(2), d/sqrt(2);
                         d/sqrt(2), -d/sqrt(2), -d/sqrt(2), d/sqrt(2); 
                         km, -km, km, -km];
    % pull Zc from Fc
    Zc = Fc(3);

    % create moment vector
    moment = [Zc; Gc'];

    % output of motor forces
    motor_forces = moment_mat_coeff'*moment;

end