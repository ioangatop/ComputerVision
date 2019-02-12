function [avr_color] = avg_color_dens(img,color)
%AVG_COLOR_DENS Summary of this function goes here
%   Detailed explanation goes here
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
    
    avr_color = mean(color_img, 'all');
end

