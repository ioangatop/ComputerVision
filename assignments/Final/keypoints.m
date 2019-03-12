function [f] = keypoints(img, visualize)
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
img = single(img);

%% Compute keypoints of image
f = vl_sift(img);

%% Visualize of keypoints
if visualize
    perm = randperm(size(f,2)) ;
    % --------------------------------------------------
    % Use sel in order to plot a subset of the keyponits
    sample = 10;
    sel = perm(1:sample) ;
    % --------------------------------------------------
    figure
    imshow(img_raw), hold on , vl_plotframe(f(:,perm)) ;
    set(vl_plotframe(f(:,perm)),'color','r','linewidth',2) ;
end
end

