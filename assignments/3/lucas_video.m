function [image_array] = lucas_video (images, features_x, features_y)
%LUCAS_VIDEO Summary of this function goes here
%   Detailed explanation goes here

[h, w, c, nr_of_images] = size(images);

image_array = zeros(h, w, c, nr_of_images, 'uint8');
figure; 
for i=1:nr_of_images-1
    [vec1, vec2] = lucas_kanade(images(:,:,:,i), images(:,:,:,i+1), false, 1);
    for k=1:length(features_x)
        temp = features_x(k);
        features_x(k) = features_x(k) + round(vec1(features_x(k), features_y(k)));
        features_y(k) = features_y(k) + round(vec2(temp, features_y(k)));
    end
    hold off;
    imshow(images(:,:,:,i+1)), hold on, plot(features_y, features_x, 'ys');
    % image_array(:, :, :, ii) = img;
    end
end