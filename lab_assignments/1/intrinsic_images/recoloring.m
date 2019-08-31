ballImage = imread('ball.png');
ballAlbedoImage = imread('ball_albedo.png');
ballShadingImage = imread('ball_shading.png');

[h, w, ~] = size(ballAlbedoImage);

materialColor = get_material_color(ballAlbedoImage);
recoloredBallAlbedoImage = recolor_image(ballAlbedoImage, materialColor, [0, 255, 0]);

norm_ballAlbedoImage = im2double(recoloredBallAlbedoImage );
norm_ballShadingImage = im2double(ballShadingImage);

newImage = norm_ballAlbedoImage .* norm_ballShadingImage;
newImage = uint8(newImage*255);

subplot(2,2,1), imshow(ballImage), title('Original Image');
subplot(2,2,2), imshow(newImage), title('New Image');
subplot(2,2,3), imshow(recoloredBallAlbedoImage ), title('Recolored Albedo Image');
subplot(2,2,4), imshow(ballShadingImage), title('Shading Image');

