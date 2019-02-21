function imOut = compute_LoG(image, LOG_type)

% matrix form
image = im2double(image);

switch LOG_type
    case 1
        % from help: fspecial('gaussian',HSIZE,SIGMA)
        H_gaussian = fspecial('gaussian', 5, 0.5); 
        % no params
        H_laplacian = fspecial('laplacian');
        % filter gaussian FIRST
        imOut = imfilter(image, H_gaussian);
        imOut = imfilter(image, H_laplacian);
        
    case 2
        %method 2
        % from help: fspecial('log',HSIZE,SIGMA)
        H_log = fspecial('log', 5, 0.5);
        imOut = imfilter(image, H_log);

    case 3
        %method 3
        % ratio s1 / s2
        K = 5
        % filter sizes
        H_size = 5;
        % sigmas
        sigma_1 = .5;
        sigma_2 = sigma_1 * K
        
        % are these equal?
        % this might be faster - only 1 convolution 
        H_dog = fspecial('gaussian', H_size, sigma_1) - ...
                fspecial('gaussian', H_size, sigma_2);
        imOut = imfilter(image, H_dog);

        %{
        H_dog_1 = fspecial('gaussian',H_size, sigma_1);
        imOut_1 = imfilter(image, H_dog_1);
        H_dog_2 = fspecial('gaussian', H_size, sigma_2);
        imOut_2 = imfilter(image, H_dog_2);
        imOut = imOut_2 - imOut_1;
        %}
      
end
end

