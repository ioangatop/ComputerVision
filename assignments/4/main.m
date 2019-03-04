clear; clc;

% Read the images
I = imread('boat1.pgm');
J = imread('boat2.pgm');

% Get the matching points
[matches, scores, f_I, f_J] = keypoint_matching(I, J);

% Plot a random subset (size 10) of all matching points
plot_keypoints_subset(I, J, matches, scores, f_I, f_J, 10);