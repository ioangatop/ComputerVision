function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

%% ligtness method
% The lightness method averages the most prominent and least prominent 
% colors: (max(R, G, B) + min(R, G, B)) / 2.

light_gray = ...
  max( max(input_image(:, :, 1), input_image(:, :, 2)), input_image(:, :, 3))/2;

%% average method
% The average method simply averages the values: (R + G + B) / 3.

average_gray = ...
   (input_image(:, :, 1) + input_image(:, :, 2) + input_image(:, :, 3))/3;
 
%% luminosity method
% The luminosity method is a more sophisticated version of the average 
% method. It also averages the values, but it forms a weighted average to 
% account for human perception. We¢re more sensitive to green than other 
% colors, so green is weighted most heavily. The formula for luminosity is 
% 0.21 R + 0.72 G + 0.07 B.

luminosity_gray = 0.21*input_image(:, :, 1) + 0.72*input_image(:, :, 2) ...
    + 0.07*input_image(:, :, 3);

%% built-in MATLAB function 
standard_gray = rgb2gray(input_image);

%% output
output_image = cat(3, light_gray, average_gray, luminosity_gray, standard_gray);
end

