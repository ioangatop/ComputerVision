ballImage = imread('ball.png');
ballAlbedoImage = imread('ball_albedo.png');
ballShadingImage = imread('ball_shading.png');


[h, w, ~] = size(ballAlbedoImage);

for x = 1:h
    for y = 1:w
        if ballAlbedoImage(x, y, 1) ~= 0 | ballAlbedoImage(x, y, 2) ~= 0 | ballAlbedoImage(x, y, 3) ~= 0
            
            ballAlbedoImage(x, y, 1) = 0;
            ballAlbedoImage(x, y, 2) = 255;
            ballAlbedoImage(x, y, 3) = 0;
        end
    end
end

% newImage = imfuse(ballAlbedoImage, ballShadingImage,'blend','Scaling','joint');

norm_ballAlbedoImage = im2double(ballAlbedoImage);
norm_ballShadingImage = im2double(ballShadingImage);

newImage = norm_ballAlbedoImage .* norm_ballShadingImage;
newImage = uint8(newImage*255);

subplot(2,2,1), imshow(ballImage), title('Original Image');
subplot(2,2,2), imshow(newImage), title('New Image');
subplot(2,2,3), imshow(ballAlbedoImage), title('Albedo Image');
subplot(2,2,4), imshow(ballShadingImage), title('Shading Image');

