function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    % get the range of x: [-x_limit, x_limit]
    x_limit = floor(kernel_size/2);
    i = 1;
    for x = -x_limit:x_limit
        G(i) = exp(-(x^2)/(2*sigma^2))/(sigma*sqrt(2*pi));
        i = i+1;
    end
    G = G / sum (G);
end
