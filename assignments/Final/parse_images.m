function [image_descriptors, unused_image_indices] = parse_images(image_set, classes_set, classes_count, class_size)
    type = 'RGB';
    binSize = 8;
    magnif = 3;
    Step = 20;

    img = reshape(image_set(1, :, :, :), 96, 96, 3);
    img2 = reshape(image_set(2, :, :, :), 96, 96, 3);

    class_count = zeros(1, class_size);
    img_descriptors1 = get_densely_sampled_regions(img, type, binSize, magnif, Step);
    img_descriptors2 = get_densely_sampled_regions(img2, type, binSize, magnif, Step);
    image_descriptors = cat(2, img_descriptors1, img_descriptors2);

    unused_image_indices = [];
    for i = 3:size(image_set, 1)
        current_class = classes_set(i);
        if current_class > classes_count
            continue
        elseif class_count(current_class) < 10
            current_image = reshape(image_set(i, :, :, :), 96, 96, 3);
            class_count(current_class) = class_count(current_class) + 1;
            current_img_descriptors = get_densely_sampled_regions(current_image, type, binSize, magnif, Step);
            image_descriptors = cat(2, image_descriptors, current_img_descriptors);
        else
            unused_image_indices = [unused_image_indices, i];
        end
    end
    
    image_descriptors = single(image_descriptors);
end

