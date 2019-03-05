clear;
clc;

% I = imread('person_toy/00000001.jpg');
% J = imread('pingpong/0000.jpeg');
% I_45 = imrotate(I, 45);
% I_90 = imrotate(I, 90);
% 
% [H, r, c]= harris_corner_detector(J);

% I = imread('sphere1.ppm');
% J = imread('sphere2.ppm');
% lucas_kanade(I, J);

I = imread('synth1.pgm');
J = imread('synth2.pgm');
lucas_kanade(I, J);