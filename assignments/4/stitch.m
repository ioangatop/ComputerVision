function [original, stitched] = stitch(right_img, left_img)
% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup

% Read the images
% keypoint_matching takes care of transforming image to grayscale
right_img_color = imread(right_img);
left_img_color = imread(left_img);

% return original with padding
left_pad = max(size(left_img_color,1)-size(right_img_color,1),0);
right_pad = max(size(right_img_color,1)-size(left_img_color,1),0);
original = [padarray(left_img_color,right_pad,'post') ...
            padarray(right_img_color,left_pad,'post')];

% get matchings
% INCLUDED IN RANSAC SCRIPT
% best transformation
% N = 50, P = 10, 
[m, t] = RANSAC(50, 10, right_img_color, left_img_color);




end



