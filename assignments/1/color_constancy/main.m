img = imread('awb.jpg');

new_img = AWB(img);

color_dens(img, 'red');
color_dens(new_img, 'red');