function [final_grid_x, final_grid_y] = lucas_kanade(image1, image2, visualization, reg_size)
% Lucas Kanade Optical flow 

% Read the two images and compute gradients for entire image
im1 = double(image1);
im2 = double(image2);

[height, width, ~] = size(im1);

region_size = reg_size;
nr_of_regions_horizontal = floor(width/region_size)-1;
nr_of_regions_vertical = floor(height/region_size)-1;

% gradient(im1);
[gx1, gy1] = gradient(im1);

final_grid_x = [];
final_grid_y = [];

% Loop over regions in x direction
for i = 0:nr_of_regions_vertical
    one_row_x = [];
    one_row_y = [];
    % Loop over regions in y direction
    for j = 0:nr_of_regions_horizontal
        
        % Cut image in 15x15 regions of gradients iteratively
        A_region1 = gx1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        A_region2 = gy1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        
        % Reshape each region into a 225x2 vector (by stacking each row on
        % top of each other)
        A = [reshape(A_region1, region_size^2, 1), reshape(A_region2, region_size^2, 1)];
        A_T = A.';
        
        % Cut regular image in 15x15 regions 
        b_region1 = im1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        b_region2 = im2(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        
        % Reshape each region into a 225x1 vector (by stacking each row on top
        % of each other)
        b = reshape(b_region1, region_size^2, 1) - reshape(b_region2, region_size^2, 1);
        
        % Calculate the local image flow vector (v)
        v = pinv(A) * b;
        one_row_x = [one_row_x, v(1:1)];
        one_row_y = [one_row_y, v(2:2)];
    end
    final_grid_x = [final_grid_x; one_row_x];
    final_grid_y = [final_grid_y; one_row_y];
end

% Plot on top of original image using quiver
if visualization
    [x,y] = meshgrid(0:1:nr_of_regions_horizontal,0:1:nr_of_regions_vertical);
    quiver(x, y, final_grid_x, final_grid_y); axis image
    im = image1;
    hax = gca; % use initial plot to get the axis
    imshow(im, "XData", hax.XLim, "YData", hax.YLim);
    hold on; 
    quiver(x, y, final_grid_x, final_grid_y, "red");
end