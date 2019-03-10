clear; clc;

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup

% Read the images
image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');

%% Get the matching points
% [matches, scores, f_I, f_J, d_I, d_J] = keypoint_matching(image1, image2);

% Plot a random subset (size = sample) of all matching points
% sample = 50;
% plot_keypoints_subset(I, J, matches, scores, f_I, f_J, d_I, d_J, sample);

%% RANSAC
N = 10; P = 10;
RANSAC(N, P, image1, image2, false, true);

RANSAC(N, P, image2, image1, false, true);