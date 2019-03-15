clc; clear;

load train.mat
run vlfeat-0.9.21/toolbox/vl_setup;

%% Dense SIFT descriptor extraction (vl dsift)

height = 96;
width = 96;
channels = 3;

images = reshape(X, 5000, height, width, channels);
classes_count = 5;
class_size = 20;
[image_descriptors, used_image_indices, unused_image_indices] = parse_images(images, y, classes_count, class_size);

%% Cluster images and build visual vocabulary and dictionary
clusters_amount = 1000;
centers = vl_kmeans(image_descriptors, clusters_amount);
pdfs = calculate_pdfs(images([unused_image_indices(1) unused_image_indices(2)], :, :, :), centers); 

used_images_per_class = zeros(classes_count, class_size);

used_y = y(used_image_indices);
for i = 1:classes_count
    y_class = find(used_y == i);
    used_images_per_class(i, :) = y_class;
end

%%




% visual_dictionary = create_visual_dictionary(centers, images(unused_image_indices, :, :, :));

% show_histogram(pdfs(1, :), clusters_amount);