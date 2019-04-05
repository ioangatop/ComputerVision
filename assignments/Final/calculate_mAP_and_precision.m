function [mAP_matrix, accuracy_matrix] = calculate_mAP(images, prediction_matrices, labels, used_classes)

    mAP_matrix = [];
    
    % Calculate mean average precision
    % Loop over the number of classes in test set
    for i = 1:size(prediction_matrices, 2) 
        % Find indices of test images with high prediction certainty
        [~, sorted_prediction_matrix] = maxk(prediction_matrices(:, i), length(prediction_matrices(:, i)));
        
        currentclass = used_classes(i);
        mAP_sum = 0;
        positive_count = 1;
        % Loop over all test images and iteratively build the sum for the
        % mean average precision formula
        for j = 1:length(sorted_prediction_matrix(1:4000, 1))
            if labels(sorted_prediction_matrix(j, 1)) == currentclass
               %mAP
               mAP_sum = mAP_sum + (positive_count/j);
               positive_count = positive_count + 1;

            end 
        end
        mAP = mAP_sum / 800; % Number of images per class
        % Summarize values in one matrix with row i corresponding to
        % used_classes(i)
        mAP_matrix = [mAP_matrix; mAP];
    end
    
    % Calculate accuracy
    % Note that this metric only works and makes sense when 'exclude_unused_classes =
    % true'.
    
    accuracy = 0;
    [~, index_of_highest_certainty] = maxk(prediction_matrices(:,:)', 1);
    for k = 1:size(prediction_matrices, 1)
        if used_classes(index_of_highest_certainty(k)) == labels(k)
            accuracy = accuracy + 1;
        end
    end
    accuracy = accuracy / size(prediction_matrices, 1);