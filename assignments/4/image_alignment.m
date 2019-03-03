function [outputArg1,outputArg2] = image_alignment(I, J)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

I = single(rgb2gray(I)) ;
[f,d] = vl_sift(I) ;
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

