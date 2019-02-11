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

% Fill nans with 0
p(isnan(p)) = 0;
q(isnan(q)) = 0;

% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivative by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% Second derivatives
p2 = gradient(p);
q2 = gradient(q);

% Compute Squared Errors
SE = (p2 - q2).^2;

% ========================================================================
end

