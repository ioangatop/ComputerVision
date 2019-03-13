function descriptors = get_keypoints(img, type)
%KEYPOINTS Summary of this function goes here
%   f: feature frame. Each column its a feature frame and has the format 
%   [X, Y, S, TH] where X,Y is the fractional center of the frame, S is
%   the scale and TH is the orientation
%   type: describes the descriptor type 

% sift for RGB
[~, ~, channels] = size(img);

if channels == 3
    img = single(img);
    if type == 'RGB'
        [~, descriptor_1] = vl_sift(img(:,:,1));
        [~, descriptor_2] = vl_sift(img(:,:,2));
        [~, descriptor_3] = vl_sift(img(:,:,3));
        descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    elseif  type == 'OPP'
        
    end
else % if image is greyscale
    [~, descriptors] = vl_sift(img);
end

end

