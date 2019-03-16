function [features, descriptors] = get_keypoints(img, type)
%==========================================================================
%   GET_KEYPOINTS: Key-points SIFT descriptor extraction (vl sift)
%
%   - Argms:
%       * type: it get the type of the keypoints ('RGB', 'OPP')
%
%   - Procedure:
%     We first check the channels:
%        * if the type is 'RGB', it will jump to calculate the descriptors.
%        * if the type is something else, then it will do the nessesary
%          modifications to the channel and then calculate the descriptors.
%        * if the channels are 1, the image considered as greyscale
%==========================================================================
img_raw = img
[~, ~, channels] = size(img);
img = single(img);
if type == "RGB" && channels==3
    
    [features_1, descriptor_1] = vl_sift(img(:,:,1));
    [features_2, descriptor_2] = vl_sift(img(:,:,2));
    [features_3, descriptor_3] = vl_sift(img(:,:,3));
    descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    features = cat(2, features_1, features_2, features_3);
    
elseif type == "OPP" && channels==3
    
    channel_1 = img(:,:,1);
    channel_2 = img(:,:,2);
    channel_3 = img(:,:,3);
    img(:,:,1) = single( (channel_1 - channel_2) / sqrt(2) );                  % O_1 color
    img(:,:,2) = single( (channel_1 + channel_2 - (2*channel_3) )/ sqrt(6) );  % O_2 color
    img(:,:,3) = single( ( (channel_1+channel_2+channel_3) / sqrt(3) ));       % O_3 color
        
    [features_1, descriptor_1] = vl_sift(img(:,:,1));
    [features_2, descriptor_2] = vl_sift(img(:,:,2));
    [features_3, descriptor_3] = vl_sift(img(:,:,3));
    descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    features = cat(2, features_1, features_2, features_3);

elseif type == "GRAY"
    
    if channels~=1
        img = im2single(rgb2gray(img_raw));
    end
    img = im2single(img);
    [features, descriptors] = vl_sift(img);
    
end
end