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
    if type == 'OPP'
        channel_1 = img(:,:,1);
        channel_2 = img(:,:,2);
        channel_3 = img(:,:,3);
        
        % O1, O2 and O3 correspont to the oppoment color space channels
        % Ok = img(:,:,k), where k = {1, 2, 3}
        img(:,:,1) = single((channel_1-channel_2)/sqrt(2));
        img(:,:,2) = single((channel_1+channel_2-(2*channel_3))/sqrt(6));
        img(:,:,3) = single(((channel_1+channel_2+channel_3)/sqrt(3)) ;
        
    [~, descriptor_1] = vl_sift(img(:,:,1));
    [~, descriptor_2] = vl_sift(img(:,:,2));
    [~, descriptor_3] = vl_sift(img(:,:,3));
    descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    end
else % if image is greyscale
    [~, descriptors] = vl_sift(img);
end

end

