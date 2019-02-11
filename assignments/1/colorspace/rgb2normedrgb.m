function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
output_image = zeros(size(input_image));

% Red
output_image(:, :, 1) = input_image(:, :, 1) ./ (input_image(:, :, 1) ...
    + input_image(:, :, 2) + input_image(:, :, 3));

% Green
output_image(:, :, 2) = input_image(:, :, 2) ./ (input_image(:, :, 1) ...
    + input_image(:, :, 2) + input_image(:, :, 3));

% Blue
output_image(:, :, 3) = input_image(:, :, 3) ./ (input_image(:, :, 1) ...
    + input_image(:, :, 2) + input_image(:, :, 3));
end

