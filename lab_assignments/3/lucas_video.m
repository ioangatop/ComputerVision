function [image_array] = lucas_video (images, features_y, features_x)
    [h, w, c, nr_of_images] = size(images);
    number_of_regions = 15;
    scaling = 1;

    hold off;
    imshow(images(:,:,:,1)), hold on, plot(features_x, features_y, 'ys');
    f = getframe;
    currentImage = f.cdata;
    [hc, wc, cc] = size(currentImage);
    image_array = zeros(hc, wc, cc, nr_of_images);
    image_array(:, :, :, 1) = currentImage;
    
    for i=1:nr_of_images-1
        fprintf('At %d/%d\n', i, nr_of_images-1);
        [vec1, vec2] = lucas_kanade(images(:,:,:,i), images(:,:,:,i+1), false, number_of_regions);
        [h_regions, w_regions] = size(vec1);
        h_regions = h_regions - 1;
        w_regions = w_regions - 1;

        for k=1:length(features_x)
            current_x = round(features_x(k) / w_regions);
            if current_x < 1
                current_x = 1;
            elseif current_x > number_of_regions
                current_x = number_of_regions;
            end
            
            current_y = round(features_y(k) / h_regions);
            if current_y < 1
                current_y = 1;
            elseif current_y > number_of_regions
                current_y = number_of_regions;
            end
            
            features_y(k) = features_y(k) + (vec1(current_y, current_x) * scaling);
            features_x(k) = features_x(k) + (vec2(current_y, current_x) * scaling);
        end
        
        imshow(images(:,:,:,i+1)); hold on, plot(features_x, features_y, 'ys');
        hold on;

        f = getframe;
        image_array(:,:,:,i+1) = f.cdata;
    end
end