function [] = reduction(img1, img2, color)
%REDUCTION Summary of this function goes here
%   Detailed explanation goes here
    % Get the color
    if color == 'red'
        color_img1 = img1(:,:,1);
        color_img2 = img2(:,:,1);
        color = 'r';
    elseif color == 'green'
        color_img1 = img1(:,:,2);
        color_img2 = img2(:,:,2);
        color = 'g'
    elseif color == 'blue'
        color_img1 = img1(:,:,3);
        color_img2 = img2(:,:,3);
        color = 'b'
    else
        disp('No valid option, please give argument red, green or blue');
        return;
    end
   
    % Get the img shape
    [h, w, c] = size(img1);
    
    % stuck them side by side
    img = cat(2, img1, img2);
    
    % plot
    figure
    subplot(2,1,1), imshow(img), line([1,2*w], [h/2, h/2], 'color', color), ...
        xlabel('left: original image, right: after color correction');
    
   avg = 100*(color_img2(:,h/2) - color_img1(:,h/2))./(color_img2(:,h/2) + color_img1(:,h/2));
    subplot(2,1,2), plot(avg), ...
        ylabel('(red_{right} - red_{left})%'), xlabel('Pixes width'),... 
        axis([0 w 0 max(avg)+0.5]) ,...
        title('Change of red color on the red line between the two images');
    
end

