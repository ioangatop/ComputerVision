function [] = color_dens(img, color)
    %RED_DENS Summary of this function goes here
    %   Detailed explanation goes here
    
    % Get the color
    if color == 'red'
        color_img = img(:,:,1);
        color = 'r';
    elseif color == 'green'
        color_img = img(:,:,2);
        color = 'g'
    elseif color == 'blue'
        color_img = img(:,:,3);
        color = 'b'
    else
        disp('No valid option, please give argument red, green or blue');
        return;
    end
   
    % Get the img shape
    [h, w, c] = size(img)
    
    % plot
    figure
    subplot(2,1,1), imshow(img), line([1,w], [h/2, h/2], 'color', color);
    subplot(2,1,2), plot(color_img(:,h/2));
end

