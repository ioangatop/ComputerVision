clear;
clc;

%% 3: Low-level filters

% 1D Gaussian Filter
G1 = gauss1D( 2 , 5 );

% 2D Gaussian Filter
G2 = gauss2D( 2 , 5 );

%% PSNR

% PSNR on image1 with salt and pepper noise
I = imread('images/image1.jpg');
J_sap = imread('images/image1_saltpepper.jpg');
PSNR_saltpepper =  myPSNR( I, J_sap );

% PSNR on image1 with gaussian noise
J_gauss = imread('images/image1_gaussian.jpg');
PSNR_gaussian =  myPSNR( I, J_gauss );

%% Denoise

% Denoise salt and pepper noise

% box
denoised_img_box = denoise( J_sap, 'box', 3);

% median
denoised_img_median = denoise( J_sap, 'median', 3);

% gaussian
denoised_img_gaussian = denoise( J_sap, 'gaussian', 2, 5);
