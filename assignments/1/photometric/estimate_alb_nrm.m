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

disp(shadow_trick);

if shadow_trick == 1
    disp('shadow trick');
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================

for i = 1:h
    for j = 1:w
        
        % Getting vector i by flattening the image_stack
        iVector = reshape(image_stack(i, j, :), [images_count,1]);

        % Check if it is a shadowed region
        if all(iVector(:) == 0)
           
            continue 
        
        else

            if shadow_trick == true
                scriptI = diag(iVector);
                A = scriptI * scriptV;
                B = scriptI * iVector;
                g = pinv(A)*B; % Moore-Penrose pseudo-inverse
            else
                g = pinv(scriptV)*iVector;
            end

            % Measuring Albedo
            albedo(i, j) = norm(g);

            % Recovering Normals
            normal(i, j, :) = g / albedo(i, j);
        end
    end
end

% =========================================================================
end

