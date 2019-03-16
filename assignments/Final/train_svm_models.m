function models = train_svm_models(image_indices_per_class, pdfs)
%TRAIN_SVM_MODELS Creates and trains binary classifying SVM models
    classes_count = size(image_indices_per_class, 1);

    positive_images_count = size(image_indices_per_class, 2);
    negative_images_count = (size(image_indices_per_class, 1) - 1) * positive_images_count;
    all_labels = double([ones(1, positive_images_count), zeros(1, negative_images_count)])';

    models = [];

    for i = 1:classes_count
        positive_image_pdfs = pdfs(image_indices_per_class(i, :), :);

        negative_image_pdfs = [];
        for j = 1:classes_count
            % We want to skip the current 'positive' class -
            % here we take only the other 'negative' classes
            if i == j
                continue
            end

            current_negative_image_pdfs = pdfs(image_indices_per_class(j, :), :);
            negative_image_pdfs = [negative_image_pdfs; current_negative_image_pdfs];
        end

        all_image_pdfs = sparse([positive_image_pdfs; negative_image_pdfs]);

        model = train(all_labels, all_image_pdfs);
        models = [models, model];
    end
end

