clear; clc;

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup;

img = imread('peppers.png');

%% Get interest points
% keypoints
type = 'RGB';
[f, d] = get_dense(img, type);

d = get_sift(img, type);

% dense
% [frames, descrs] = dense_features(img, 'RGB', 'True');

% f = get_sift(img, type, visualize)