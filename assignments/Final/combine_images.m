function result_image = combine_images(images, columns)
%COMBINE_IMAGES Combines all images into one big image where for each row
% we have images with amount equal to COLUMNS 
    result_image = [];
    
    for i = 1:columns:size(images, 1)
        row_image = [];
        for j = 1:columns
            row_image = cat(2, row_image, reshape(images(i + j - 1, :, :, :), size(images, 2), size(images,3), size(images, 4)));
        end
        
        result_image = cat(1, result_image, row_image);
    end
end

