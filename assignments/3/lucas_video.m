function [image_array] = lucas_video (images, features_y, features_x)
    %LUCAS_VIDEO Summary of this function goes here
    %   Detailed explanation goes here

    [h, w, c, nr_of_images] = size(images);
    number_of_regions = 15;
    h_regions = round(h / number_of_regions);
    w_regions = round(w / number_of_regions);

    hold off;
    imshow(images(:,:,:,1)), hold on, plot(features_x, features_y, 'ys');
    f = getframe;
    currentImage = f.cdata;
    [hc, wc, cc] = size(currentImage);
    image_array = zeros(hc, wc, cc, nr_of_images, 'uint8');
    image_array(:, :, :, 1) = currentImage;
    
    for i=1:nr_of_images-1
        fprintf('At %d/%d\n', i, nr_of_images-1);
        [vec1, vec2] = lucas_kanade(images(:,:,:,i), images(:,:,:,i+1), false, number_of_regions);

        for k=1:length(features_x)
            current_x = round(features_x(k) / w_regions) + 1;
            current_y = round(features_y(k) / h_regions) + 1;
            
            features_y(k) = features_y(k) + vec2(current_y, current_x);
            features_x(k) = features_x(k) + vec1(current_y, current_x);
        end
        
        valid_features_x = features_x(features_x >= 1 & features_x <= w);
        valid_features_y = features_y(features_y >= 1 & features_y <= h);
        imshow(images(:,:,:,i+1)); hold on, plot(valid_features_x, valid_features_y, 'ys');
        f = getframe;
        image_array(:,:,:,i+1) = f.cdata;
    end
end