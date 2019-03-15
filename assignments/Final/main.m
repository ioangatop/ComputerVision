clc; clear;

load train.mat
run vlfeat-0.9.21/toolbox/vl_setup;

%% Dense SIFT descriptor extraction (vl dsift)

images = reshape(X, 5000, 96, 96, 3);
[image_descriptors, unused_image_indices] = parse_images(images, y, 5, 100);

%% Cluster images and build visual vocabulary and dictionary
clusters_amount = 1000;
centers = vl_kmeans(image_descriptors, clusters_amount);
pdfs = calculate_pdfs(images([unused_image_indices(1) unused_image_indices(2)], :, :, :), centers); 

% visual_dictionary = create_visual_dictionary(centers, images(unused_image_indices, :, :, :));

% show_histogram(pdfs(1, :), clusters_amount);