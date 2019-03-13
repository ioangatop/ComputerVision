clear; clc;
I = imread('cameraman.tif');
I = im2single(I);
binSize = 8 ;
magnif = 3 ;
Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25)) ;

[f, d] = vl_dsift(Is, 'size', binSize) ;
f(3,:) = binSize/magnif ;
f(4,:) = 0 ;
[f_, d_] = vl_sift(I, 'frames', f) ;