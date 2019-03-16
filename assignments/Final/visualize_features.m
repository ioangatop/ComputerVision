function visualize_features(images, image_features, image_descriptors, descriptors2img, centers, threshold, res, sample, total_imgs)
%   VISUALIZE_FEATURES 
%   Visualize visual words (denses that are close by the threshold of the
%   clusters).

[~,n] = size(centers);
[~,m] = size(image_descriptors);

supercount = 1;
imageCounter = 1;
for i=1:n
    count = 1;
    for j=1:m
        if (centers(:, i) - image_descriptors(:, j)) < threshold
            f(i:i+1, count) = image_features(1:2, j);
            x = f(i, count);
            y = f(i+1, count);
            img_idx = descriptors2img(129, j);
            
            figure(1);
            img = reshape(images(img_idx, :, :, :), 96, 96, 3);
            imshow(img);
             
            imageCounter = imageCounter+1;

            fileName1 = sprintf("%d_raw_image.png", imageCounter);
            saveas(gca, fileName1);
            
            figure(2);
            img = imcrop(img, [x+res x-res y+res y-res]);
            imshow(img);
            
            imageCounter = imageCounter+1;
            
            fileName2 = sprintf("%d_visual_word_of_img.png", imageCounter);
            saveas(gca, fileName2);
   
            count = count+1;
            supercount = supercount +1;

        end
        if count == sample
            break
        end
    end
    if supercount == total_imgs
        break
    end

end