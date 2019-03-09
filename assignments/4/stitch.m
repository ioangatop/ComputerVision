function [original, stitched] = stitch(right_img, left_img)
% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup

% Read the images
% keypoint_matching takes care of transforming image to grayscale
right_img_color = imread(right_img);
left_img_color = imread(left_img);

% return original with padding
[left_img_padded, right_img_padded ] = calcPadding(left_img_color, right_img_color);
original = [left_img_padded right_img_padded];
figure()
imshow(original)

% get matchings
% keypoint finder INCLUDED IN RANSAC SCRIPT
% best transformation
% N = 50, P = 10, 
[m, t] = RANSAC(50, 10, right_img_color, left_img_color);

% this may seem counterintuitive, but imread has the y values 
% in the first position, x values in the second
% i.e. the right_image is 255px wide, 333px high
% the right_img_color matrix = [333, 255, 3]
% keep this convention in line 33
for x_pixel = 1:size(right_img_color,2)
    for y_pixel = 1:size(right_img_color,1)
        % calculate transformation using nearest neighbor
        % which is simply rounding coordinates (from hint in 1)
        transformation = round(m*[x_pixel; y_pixel] +t);
        if (transformation(1) > 0 && transformation(2) > 0) 
            img_right_trans(transformation(2),transformation(1), :) = right_img_color(y_pixel, x_pixel, :);
        end
    end
end

% this image might be out of bounds
% let's pad them to the left img
[trans_img_padded, left_img_padded ] = calcPadding(img_right_trans, left_img_color);

% figure()
% imshow([left_img_padded,trans_img_padded])

% since we have padded the images, they are equal in size
% so we can use a binary operator like maximum to select pixels
% with values. This way the trans_img_padded values > 0
% will be chosen where those of left_img_padded == 0
stitched = max(trans_img_padded, left_img_padded);

end

function [padded_1, padded_2] = calcPadding(img_1, img_2)
% pad horizontal and vertical
% help padarray (first dimension is vertical, second horizontal)
pad_1 = [max(size(img_1,1)-size(img_2,1),0) max(size(img_1,2)-size(img_2,2),0)];
pad_2 = [max(size(img_2,1)-size(img_1,1),0) max(size(img_2,2)-size(img_1,1),0)];
padded_1 = padarray(img_1, pad_2,'post');
padded_2 = padarray(img_2, pad_1,'post');
% 1 1 1 => equal sizes
% size(padded_1) == size(padded_2) 
end






