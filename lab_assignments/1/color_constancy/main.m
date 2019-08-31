img = imread('awb.jpg');

% Grey-World Algorithm
new_img = AWB(img);

% get the color density on axis x + y/2
color_dens(img, 'red');
color_dens(new_img, 'red');

% reduction = abs(avg2-avg1)*100 / (avg2+avg1)
reduction(img, new_img, 'red')