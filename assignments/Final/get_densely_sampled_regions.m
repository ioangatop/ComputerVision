function descriptors = get_densely_sampled_regions(img, type, binSize, magnif)
% get_densely_sampled_regions ; 
%   
%   type = ['RGB' , ...]
%   binSize = 8;
%   magnif = 3;


img_raw = im2single(img);
[~, ~, channels] = size(img);

if type == 'RGB'
    % Transform image to grayscale, single and smooth it
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = im2single(img);
    img_smooth = vl_imsmooth(img, sqrt((binSize/magnif)^2 - .25));
    
    % Find the frame features
    [frame_features, ~] = vl_dsift(img_smooth, 'Fast', 'size', binSize, 'Step', 20);   
    frame_features(3,:) = binSize/magnif;   
    frame_features(4,:) = 0;
    
    % Get the descriptors for every channel and then stack them next to 
    % each other
    if channels == 3
        [~ , descriptor_1] = vl_sift(img_raw(:,:,1), 'frames', frame_features);
        [~ , descriptor_2] = vl_sift(img_raw(:,:,2), 'frames', frame_features);
        [~ , descriptor_3] = vl_sift(img_raw(:,:,3), 'frames', frame_features);
        descriptors = cat(2, descriptor_1, descriptor_2, descriptor_3);
    else
        [~ , descriptors] = vl_sift(img_raw, 'frames', frame_features);
    end
end

end

