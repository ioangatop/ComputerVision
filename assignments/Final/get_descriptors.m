function d = get_descriptors(img, type, visualize)
%DENSE_FEAT Summary of this function goes here
%   d: Descriptor 
%   type: Descriptor type ('RGB', )


%% RGB

% sift for RGB
if type = 'RGB'
    img = single(img)
    if size(img, 3) == 3
        [~, d1] = vl_swift(img(:,:,1));
        [~, d2] = vl_swift(img(:,:,1));
        [~, d3] = vl_swift(img(:,:,1));
        d = cat(2, d1, d2, d3)
    else
        [~, d] = vl_swift(img);
    end
end

% dence RGB

if type = 'RGB'
    binSize = 8;
    magnif = 3;
    
    if size(img, 3) == 3
        img = rgb2gray(img)
    end
    img = im2single(img);
    
    img_smooth = vl_imsmooth(img, sqrt((binSize/magnif)^2 - .25)) ;
    [f, ~] = vl_dsift(img_smooth, 'Fast', 'size', binSize, 'Step', 20);
    f(3,:) = b/m;   
    f(4,:) = 0;
    
    if 
    
end
    
end

