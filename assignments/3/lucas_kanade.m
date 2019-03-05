function [flow] = lucas_kanade(image1, image2)
% Lucas Kanade Optical flow 

% Read the two images and compute gradients for entire image
% im1 = double(imread("synth1.pgm"));
% im2 = double(imread("synth2.pgm"));
im1 = double(image1);
im2 = double(image2);

im1 = cat(3, im1

[height, width, c] = size(im1);

region_size = 15;
nr_of_regions = floor(height/region_size)-1;

[gx1, gy1] = gradient(im1);
[gx2, gy2] = gradient(im2);

final_grid_x = [];
final_grid_y = [];

% Loop over regions in x direction
for i = 0:nr_of_regions
    one_row_x = [];
    one_row_y = [];
    % Loop over regions in y direction
    for j = 0:nr_of_regions
        
        % Cut image in 15x15 regions of gradients iteratively
        A_region1 = gx1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        A_region2 = gy1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        
        % Reshape each region into a 225x2 vector (by stacking each row on
        % top of each other)
        A = [reshape(A_region1, 225, 1), reshape(A_region2, 225, 1)];
        A_T = A.';
        
        % Cut regular image in 15x15 regions 
        b_region1 = im1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        b_region2 = im2(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        
        % Reshape each region into a 225x1 vector (by stacking each row on top
        % of each other)
        b = reshape(b_region1, 225, 1) - reshape(b_region2, 225, 1);
        
        % Calculate the local image flow vector (v)
        v = mldivide(A_T * A, A_T * b);
        v(isnan(v)) = 0.1;
        one_row_x = [one_row_x, v(1:1)];
        one_row_y = [one_row_y, v(2:2)];
    end
    final_grid_x = [final_grid_x; one_row_x];
    final_grid_y = [final_grid_y; one_row_y];
end

% Plot on top of original image using quiver

[x,y] = meshgrid(0:1:nr_of_regions,0:1:nr_of_regions);
quiver(x, y, final_grid_x, final_grid_y); axis image
im = image1;
hax = gca; % use initial plot to get the axis
image(hax.XLim,hax.YLim,im);
hold on; 
quiver(x, y, final_grid_x, final_grid_y, "red")