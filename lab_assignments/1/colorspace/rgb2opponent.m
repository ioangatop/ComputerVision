function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
output_image = zeros(size(input_image));

% Red
output_image(:, :, 1) = (input_image(:, :, 1) - input_image(:, :, 2))/2;

% Green
output_image(:, :, 2) = (input_image(:, :, 1) - input_image(:, :, 2) ...
                        - 2*input_image(:, :, 3))/ sqrt(6);

% Blue
output_image(:, :, 3) = (input_image(:, :, 1) + input_image(:, :, 2) ...
                        + input_image(:, :, 3))/ sqrt(3);
end

