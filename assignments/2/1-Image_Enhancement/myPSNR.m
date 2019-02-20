function [ PSNR ] = myPSNR( orig_image, approx_image )
% get img dimentions
[h, w, ~] = size(orig_image);

% convert images to double
orig_image = double(orig_image);
approx_image = double(approx_image);

% calculate PSNR
RMSE = sqrt(sum((orig_image - approx_image).^2, 'all')/(h*w));
PSNR = 20 * log10(max(max(orig_image))/RMSE);
end