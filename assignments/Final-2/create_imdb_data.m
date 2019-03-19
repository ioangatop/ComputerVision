function [data, labels, sets] = create_imdb_data()
%CREATE_IMDB_DATA Creates the required imdb data
%   data - 4D matrix (image height, image width, num channels, num images)
%   labels - indicates the class to which each image belongs to
%   sets - indicates whether the image is from the training or test set
    height = 96
    width = 96
    channels = 3;

    load train.mat
    train_images = reshape(X, size(X, 1), height, width, channels);
    train_labels = y;

    load test.mat
    test_images = reshape(X, size(X, 1), height, width, channels);
    test_labels = y;
    
    classes = [1 2 9 7 3];
    
    num_images = sum(ismember(train_labels, classes)) + sum(ismember(test_labels, classes));
    data = zeros(32, 32, 3, num_images);
    labels = zeros(1, num_images);
    sets = zeros(1, num_images);
    
    counter = 1;
    for i = 1:size(train_images, 1)
        if any(classes == train_labels(i))
            resized_image = resize_image(train_images(:, :, :, i));
            data(:, :, :, counter) = resized_image;
            labels(:, counter) = convert_label(train_labels(i));
            sets(:, counter) = 1;
            counter = counter + 1;
        end        
    end
    
    for i = 1:size(test_images, 1)
        if any(classes == test_labels(i))
            resized_image = resize_image(test_images(:, :, :, i));
            data(:, :, :, counter) = resized_image;
            labels(:, counter) = convert_label(test_labels(i));
            sets(:, counter) = 2;
            counter = counter + 1;
        end        
    end
end

