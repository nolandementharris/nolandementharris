vfunction [load] = loadch(appliedload,eff,efftotal)
% This function finds weighted average of the load applied to each
% individual cell.
    % First, the function will create a load vector of the same size as the
    % input weight vector. Then, a for loop is ran to multiply each applied
    % load by the effective voltage divided by the total voltage for a 
    % certain channel.

% Create a Zero Vector for the Final Weighted Load
load = zeros(size(appliedload));

% Calculate the Final Weighted Load
for i = 1:length(appliedload)
    load(i) = appliedload(i) * (eff(i)/efftotal(i));
end

end