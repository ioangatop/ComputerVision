clear; clc;

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup;

img = imread('peppers.png');

%% Get interest points
% keypoints
f = keypoints(img, 'True');

% dense
% keypoints