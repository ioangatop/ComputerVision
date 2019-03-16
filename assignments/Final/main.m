clc; clear;

%% Dense SIFT descriptor extraction (vl dsift)

run vlfeat-0.9.21/toolbox/vl_setup;

%% Configuration parameters

height = 96;
width = 96;
channels = 3;
% classes_count = 5;
class_size = 500;
clusters_amount = 1000;

type = 'RGB';
binSize = 8;
magnif = 3;
step = 20;

% used classes are:
% 1 - airplane
% 2 - bird
% 3 - car
% 7 - horse
% 9 - ship
used_classes = [1, 2, 3, 7, 9];

exclude_unused_classes = true;

%% Load data used for training

load train.mat
images = reshape(X, size(X, 1), height, width, channels);

[image_descriptors, used_image_indices, unused_image_indices] = parse_images(images, y, used_classes, class_size, type, binSize, magnif, step);

%% Cluster images and build visual vocabulary and dictionary

cluster_centers = vl_kmeans(image_descriptors, clusters_amount);
pdfs = calculate_pdfs(images, cluster_centers, type, binSize, magnif, step); 

% visual_dictionary = create_visual_dictionary(centers, images(unused_image_indices, :, :, :));

%% Order all used images

used_image_indices_per_class = parse_used_image_indices(used_classes, class_size, y);

%% Load Liblinear library - used for SVM classification

run liblinear-2.21/matlab/make;

%% Train the SVM models

models = train_svm_models(used_image_indices_per_class, pdfs);

%% Load the data that we are going to use for testing

load test.mat

test_images = reshape(X, size(X, 1), height, width, channels);
test_labels = y;

%% Filter out images from other classes

if exclude_unused_classes
    [filtered_images, filtered_labels] = filter_image_data(test_images, test_labels, used_classes);
else
   filtered_images = test_images;
   filtered_labels = test_labels;
end

%% Make predictions for the test PDFs

prediction_matrices = predict_images(filtered_images, filtered_labels, models, cluster_centers, type, binSize, magnif, step);

%% Visualize the results

visualize_predicted_images(filtered_images, prediction_matrices, used_classes, class_names, 50, 10);

%% Calculate Mean Average Precision

calculate_mAP(filtered_images, prediction_matrices, filtered_labels, used_classes)