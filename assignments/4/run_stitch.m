[original, stitched ] = stitch('right.jpg', 'left.jpg');

figure(1) ; clf ; 
imagesc(original) ;
title('Original images side by side');

figure(1) ; clf ;
imagesc(stitched) ;
title('Stitched image');