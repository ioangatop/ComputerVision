clear;
clc;

I = imread('person_toy/00000001.jpg');
J = imread('pingpong/0000.jpeg');
I_45 = imrotate(I, 45);
I_90 = imrotate(I, 90);

[H, r, c]= harris_corner_detector(J);
% [H, r, c]= harris_corner_detector(I_90);