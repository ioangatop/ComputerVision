function [f, d] = get_sift(img, type)
%KEYPOINTS Summary of this function goes here
%   f: feature frame. Each column its a feature frame and has the format 
%   [X, Y, S, TH] where X,Y is the fractional center of the frame, S is
%   the scale and TH is the orientation
%   type: describes the descriptor type 

% sift for RGB
[~, ~, channels] = size(img);
if type == 'RGB'
    img = single(img);
    if channels == 3
        [f1, d1] = vl_sift(img(:,:,1));
        [f2, d2] = vl_sift(img(:,:,2));
        [f3, d3] = vl_sift(img(:,:,3));
        d = cat(2, d1, d2, d3);
        f = cat(2, f1, f2, f3);

    else
        [f, d] = vl_swift(img);
    end
end

end

