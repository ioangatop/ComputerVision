function [f, d] = get_dense(img, type)
%GET_DENSE Summary of this function goes here
%   Detailed explanation goes here
% dence RGB

[~, ~, channels] = size(img);
img_raw = img;
img_raw = im2single(img_raw);

if type == 'RGB'
    
    binSize = 8;
    magnif = 3;
    
    % Transform image to grayscale, single and smooth it
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = im2single(img);
    
    img_smooth = vl_imsmooth(img, sqrt((binSize/magnif)^2 - .25));
    
    % Find the frame features
    [f, ~] = vl_dsift(img_smooth, 'Fast', 'size', binSize, 'Step', 20);   
    f(3,:) = binSize/magnif;   
    f(4,:) = 0;
    
    % Get the descriptors for every channel
    if channels == 3
        [~ , d1] = vl_sift(img_raw(:,:,1), 'frames', f);
        [~ , d2] = vl_sift(img_raw(:,:,2), 'frames', f);
        [~ , d3] = vl_sift(img_raw(:,:,3), 'frames', f);
        d = cat(2, d1, d2, d3);
    else
        [~ , d] = vl_sift(img_raw, 'frames', f);
    end
end

end

