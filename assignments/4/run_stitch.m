% plot keypoints is 1 -> shows keypoints
% done inside RANSAC because otherwise
% there would be too many parameters passing around through all the functions
[original, stitched ] = stitch('right.jpg', 'left.jpg', 1);

figure(1) ; clf ; 
imagesc(original) ;
title('Original images side by side');

figure(1) ; clf ;
imagesc(stitched) ;
title('Stitched image');