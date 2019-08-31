function [new_image] = transform_image(image, M, t, should_normalize, crop_borders)    
    [h, w, ~] = size(image);
%     transformed_image = zeros(size(image));
    transformed_image = zeros(1, 1, size(image, 3));
    current_shift_x = 0;
    current_shift_y = 0;
    
    for y = 1:size(image, 1)
        for x = 1:size(image, 2)
            new_xy = floor(M * [x; y] + t);

            % we need to shift the image horizontally
            if new_xy(1) < 1 && abs(new_xy(1) - 1) > current_shift_x
                old_shift_x = current_shift_x;
                current_shift_x = abs(new_xy(1) - 1);
                new_shift_x = current_shift_x - old_shift_x;
                transformed_image = imtranslate(transformed_image, [new_shift_x, 0], 'FillValues', 0, 'OutputView','full');
            end

            % we need to shift the image vertically
            if new_xy(2) < 1 && abs(new_xy(2) - 1) > current_shift_y
                old_shift_y = current_shift_y;
                current_shift_y = abs(new_xy(2) - 1);
                new_shift_y = current_shift_y - old_shift_y;
                transformed_image = imtranslate(transformed_image, [0, new_shift_y], 'FillValues', 0, 'OutputView','full');
            end
            
            transformed_image(new_xy(2) + current_shift_y, new_xy(1) + current_shift_x, :) = image(y, x, :);
        end
    end
    
    if crop_borders
        cropped_image = crop_image_borders(transformed_image);
    else
        cropped_image = transformed_image;
    end
    
    if should_normalize
        new_image = normalize_image(cropped_image);
    else
        new_image = cropped_image;
    end
    
    new_image = uint8(new_image);
end

