ballImage = imread('ball.png');
ballAlbedoImage = imread('ball_albedo.png');
ballShadingImage = imread('ball_shading.png');

% newImage = imfuse(ballAlbedoImage, ballShadingImage,'blend','Scaling','joint');

norm_ballAlbedoImage = im2double(ballAlbedoImage);
norm_ballShadingImage = im2double(ballShadingImage);

newImage = norm_ballAlbedoImage .* norm_ballShadingImage;
newImage = uint8(newImage*255);

subplot(2,1,1), imshow(ballImage), title('Original Image');
subplot(2,1,2), imshow(newImage), title('New Image');
% subplot(2,2,3), imshow(ballAlbedoImage), title('Albedo Image');
% subplot(2,2,4), imshow(ballShadingImage), title('Shading Image');
