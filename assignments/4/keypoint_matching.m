function [matches, scores, f_I, f_J] = keypoint_matching(I, J)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Convert image in the appropriate format 
% Grayscale -- incase that they are not
[~, ~, c] = size(I);
if c ~= 1
    I = rgb2gray(I);
end

[~, ~, c] = size(J);
if c ~= 1
    J = rgb2gray(J);
end

% Single
I = single(I) ;
J = single(J) ;

% Find similar regions in two images
[f_I, d_I] = vl_sift(I) ;
[f_J, d_J] = vl_sift(J) ;

% vl_ubcmatch: a basic matching algorithm
[matches, scores] = vl_ubcmatch(d_I, d_J) ;

end

