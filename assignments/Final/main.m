clc; clear;

load train.mat
run vlfeat-0.9.21/toolbox/vl_setup;
run liblinear-2.21/matlab/make;

%% Dense SIFT descriptor extraction (vl dsift)

height = 96;
width = 96;
channels = 3;

images = reshape(X, 5000, height, width, channels);
classes_count = 5;
class_size = 500;
[image_descriptors, used_image_indices, unused_image_indices] = parse_images(images, y, classes_count, class_size);

%% Cluster images and build visual vocabulary and dictionary
clusters_amount = 1000;
centers = vl_kmeans(image_descriptors, clusters_amount);
pdfs = calculate_pdfs(images, centers); 

%%
used_images_per_class = zeros(classes_count, class_size);

% used_y = y(used_image_indices);
for i = 1:classes_count
    y_class = find(y == i);
    y_class = y_class(1:class_size);
    used_images_per_class(i, :) = y_class;
end

%%

positive_images_count = length(used_images_per_class(1, :));
negative_images_count = (classes_count - 1) * positive_images_count;
all_labels = double([ones(1, positive_images_count), zeros(1, negative_images_count)])';

models = [];

for i = 1:classes_count
   positive_image_pdfs = pdfs(used_images_per_class(i, :), :);
   
   negative_image_pdfs = [];
   for j = 1:classes_count
      if i == j
          continue
      end
      
      current_negative_image_pdfs = pdfs(used_images_per_class(j, :), :);
      negative_image_pdfs = [negative_image_pdfs; current_negative_image_pdfs];
   end
   
   all_image_pdfs = sparse([positive_image_pdfs; negative_image_pdfs]);
   
   model = train(all_labels, all_image_pdfs);
   models = [models, model];
%    
%    predict_image_pdfs = sparse(pdfs([11 31], :));
%    [predicted_label, accuracies, prediction_matrix] = predict([1;1], predict_image_pdfs, model); 
end

%%

load test.mat


%% 
test_images = reshape(X, 8000, height, width, channels);

test_pdfs = sparse(calculate_pdfs(test_images, centers)); 

test_labels = y;

prediction_matrices = [];

for i = 1:classes_count
    [~, ~, prediction_matrix] = predict(test_labels, test_pdfs, models(i));
    prediction_matrices = [prediction_matrices, prediction_matrix];
end

%%

[~, best_k_arg] = maxk(prediction_matrices(:, 1), 5);

for i = 1:5
    figure;
    img = reshape(test_images(best_k_arg(i), :, :, :), 96, 96, 3);
    imshow(img);
end

% visual_dictionary = create_visual_dictionary(centers, images(unused_image_indices, :, :, :));

% show_histogram(pdfs(1, :), clusters_amount);