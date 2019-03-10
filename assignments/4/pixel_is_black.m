function [result] = pixel_is_black(pixel_values)
%PIXEL_IS_BLACK Checks if pixel contains only zeros
    result = true;
    for i = 1:length(pixel_values)
        if pixel_values(i) ~= 0
            result = false;
        end
    end
end

