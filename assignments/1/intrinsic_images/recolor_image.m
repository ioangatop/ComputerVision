function [newImageMatrix] = recolor_image(imageMatrix, oldColor, newColor)
%GET_MATERIAL_COLOR Recolors the image by replacing oldColor with newColor
    [h, w, ~] = size(imageMatrix);
    newImageMatrix = imageMatrix;
    
    for x = 1:h
        for y = 1:w
            if imageMatrix(x, y, :) == oldColor
                newImageMatrix(x, y, :) = newColor;
            end
        end
    end
end

