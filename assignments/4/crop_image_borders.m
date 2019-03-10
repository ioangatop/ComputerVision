function [cropped_image] = crop_image_borders(image)
%CROP_IMAGE_BORDERS Crops all black borders of image
    cropped_image_x = zeros(size(image, 1), 1, size(image, 3));
    for x = 1:size(image, 2)
        if max(image(:, x)) > 0
            cropped_image_x = cat(2, cropped_image_x, image(:, x, :));
        end
    end

    cropped_image = zeros(1, size(cropped_image_x, 2), size(cropped_image_x, 3));
    for y = 1:size(cropped_image_x, 1)
        if max(cropped_image_x(y, :)) > 0
            cropped_image = cat(1, cropped_image, cropped_image_x(y, :, :));
        end
    end
end

