clc; clear;

%% Dense SIFT descriptor extraction (vl dsift)

run vlfeat-0.9.21/toolbox/vl_setup;

%% Configuration parameters
% constants
height = 96;
width = 96;
channels = 3;
class_size = 100;
binSize = 8;
magnif = 3;
step = 20;
visualise_visual_words = "False";    % "True"   "False"
show_confusion_matrix = "False";
exclude_unused_classes = true;

% hyperparams
clusters_amount = [400, 1000, 4000];
types = ["RGB", "OPP", "GRAY"]; % "RGB"   "OPP"   "GRAY"
feature_type = ["dense","keypoints"];             % "dense"   "keypoints"

% used classes are:
% 1 - airplane
% 2 - bird
% 3 - car
% 7 - horse
% 9 - ship
used_classes = [1, 2, 3, 7, 9];

%% Load data used for training

load train.mat
images = reshape(X, size(X, 1), height, width, channels);

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

%% Load Liblinear library - used for SVM classification
run liblinear-2.21/matlab/make;

% init empty scores

scores = containers.Map;
for T=types
for K=clusters_amount
for F=feature_type
           
%% SIFT images, and get features
[image_features, image_descriptors, used_image_indices, unused_image_indices, descriptors2img] = parse_images(images, y, used_classes, class_size, T, binSize, magnif, step, F, visualise_visual_words);

%% Cluster images and build visual vocabulary and dictionary

cluster_centers = vl_kmeans(image_descriptors, K);
pdfs = calculate_pdfs(images, cluster_centers, T, binSize, magnif, step); 

%% Visualise Visual Words

if visualise_visual_words == "True"
    threshold = 30;             % minimun euclidian distance from the centers
    res = 5;                    % kxk window around the features
    sample_per_cluster = 2;     % visual words per cluster
    total_imgs = 200;            % = original + visual words. So if is equal to 10, it will output 20 imgs
    
    visualize_features(images, image_features, image_descriptors, descriptors2img, cluster_centers, threshold, res, sample_per_cluster, total_imgs);
end

%% Order all used images

used_image_indices_per_class = parse_used_image_indices(used_classes, class_size, y);

%% Train the SVM models

models = train_svm_models(used_image_indices_per_class, pdfs);

%% Make predictions for the test PDFs

prediction_matrices = predict_images(filtered_images, filtered_labels, models, cluster_centers, T, binSize, magnif, step);

%% Show confusion matrix
if show_confusion_matrix== "True"
[~, preds] = max(prediction_matrices,[],2);
labels_preds = used_classes(preds(:));
C = confusionmat(filtered_labels, labels_preds);
confusionchart(C);
end

%% Visualize the results
% last three params are for visualization
visualize_predicted_images(filtered_images, prediction_matrices, used_classes, class_names, 5, 2, K, F, T);

%% Calculate Mean Average Precision
mAP = calculate_mAP(filtered_images, prediction_matrices, filtered_labels, used_classes);

% save to dict
exp_name = sprintf('k_%d_f_%s_t_%s',K, F, T);
scores(exp_name) = mAP
save(exp_name, 'mAP');

end 
end
end

keys(scores)
values(scores)


