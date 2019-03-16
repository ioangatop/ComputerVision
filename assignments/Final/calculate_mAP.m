function [mAP_matrix] = calculate_mAP(images, prediction_matrices, labels, used_classes)
    %CALCULATE_MAP Summary of this function goes here
    %   Detailed explanation goes here
    mAP_matrix = [];
    % Loop over the number of classes in test set
    for i = 1:size(prediction_matrices, 2) 
        % Find indices of test images with high prediction certainty
        [~, sorted_prediction_matrix] = maxk(prediction_matrices(:, i), length(prediction_matrices(:, i)));
        
        currentclass = used_classes(i);
        mAP_sum = 0;
        positive_count = 1;
        
        % Loop over all test images and iteratively build the sum for the
        % mean average precision formula
        for j = 1:length(sorted_prediction_matrix(:, 1))
            if labels(sorted_prediction_matrix(j, 1)) == currentclass
               mAP_sum = mAP_sum + (positive_count/j);
               positive_count = positive_count + 1;
            end
        end
        mAP = mAP_sum / 800;
        % Summarize values in one matrix with row i corresponding to
        % used_classes(i)
        mAP_matrix = [mAP_matrix; mAP];
    end
end