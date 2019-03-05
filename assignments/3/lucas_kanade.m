function [flow] = lucas_kanade()
% Lucas Kanade Optical flow 

im1 = double(imread("sphere1.ppm"));
im2 = double(imread("sphere2.ppm"));
[gx1, gy1] = gradient(im1);
[gx2, gy2] = gradient(im2);

final_grid_x = [];
final_grid_y = [];
for i = 0:12
    one_row_x = [];
    one_row_y = [];
    for j = 0:12
        A_region1 = gx1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        A_region2 = gy1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        A = [reshape(A_region1, 225, 1), reshape(A_region2, 225, 1)];
        A_T = A.';

        b_region1 = im1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        b_region2 = im2(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';

        b = reshape(b_region1, 225, 1) - reshape(b_region2, 225, 1);
        
        v = mldivide(A_T * A, A_T * b);
        v(isnan(v)) = 0.1;
        one_row_x = [one_row_x, v(1:1)];
        one_row_y = [one_row_y, v(2:2)];
    end
    final_grid_x = [final_grid_x; one_row_x];
    final_grid_y = [final_grid_y; one_row_y];
end

[x,y] = meshgrid(0:1:11,0:1:12);
%figure
quiver(x, y, final_grid_x(:,2:13), final_grid_y(:,2:13)); axis image
im = imread('sphere1.ppm');
hax = gca; %get the axis handle
image(hax.XLim,hax.YLim,im); %plot the image within the axis limits
hold on; %enable plotting overwrite
quiver(x, y, final_grid_x(:,2:13), final_grid_y(:,2:13))
%quiver(x,y,px,py) %plot the quiver on top of the image (same axis limits)