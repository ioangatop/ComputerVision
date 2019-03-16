function [image_descriptors, used_image_indices, unused_image_indices] = parse_images(image_set, classes_set, used_classes, class_size, type, binSize, magnif, step)
    

    img = reshape(image_set(1, :, :, :), 96, 96, 3);
    img2 = reshape(image_set(2, :, :, :), 96, 96, 3);

    class_count = zeros(1, class_size);
    img_descriptors1 = get_densely_sampled_regions(img, type, binSize, magnif, step);
    img_descriptors2 = get_densely_sampled_regions(img2, type, binSize, magnif, step);
    image_descriptors = cat(2, img_descriptors1, img_descriptors2);

    unused_image_indices = [];
    used_image_indices = [];
    for i = 3:size(image_set, 1)
        current_class = classes_set(i);
        if ~any(used_classes == current_class)
            continue
            
        elseif class_count(current_class) < class_size
            current_image = reshape(image_set(i, :, :, :), 96, 96, 3);
            class_count(current_class) = class_count(current_class) + 1;
            current_img_descriptors = get_densely_sampled_regions(current_image, type, binSize, magnif, step);
            image_descriptors = cat(2, image_descriptors, current_img_descriptors);
            used_image_indices = [used_image_indices, i];
        else
            unused_image_indices = [unused_image_indices, i];
        end
    end
    
    image_descriptors = single(image_descriptors);
end

