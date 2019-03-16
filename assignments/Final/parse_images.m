function [image_features, image_descriptors, used_image_indices, unused_image_indices, descriptors2img] = parse_images(image_set, classes_set, used_classes, class_size, type, binSize, magnif, step, feature_type, visualise_visual_words)
    

    img = reshape(image_set(1, :, :, :), 96, 96, 3);
    img2 = reshape(image_set(2, :, :, :), 96, 96, 3);

    class_count = zeros(1, class_size);
    
    if feature_type == "dense"
        [img_features1, img_descriptors1] = get_densely_sampled_regions(img, type, binSize, magnif, step);
        [img_features2, img_descriptors2] = get_densely_sampled_regions(img2, type, binSize, magnif, step);
    elseif feature_type == "keypoints"
        [img_features1, img_descriptors1] = get_keypoints(img, type);
        [img_features2, img_descriptors2] = get_keypoints(img2, type);
    end
    
    image_descriptors = cat(2, img_descriptors1, img_descriptors2);    
    image_features = cat(2, img_features1, img_features2);
    
    if visualise_visual_words == "True"
        [~, w1] = size(img_descriptors1);
        [~, w2] = size(img_descriptors2);
        idx_1 = single(ones(1, w1));
        idx_2 = single(2*ones(1, w2));

        descriptors2img_1 = single(cat(1, single(img_descriptors1), idx_1));
        descriptors2img_2 = single(cat(1, single(img_descriptors2), idx_2));
        descriptors2img = single(cat(2, descriptors2img_1, descriptors2img_2));
    else
        descriptors2img = "NaN";
    end

    unused_image_indices = [];
    used_image_indices = [];
    for i = 3:size(image_set, 1)
        current_class = classes_set(i);
        if ~any(used_classes == current_class)
            continue
        elseif class_count(current_class) < class_size
            current_image = reshape(image_set(i, :, :, :), 96, 96, 3);
            class_count(current_class) = class_count(current_class) + 1;
            
            [current_img_features, current_img_descriptors] = get_densely_sampled_regions(current_image, type, binSize, magnif, step);
            
            if feature_type == "dense"
                [current_img_features, current_img_descriptors] = get_densely_sampled_regions(current_image, type, binSize, magnif, step);
            elseif feature_type == "keypoints"
                [current_img_features, current_img_descriptors] = get_keypoints(current_image, type);
            end
            
            image_descriptors = cat(2, image_descriptors, current_img_descriptors);
            image_features = cat(2, image_features, current_img_features);
            used_image_indices = [used_image_indices, i];
            
            if visualise_visual_words == "True"
                [~, w] = size(current_img_descriptors);
                idx_i = single(i*ones(1, w));
                descriptors2img_i = single(cat(1, single(current_img_descriptors), idx_i));
                descriptors2img = single(cat(2, descriptors2img, descriptors2img_i));
            end
                
        else
            unused_image_indices = [unused_image_indices, i];
        end
    end
    
    image_descriptors = single(image_descriptors);
end

