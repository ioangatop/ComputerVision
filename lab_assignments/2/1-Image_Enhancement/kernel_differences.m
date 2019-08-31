clear;
clc;

I = imread('lines.jpg');
gaussFilter_1d_x = fspecial('gaussian',[1 50], 15);
gaussFilter_1d_y = gaussFilter_1d_x';

img_gaussFilter_1d_x = imfilter(I, gaussFilter_1d_x);
img_gaussFilter_1d_y = imfilter(I, gaussFilter_1d_y);

gaussFiltered = imgaussfilt(I, 5);

img_1 = uint8(img_gaussFilter_1d_x);
img_2 = uint8(img_gaussFilter_1d_y);

figure()
imshow(I);
figure()
imshow(img_1);
figure()
imshow(img_2);
figure()
imshow(gaussFiltered);