function [flow] = lucas_kanade()
% Lucas Kanade Optical flow 

im1 = double(imread("sphere1.ppm"));
im2 = double(imread("sphere2.ppm"));
[gx1, gy1] = gradient(im1);
[gx2, gy2] = gradient(im2);

for i = 0:12
    for j = 0:12
        A_region1 = gx1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        A_region2 = gy1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        A = [reshape(A_region1, 225, 1), reshape(A_region2, 225, 1)];
        A_T = A.'

        b_region1 = im1(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';
        b_region2 = im2(i*15+1:(i+1)*15, j*15+1:(j+1)*15).';

        b = reshape(b_region1, 225, 1) - reshape(b_region2, 225, 1);

        v = inv(A_T * A) * A_T * b
        %quiver(v(1:1), v(2:2))
    end
end