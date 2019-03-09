function [new_image] = transform_image(image, M, t)    
    [h, w, ~] = size(image);
    new_image = zeros(size(image));
    for y = 1:size(image, 1)
        for x = 1:size(image, 2)
            new_xy = round(M * [x; y] + t);
            if new_xy(1) > w || new_xy(1) < 1 || new_xy(2) > h || new_xy(2) < 1
                continue
            end
            
            new_image(new_xy(2), new_xy(1), :) = image(y, x, :);
        end
    end
    
    new_image = uint8(new_image);
end

