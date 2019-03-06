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
            if features_y(k) > h
                features_y(k) = h;
            elseif features_y(k) < 1
                features_y(k) = 1;
            end
            
            features_x(k) = features_x(k) + vec1(current_y, current_x);
            if features_x(k) > w
                features_x(k) = w;
            elseif features_x(k) < 1
                features_x(k) = 1;
            end
        end
        
        imshow(images(:,:,:,i+1)); hold on, plot(features_x, features_y, 'ys');
        f = getframe;
        image_array(:,:,:,i+1) = f.cdata;
    end
end