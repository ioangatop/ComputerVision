function visual_dictionary = create_visual_dictionary(centers, images)
    type = 'RGB';
    binSize = 8;
    magnif = 3;
    
    visual_dictionary = [];

    for i = 1:size(centers, 2)
       visual_dictionary{i} = [];
    end
    
    for i = 1:size(images, 1)
        image = reshape(images(i, :, :, :), 96, 96, 3);
        image_descriptors = single(get_densely_sampled_regions(image, type, binSize, magnif));
        for j=1:size(image_descriptors, 2)
            dist = vl_alldist(image_descriptors(:, j), centers);
            [~, k] = min(dist);
            visual_dictionary{k} = [visual_dictionary{k}, image_descriptors(:, j)];
        end
    end
end

