function [materialColor] = get_material_color(imageMatrix)
%GET_MATERIAL_COLOR Gets the true material color of an image
    [h, w, ~] = size(imageMatrix);

    for x = 1:h
        for y = 1:w
            if imageMatrix(x, y, 1) ~= 0 | imageMatrix(x, y, 2) ~= 0 | imageMatrix(x, y, 3) ~= 0
                materialColor = imageMatrix(x, y, :);
                return;
            end
        end
    end
end

