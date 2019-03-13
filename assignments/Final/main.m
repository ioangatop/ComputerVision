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

img_descriptors1 = get_densely_sampled_regions(img, type, binSize, magnif);
img_descriptors2 = get_densely_sampled_regions(img2, type, binSize, magnif);

descriptors = cat(2, img_descriptors1, img_descriptors2);

%% Key-points SIFT descriptor extraction (vl sift)

numClusters = 10;
descriptors = single(descriptors);

centers = vl_kmeans(descriptors, numClusters);

img_descriptors3 = get_densely_sampled_regions(img3, type, binSize, magnif);
img_descriptors3 = single(img_descriptors3);


H = [];
for i=1:size(d3,2)
    dist = vl_alldist(d3(:,i), centers);
    [~, k] = min(dist);
    H = [H , k];
end

histogram(H, numClusters);
