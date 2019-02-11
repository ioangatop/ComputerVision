function visualize(input_image)  
    [h, w, colors] = size(input_image);
    
    % We check if the input_image is the stack of gray or not
    if colors == 3
        
        % this will plot the density of the colors from white (low) ->
        % black (high)
        redChannel   = input_image(:,:,1);
        greenChannel = input_image(:,:,2);
        blueChannel  = input_image(:,:,3);

        figure(1);
        subplot(2, 2, 1), imshow(input_image),  title('Raw Color Space');
        subplot(2, 2, 2), imshow(redChannel),   title('Red Channel');
        subplot(2, 2, 3), imshow(greenChannel), title('Green Channel');
        subplot(2, 2, 4), imshow(blueChannel),  title('Blue Channel');

        % -------------------------- or/and ------------------------------

        % this will plot the density of the colors by ploting the volume
        % of the actual color of the image
        black_fig = zeros(h, w);
        red   = cat(3, redChannel, black_fig, black_fig);
        green = cat(3, black_fig, greenChannel, black_fig);
        blue  = cat(3, black_fig, black_fig, blueChannel);

        figure(2);
        subplot(2, 2, 1), imshow(input_image),  title('Raw Color Space');
        subplot(2, 2, 2), imshow(red),          title('Red Channel');
        subplot(2, 2, 3), imshow(green),        title('Green Channel');
        subplot(2, 2, 4), imshow(blue),         title('Blue Channel');
    
    else
        
        light_gray      = input_image(:,:,1);
        average_gray    = input_image(:,:,2);
        luminosity_gray = input_image(:,:,3);
        standard_gray   = input_image(:,:,4);

        figure(3);
        subplot(2, 2, 1), imshow(light_gray),       title('Ligtness Method');
        subplot(2, 2, 2), imshow(average_gray),     title('Average Method');
        subplot(2, 2, 3), imshow(luminosity_gray),  title('Luminosity Method');
        subplot(2, 2, 4), imshow(standard_gray),    title('Built-in Function');
end

