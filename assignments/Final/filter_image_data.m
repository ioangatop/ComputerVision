function [filtered_images, filtered_labels] = filter_image_data(images, labels, classes)
%FILTER_IMAGE_DATA Filters images and labels based on the classes used
    filtered_image_indices = [];
    for i = 1:size(images, 1)
        if any(classes == labels(i))
            filtered_image_indices = [filtered_image_indices, i];
        end
    end
    
    filtered_labels = labels(filtered_image_indices);
    filtered_images = images(filtered_image_indices, :, :, :);
end

