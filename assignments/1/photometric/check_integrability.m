function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals));
q = zeros(size(normals));
SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
p = normals(:, :, 1) ./ normals(:, :, 3);
q = normals(:, :, 2) ./ normals(:, :, 3);

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;

fprintf('Size p = %d %d.\n\n', size(p));
fprintf('Size q = %d %d.\n\n', size(q));

% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE
h = 0.001
p2 = gradient(p);
q2 = gradient(q);

fprintf('Size p2 = %d %d.\n\n', size(p2));
fprintf('Size q2 = %d %d.\n\n', size(q2));
SE = (p2 - q2).^2;
fprintf('Size SE = %d %d.\n\n', size(SE));

% ========================================================================




end

