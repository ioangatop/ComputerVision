% close earlier images
close all;

% load image
test_image = imread('images/image2.jpg');
im_gauss = compute_LoG(test_image, 1);
im_log = compute_LoG(test_image, 2);
im_dog = compute_LoG(test_image, 3);

figure
imshow(im_gauss / max(im_gauss(:)));
title('Gaussian');

figure
imshow(im_log / max(im_log(:)));
title('LoG');

figure
imshow(im_dog / max(im_dog(:)));
title('DoG');




