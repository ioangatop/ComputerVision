function [image_array] = load_images(path, extension)
    imageNames = dir(fullfile(path, extension));
    imageNames = {imageNames.name}';
    image_array = zeros(length(imageNames));

    for ii = 1:length(imageNames)
       img = imread(fullfile(workingDir, imageNames{ii}));
       image_array(ii) = img;
    end
end

