clear;
clc;

%% 3: Low-level filters

% 1D Gaussian Filter
G1 = gauss1D( 2 , 5 );

% 2D Gaussian Filter
G2 = gauss2D( 2 , 5 );

%% PSNR

% Read raw image
I = imread('images/image1.jpg');

% PSNR on image1 with salt and pepper noise
J_sap = imread('images/image1_saltpepper.jpg');
PSNR_saltpepper = myPSNR( I, J_sap );

% PSNR on image1 with gaussian noise
J_gauss = imread('images/image1_gaussian.jpg');
PSNR_gaussian = myPSNR( I, J_gauss );

%% Denoise

% noise
figure();
subplot(1, 3, 1), imshow(I), xlabel('Raw image','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 2), imshow(J_sap), xlabel('Salt and Pepper noise','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 3), imshow(J_gauss), xlabel('Gaussian noise','FontName', 'Helvetica Neue', 'FontSize', 10);
suptitle('Raw image with Salt & Pepper and Gaussian noise');

%% Denoise salt and pepper noise

% box filter
denoised_sap_box_3 = denoise( J_sap, 'box', 3);
denoised_sap_box_5 = denoise( J_sap, 'box', 5);
denoised_sap_box_7 = denoise( J_sap, 'box', 7);

figure();
subplot(1, 3, 1), imshow(denoised_sap_box_3), xlabel('Box filtering 3x3','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 2), imshow(denoised_sap_box_5), xlabel('Box filtering 5x5','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 3), imshow(denoised_sap_box_7), xlabel('Box filtering 7x7','FontName', 'Helvetica Neue', 'FontSize', 10);
suptitle('Salt & Pepper noise - box filter');

% median filter
denoised_sap_median_3 = denoise( J_sap, 'median', 3);
denoised_sap_median_5 = denoise( J_sap, 'median', 5);
denoised_sap_median_7 = denoise( J_sap, 'median', 7);

figure();
subplot(1, 3, 1), imshow(denoised_sap_median_3), xlabel('Median filtering 3x3','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 2), imshow(denoised_sap_median_5), xlabel('Median filtering 5x5','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 3), imshow(denoised_sap_median_7), xlabel('Median filtering 7x7','FontName', 'Helvetica Neue', 'FontSize', 10);
suptitle('Salt & Pepper noise - median filter');

%% Denoise Gaussian noise

% box filter
denoised_gauss_box_3 = denoise( J_gauss, 'box', 3);
denoised_gauss_box_5 = denoise( J_gauss, 'box', 5);
denoised_gauss_box_7 = denoise( J_gauss, 'box', 7);

figure();
subplot(1, 3, 1), imshow(denoised_gauss_box_3), xlabel('Box filtering 3x3','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 2), imshow(denoised_gauss_box_5), xlabel('Box filtering 5x5','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 3), imshow(denoised_gauss_box_7), xlabel('Box filtering 7x7','FontName', 'Helvetica Neue', 'FontSize', 10);
suptitle('Gaussian noise - box filter');

% median filter
denoised_gauss_median_3 = denoise( J_gauss, 'median', 3);
denoised_gauss_median_5 = denoise( J_gauss, 'median', 5);
denoised_gauss_median_7 = denoise( J_gauss, 'median', 7);

figure();
subplot(1, 3, 1), imshow(denoised_gauss_median_3), xlabel('Median filtering 3x3','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 2), imshow(denoised_gauss_median_5), xlabel('Median filtering 5x5','FontName', 'Helvetica Neue', 'FontSize', 10);
subplot(1, 3, 3), imshow(denoised_gauss_median_7), xlabel('Median filtering 7x7','FontName', 'Helvetica Neue', 'FontSize', 10);
suptitle('Gaussian noise - median filter');

%% PSNR
psnr_sap_box_3 = myPSNR( I, denoised_sap_box_3 );
psnr_sap_box_5 = myPSNR( I, denoised_sap_box_5 );
psnr_sap_box_7 = myPSNR( I, denoised_sap_box_7 );
psnr_sap_median_3 = myPSNR( I, denoised_sap_median_3 );
psnr_sap_median_5 = myPSNR( I, denoised_sap_median_5 );
psnr_sap_median_7 = myPSNR( I, denoised_sap_median_7 );

psnr_gauss_box_3 = myPSNR( I, denoised_gauss_box_3 );
psnr_gauss_box_5 = myPSNR( I, denoised_gauss_box_5 );
psnr_gauss_box_7 = myPSNR( I, denoised_gauss_box_7 );
psnr_gauss_median_3 = myPSNR( I, denoised_gauss_median_3 );
psnr_gauss_median_5 = myPSNR( I, denoised_gauss_median_5 );
psnr_gauss_median_7 = myPSNR( I, denoised_gauss_median_7 );

%% gaussian filter
denoised_sap_gaussian = denoise( J_sap, 'gaussian', 2, 5);
denoised_gauss_gaussian = denoise( J_gauss, 'gaussian', 2, 5);

% figure();
% imshow(denoised_img_gaussian), xlabel('Gaussian noise','FontName', 'Helvetica Neue', 'FontSize', 10);

% Denoise Gaussian noise