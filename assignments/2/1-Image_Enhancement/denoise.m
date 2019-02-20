function [ imOut ] = denoise( image, kernel_type, varargin)

% convert images to double
image = double(image);

switch kernel_type
    case 'box'
        filter = imboxfilt(varargin);
    case 'median'
        filter = medfilt2(image, varargin);
    case 'gaussian'
        filter = gauss2D( varargin );
end

imOut = imfilter(image ,filter);
end
