% close earlier images
close all;

% load image
test_image = imread('images/image2.jpg');
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(test_image);

% min max rescale
Gx = rescale(Gx, 'InputMin', min(Gx(:)), 'InputMax', max(Gx(:)));
Gy = rescale(Gy, 'InputMin', min(Gy(:)), 'InputMax', max(Gy(:)));

% figures
% just show the image
figure
imshow(test_image);
title('Image');

% show the gradients
figure
imshow(Gx)
title('Gradient X');

figure
imshow(Gy)
title('Gradient Y');

pause(0.01);

% show magnitude
figure
imshow(im_magnitude / max(im_magnitude(:)));
title('Magnitude');

figure
% show direction
imshow(im_direction);
title('Direction');

figure
imshow(im_direction / .5*pi);
title('Direction');



