clc; clear;

load train.mat
run vlfeat-0.9.21/toolbox/vl_setup;

%% Dense SIFT descriptor extraction (vl dsift)

images = reshape(X, 5000, 96, 96, 3);
[image_descriptors, unused_image_indices] = parse_images(images, y, 5, 100);

%% 
type = 'RGB';
binSize = 8;
magnif = 3;

numClusters = 1000;
centers = vl_kmeans(image_descriptors, numClusters);

img3 = reshape(images(unused_image_indices(1), :, :, :), 96, 96, 3);
image_descriptors3 = get_densely_sampled_regions(img3, type, binSize, magnif);
pdf = calculate_pdf(image_descriptors3, centers);

histogram(pdf, numClusters);
