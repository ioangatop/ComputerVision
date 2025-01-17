function visualize(input_image)  
    [~, ~, colors] = size(input_image);
    
    % We check if the input_image is the stack of gray or not
    if colors == 3
        
        % this will plot the density of the colors from white (low) ->
        % black (high)
        firstChannel   = input_image(:,:,1);
        secondChannel = input_image(:,:,2);
        thirdChannel  = input_image(:,:,3);

        figure;
        subplot(2, 2, 1), imshow(input_image),  title('Origina Image');
        subplot(2, 2, 2), imshow(firstChannel),   title('First Color Channel');
        subplot(2, 2, 3), imshow(secondChannel), title('Second Color Channel');
        subplot(2, 2, 4), imshow(thirdChannel),  title('Thrird Color Channel');
    
    else
        
        light_gray      = input_image(:,:,1);
        average_gray    = input_image(:,:,2);
        luminosity_gray = input_image(:,:,3);
        standard_gray   = input_image(:,:,4);

        figure;
        subplot(2, 2, 1), imshow(light_gray),       title('Ligtness Method');
        subplot(2, 2, 2), imshow(average_gray),     title('Average Method');
        subplot(2, 2, 3), imshow(luminosity_gray),  title('Luminosity Method');
        subplot(2, 2, 4), imshow(standard_gray),    title('Built-in Function');
end

