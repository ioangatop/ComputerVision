function [features, descriptors] = get_densely_sampled_regions(img, type, binSize, magnif, Step)
%==========================================================================
%   GET_DENSELY_SAMPLED_REGIONS: Dense SIFT descriptor extraction
%   (vl dsift).
%
%   - Argms:
%       * type: it get the type of the keypoints ('RGB', 'OPP')
%       * binSize: size of a spatial bin
%       * magnif: magnification factor
%
%   - Procedure:
%     After we make the appropiate modifications to the image (get the 
%     greyscale, single and smooth it) we find the frame features with
%     vl_dsift. This has two hyperparameters; binSize and magnif. 
%     Then we make the appropiate actions for each color space.
%     For 3 channel images, we get the descriptors for every channel and 
%     then stack them next to each other.
%==========================================================================
% turn image into greyscale (if it is not), single and smooth it
img_raw = im2single(img);
[~, ~, channels] = size(img);
if channels ~= 1
    img = im2single(rgb2gray(img));
end
img_smooth = vl_imsmooth(img, sqrt((binSize/magnif)^2 - .25));
% Find the frame features
[frame_features, ~] = vl_dsift(img_smooth, 'Fast', 'size', binSize, 'Step', Step);   
frame_features(3,:) = binSize/magnif;   
frame_features(4,:) = 0;
if type == "RGB"
 
    [features_1 , descriptor_1] = vl_sift(img_raw(:,:,1), 'frames', frame_features);
    [features_2 , descriptor_2] = vl_sift(img_raw(:,:,2), 'frames', frame_features);
    [features_3 , descriptor_3] = vl_sift(img_raw(:,:,3), 'frames', frame_features);
    features = cat(2, features_1, features_2, features_3);
    descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    
elseif type == "OPP"
    
    channel_1 = img_raw(:,:,1);
    channel_2 = img_raw(:,:,2);
    channel_3 = img_raw(:,:,3);
    img_raw(:,:,1) = single((channel_1-channel_2)/sqrt(2));                % O_1 color
    img_raw(:,:,2) = single((channel_1+channel_2-(2*channel_3))/sqrt(6));  % O_2 color
    img_raw(:,:,3) = single(((channel_1+channel_2+channel_3)/sqrt(3)));    % O_3 color
    [features_1 , descriptor_1] = vl_sift(img_raw(:,:,1), 'frames', frame_features);
    [features_2 , descriptor_2] = vl_sift(img_raw(:,:,2), 'frames', frame_features);
    [features_3 , descriptor_3] = vl_sift(img_raw(:,:,3), 'frames', frame_features);
    features = cat(2, features_1, features_2, features_3);
    descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
        
elseif type == 'GRAY'
    
    [features , descriptors] = vl_sift(img, 'frames', frame_features);
    
end