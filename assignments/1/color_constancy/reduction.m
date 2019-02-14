function [] = reduction(img1, img2, color)
%REDUCTION Summary of this function goes here
%   Detailed explanation goes here
    % Get the color
    
    % Get the image shape
    [h, w, ~] = size(img1);
    
    if color == 'red'
        color_img1 = reshape(img1(:,:,1), [h*w, 1]);
        color_img2 = reshape(img2(:,:,1), [h*w, 1]);
    elseif color == 'green'
        color_img1 = reshape(img1(:,:,2), [h*w, 1]);
        color_img2 = reshape(img2(:,:,2), [h*w, 1]);
    elseif color == 'blue'
        color_img1 = reshape(img1(:,:,3), [h*w, 1]);
        color_img2 = reshape(img2(:,:,3), [h*w, 1]);
    else
        disp('No valid option, please give argument red, green or blue');
        return;
    end
    
    % stuck them side by side
    img = cat(2, img1, img2);
    
    % plot
    figure
    subplot(2,1,1), imshow(img), ...
        xlabel('left: original image, right: after color correction');
    
   avg = 100*(color_img2(:,:) - color_img1(:,:))./(color_img2(:,:) + color_img1(:,:));
    subplot(2,1,2), plot(avg), ...
        ylabel('(red_{right} - red_{left})%'), xlabel('Pixes width'),... 
        axis([0 w 0 max(avg)+0.5]) ,...
        title(sprintf('Change of %s pixels between the two images', color));
    
end

