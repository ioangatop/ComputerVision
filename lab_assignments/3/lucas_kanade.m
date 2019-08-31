function [final_grid_x, final_grid_y] = lucas_kanade(im1, im2, visualization, reg_size)
% Lucas Kanade Optical flow 

% Read the two images and compute gradients for entire image
[~, ~, ch] = size(im1);
if ch == 3
    im1 = rgb2gray(im1);
    im2 = rgb2gray(im2);
end
im1 = im2double(im1);
im2 = im2double(im2);
[height, width, ~] = size(im1);

% Include option for other region sizes, default should be 15
region_size = reg_size;

% Calculate number of regions in both directions 
% to account for non-square matrices
nr_of_regions_horizontal = floor(width/region_size)-1;
nr_of_regions_vertical = floor(height/region_size)-1;

final_grid_x = [];
final_grid_y = [];

% Loop over regions in y direction
for i = 0:nr_of_regions_vertical
    one_row_x = [];
    one_row_y = [];
    
    % Loop over regions in x direction
    for j = 0:nr_of_regions_horizontal
        
        % Cut image in 15x15 regions of gradients iteratively
        A_region1 = gx(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        A_region2 = gy(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        
        % Reshape each region into a 225x2 vector (by stacking each row on
        % top of each other)
        A = [reshape(A_region1, region_size^2, 1), reshape(A_region2, region_size^2, 1)];
        %A_T = A.';
        
        % Cut regular image in 15x15 regions 
        b_region1 = im1(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        b_region2 = im2(i*region_size+1:(i+1)*region_size, j*region_size+1:(j+1)*region_size).';
        
        % Reshape each region into a 225x1 vector (by stacking each row on top
        % of each other)
        b = reshape(b_region1, region_size^2, 1) - reshape(b_region2, region_size^2, 1);
        
        % Calculate the local image flow vector (v)
        v = pinv(A) * b;
        
        % Save each row in temp vectors
        one_row_x = [one_row_x, v(1:1)];
        one_row_y = [one_row_y, v(2:2)];
    end
    % Return one matrix for each coordinate of the final flow vectors
    final_grid_x = [final_grid_x; one_row_x];
    final_grid_y = [final_grid_y; one_row_y];
end

% Plot on top of original image using quiver
if visualization
    [x,y] = meshgrid(0:1:nr_of_regions_horizontal,0:1:nr_of_regions_vertical);
    quiver(x, y, final_grid_x, final_grid_y); axis image
    im = image1;
    [rows, cols, channels] = size(im);
    hax = gca; % specify axis based on initial plot
    imshow(im, "XData", hax.XLim, "YData", hax.YLim); % plot image on boundaries
    hold on; 
    quiver(x, y, final_grid_x, final_grid_y, "red");
    % Plot the grid on top: white dotted lines
    for row = 0 : 1 : rows
      line([0, cols], [row, row], 'Color', 'w', 'LineStyle', ":");
    end
    for col = 1 : 1 : cols
      line([col, col], [0, rows], 'Color', 'w', 'LineStyle', ":");
    end
end