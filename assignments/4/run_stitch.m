[original, stitched ] = stitch('right.jpg', 'left.jpg');
figure(1) ; clf ;
subplot(2,1,1) ;
title('Original image');
imagesc(original) ;

figure(1) ; clf ;
subplot(2,1,1) ;
imagesc(stitched) ;
title('Original image');
