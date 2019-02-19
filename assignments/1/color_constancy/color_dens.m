function [] = color_dens(img, color)    
    % Get the color
    [h, w, ~] = size(img);
    if color == 'red'
        color_img = reshape(img(:,:,1), [h*w, 1]);
    elseif color == 'green'
        color_img = reshape(img(:,:,2), [h*w, 1]);
    elseif color == 'blue'
        color_img = reshape(img(:,:,3), [h*w, 1]);
    else
        disp('No valid option, please give argument red, green or blue');
        return;
    end
   
    % Get the img shape
    [h, w, c] = size(img);
    
    % plot
    figure(1)
    subplot(2,1,1), imshow(img);
    subplot(2,1,2), plot(color_img(:,:));
end

