% clear; clc;

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup;

%% Dense SIFT descriptor extraction (vl dsift)

images = reshape(X, 5000, 96, 96, 3);
img = reshape(images(1, :, :, :), 96, 96, 3);
img2 = reshape(images(2, :, :, :), 96, 96, 3);
img3 = reshape(images(3, :, :, :), 96, 96, 3);

type = 'RGB';
binSize = 8;
magnif = 3;

% 100 images per class
class_count = [0,0,0,0,0];
img_descriptors1 = get_densely_sampled_regions(img, type, binSize, magnif);
img_descriptors2 = get_densely_sampled_regions(img2, type, binSize, magnif);
descriptors = cat(2, img_descriptors1, img_descriptors2);

unused_images = [];
for i = 3:size(X, 1)
    current_image = reshape(images(i, :, :, :), 96, 96, 3);
    current_class = y(i);
    if class_count(current_class) < 100
        class_count(current_class) = class_count(current_class) + 1;
        current_img_descriptors = get_densely_sampled_regions(current_image, type, binSize, magnif);
        descriptors = cat(2, descriptors, current_img_descriptors);
    else
        unused_images = [unused_images, current_image];
    end
end


%% Key-points SIFT descriptor extraction (vl sift)

numClusters = 1000;
descriptors = single(descriptors);

centers = vl_kmeans(descriptors, numClusters);

image_descriptors3 = get_densely_sampled_regions(unused_images(1), type, binSize, magnif);
probability_distribution = calculate_probability_distribution(image_descriptors3, centers, type, binSize, magnif);

histogram(probability_distribution, numClusters);
