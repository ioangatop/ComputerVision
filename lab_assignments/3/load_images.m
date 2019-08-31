function [image_array] = load_images(path, extension)
    imageNames = dir(fullfile(path, extension));
    imageNames = {imageNames.name}';
    image_array = 0;

    for ii = 1:length(imageNames)
        img = imread(fullfile(path, imageNames{ii}));
        
        if image_array == 0
            [h, w, c] = size(img);
            fprintf('Image size (HxW): %dx%d\n', h, w);
            image_array = zeros(h, w, c, length(imageNames), 'uint8');
            V = zeros(length(imageNames), 3, 'double');
        end

        image_array(:, :, :, ii) = img;
%         image_array(ii) = img;
    end
end

