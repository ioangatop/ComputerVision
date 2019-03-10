function [original, stitched] = stitch(right_img, left_img, plotKeypoints)
% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup

% Read the images
% keypoint_matching takes care of transforming image to grayscale
right_img_color = imread(right_img);
left_img_color = imread(left_img);

% return original with padding
[left_img_padded, right_img_padded ] = calcPadding(left_img_color, right_img_color);
original = [left_img_padded right_img_padded];

% get matchings
% keypoint finder INCLUDED IN RANSAC SCRIPT
% best transformation
% N = 50, P = 10, 
if (plotKeypoints == 1)
    % use the padded images instead, otherwise there will be an error
    [~, ~] = RANSAC(50, 10, left_img_padded,right_img_padded, false, false);
end
% this one returns the best m, t values
[m, t, img_right_trans] = RANSAC(50, 10, right_img_color, left_img_color, false, false);

% this is basically step 2, but we do not use the cornermethod
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
% pad horizontal and vertical with 0s
% help padarray (first dimension is vertical, second horizontal)
pad_1 = [max(size(img_1,1)-size(img_2,1),0) max(size(img_1,2)-size(img_2,2),0)];
pad_2 = [max(size(img_2,1)-size(img_1,1),0) max(size(img_2,2)-size(img_1,1),0)];
padded_1 = padarray(img_1, pad_2,'post');
padded_2 = padarray(img_2, pad_1,'post');
% 1 1 1 => equal sizes
% size(padded_1) == size(padded_2) 
end






