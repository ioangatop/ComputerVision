function visualize_predicted_images(images, prediction_matrices, labels, visualize_count, columns)
%VISUALIZE_PREDICTED_IMAGES Visualizes the predicted images 
% based on their matrices
    
    for i = 1:size(prediction_matrices, 2)
        [~, sorted_prediction_matrix] = maxk(prediction_matrices(:, i), length(prediction_matrices(:, i)));
        sorted_images = images(sorted_prediction_matrix(1:visualize_count), :, :, :);
        combined_image = combine_images(sorted_images, columns);
        
        figure;
        imshow(combined_image);
        title(labels(i));
    end
end

