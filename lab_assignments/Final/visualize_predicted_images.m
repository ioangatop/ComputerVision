function visualize_predicted_images(images, prediction_matrices, used_classes, labels, visualize_count, columns, clusters_amount, feature_type, type)
%VISUALIZE_PREDICTED_IMAGES Visualizes the predicted images 
% based on their matrices
    figure;
    
    combined_image = double([]);
    for i = 1:size(prediction_matrices, 2)
        
        [~, sorted_prediction_matrix] = maxk(prediction_matrices(:, i), length(prediction_matrices(:, i)));
        sorted_images = images(sorted_prediction_matrix(1:visualize_count), :, :, :);
        worst_images = images(sorted_prediction_matrix(end-visualize_count+1:end), :, :, :);
                   
        % best top, worst bottom
        combined_image = [combined_image, [sorted_images; worst_images]];
    end
    
    combined_final = combine_images(combined_image, 10);
    
    file_name = sprintf('images/k_%d_f_%s_t_%s.jpg',clusters_amount, feature_type, type);
    imwrite(combined_final, file_name, 'jpg');
    imshow(combined_final)
end

