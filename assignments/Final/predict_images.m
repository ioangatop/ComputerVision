function [prediction_matrices] = predict_images(images, labels, models, classes_count, cluster_centers, type, binSize, magnif, step)
%PREDICT_IMAGES Predicts images and returns their matrices
    pdfs = sparse(calculate_pdfs(images, cluster_centers, type, binSize, magnif, step)); 

    prediction_matrices = [];

    for i = 1:classes_count
        [~, ~, prediction_matrix] = predict(labels, pdfs, models(i));
        prediction_matrices = [prediction_matrices, prediction_matrix];
    end
end

