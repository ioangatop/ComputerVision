function [f, d] = keypoints(img, visualize)
%KEYPOINTS Summary of this function goes here
%   f: each column its a feature frame and has the format [X, Y, S, TH]
%   where X,Y is the fractional center of the frame, S is the scale and
%   TH is the orientation

%% Convert image in the appropriate format 
% Grayscale -- incase that they are not
img_raw = img;
[~, ~, c] = size(img);
if c ~= 1
    img = rgb2gray(img);
end

% Single
img = im2single(img);

%% Compute keypoints of image
% f = vl_sift(img);

binSize = 8 ;
magnif = 5;
Is = vl_imsmooth(img, sqrt((binSize/magnif)^2 - .25)) ;

% [f, ~] = vl_dsift(Is, 'size', binSize);

[f, d] = vl_dsift(Is,'Fast' ,'size', binSize, 'Step', 20);


%% Visualize of keypoints
if visualize
    perm = randperm(size(f,2)) ;
    figure
    imshow(img_raw), hold on , vl_plotframe(f(:,perm)) ;
    set(vl_plotframe(f(:,perm)),'color','r','linewidth',2) ;
end
end

