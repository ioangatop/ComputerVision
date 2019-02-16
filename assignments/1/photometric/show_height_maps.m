function [] = show_height_maps(height_map_col, height_map_row, height_map_avg)


Max = max(max(height_map_col(:)), max(height_map_row(:)));

figure;
subplot(1, 3, 1);
imshow(height_map_avg / Max);
title('Average Height Map');
% figure;
subplot(1, 3, 2);
imshow(height_map_row / Max);
title('Row Height Map');
% figure;
subplot(1, 3, 3);
imshow(height_map_col / Max);
title('Column Height Map');