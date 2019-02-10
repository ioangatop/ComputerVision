function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, images_count] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);
fprintf('Size image_stack = %d %d %d.\n\n', size(image_stack));
% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for i = 1:h
    for j = 1:w
        iVector = reshape(image_stack(i, j, :), [images_count,1]);
        %fprintf('Size iVector = %d %d.\n\n', size(iVector));
        if all(iVector(:) == 0)
           continue 
        end
        %fprintf('Size scriptI = %d %d.\n\n', size(scriptI));
        %fprintf('Size scriptV = %d %d.\n\n', size(scriptV));

        if shadow_trick == true
            scriptI = diag(iVector);
            A = scriptI * scriptV;
            B = scriptI * iVector;
            g = linsolve(A, B);
        else
            g = mldivide(iVector, scriptV);
        end

        %fprintf('Size A = %d %d.\n\n', size(A));
        %fprintf('Size B = %d %d.\n\n', size(B));
        
        %fprintf('Size g = %d %d.\n\n', size(g));
        %fprintf('g = %d %d %d.\n\n', g);
        %fprintf('Size dist = %d %d.\n\n', size(dist(g)));
        albedo(i, j) = norm(g);
        
        if albedo(i, j) ~= 0
            normal(i, j, :) = g / albedo(i, j);
        end
    end
end

% fprintf('Size albedo = %d %d.\n\n', size(albedo));
% fprintf('Size normal = %d %d %d.\n\n', size(normal));

%img_albedo = uint8(albedo);
%imshow(img_albedo)
% =========================================================================

end

