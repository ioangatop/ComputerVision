clear; clc;

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup;

img = imread('peppers.png');

%% Dense SIFT (e.g. vl dsift) descriptor extraction 
type = 'RGB';
binSize = 8;
magnif = 3;

img_descriptors = get_densely_sampled_regions(img, type, binSize, magnif);

%% Key points SIFT descriptor extraction (e.g. vl sift)
% type = 'RGB';
% img_descriptors = get_dense(img, type);