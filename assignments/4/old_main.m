clear;
clc;
%% Necessary setup 

% Command to run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup

% Read the images
I = imread('boat1.pgm');
I_raw = imread('boat1.pgm');
J = imread('boat2.pgm');
J_raw = imread('boat2.pgm');

% Convert image in the appropriate format 
[h, w, c] = size(I);
if c ~= 1
    I = rgb2gray(I);
end

[h, w, c] = size(J);
if c ~= 1
    J = rgb2gray(J);
end

I = single(I) ;
J = single(J) ;

%% 1. Detect interest points in each image
%  Extracting frames and descriptors

% Compute SIFT frames (keypoints) and descriptors
[f_I, d_I] = vl_sift(I) ;

% Visualize a random selection of 50 features
% Image 1
perm = randperm(size(f_I, 2)) ;
sel = perm() ;
figure; hold off;
imshow(I_raw), hold on, vl_plotframe(f_I(:,sel)) ;
set(vl_plotframe(f_I(:,sel)),'color','r','linewidth',2) ;

% Image 2
figure; hold off;
[f_J, d_J] = vl_sift(J) ;
perm = randperm(size(f_J,2)) ;
sel = perm() ;
imshow(J_raw), hold on, vl_plotframe(f_J(:,sel)) ;
set(vl_plotframe(f_J(:,sel)),'color','y','linewidth',2) ;

%% 2. Characterize the local appearance of the regions around interest points
% Overlay the descriptors
figure; hold off;
imshow(I_raw), hold on , vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(vl_plotsiftdescriptor(d(:,sel),f(:,sel)),'color','g');

figure; hold off;
imshow(J_raw), hold on , vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(vl_plotsiftdescriptor(d(:,sel),f(:,sel)),'color','g');

%% 3. Get the set of supposed matches between region descriptors in each image
% Basic matching
% SIFT descriptors are often used find similar regions in two images
% vl_ubcmatch: a basic matching algorithm
% I and J are images of the same object or scene
[fa, da] = vl_sift(I) ;
[fb, db] = vl_sift(J) ;
[matches, scores] = vl_ubcmatch(da, db) ;

% We will take a subset of matches and scores

% Generate 10 random numbers - indexes
[rows, columns] = size(scores);
r = randi([0 columns],1,10);

% Get the subset using this indexes
% -- in this way, we can get the corresponding scores as well
samples = 10;
sub_matches = zeros(2, samples);
sub_scores = zeros(samples);
for i = 1:samples
    sub_matches(:, i) = matches(:, r(i));
    sub_scores(i) = scores(r(i));
end

% plot on the figure of the two images
figure ; hold off;
imshow(cat(2, I_raw, J_raw) );
hold on ;

% Get the axes
xa = fa(1,sub_matches(1,:)) ;
xb = fb(1,sub_matches(2,:)) + size(I,2) ;
ya = fa(2,sub_matches(1,:)) ;
yb = fb(2,sub_matches(2,:)) ;

% Get the random color -- every color is a 3x1 array
random_color = zeros(3, samples);
for i=1:samples
    random_color(:, i) = abs(rand(1,3));
end

% Connecting matching pairs with lines where each line has a random color
h = line([xa ; xb], [ya ; yb]) ;
for i=1:10
    set(h(i),'linewidth', 3, 'color', random_color(:,i)) ;
end


vl_plotframe(fa(:,sub_matches(1,:))) ;
fb(1,:) = fb(1,:) + size(I,2) ;
vl_plotframe(fb(:,sub_matches(2,:))) ;
axis image off ;

%% RANSAC algorithm

% Repeat N times
% N = 10
% 
% % Pick P matches at random from the total set of matches T
% P = 10
% sub_matches = zeros(2, P);
% sub_scores = zeros(P);
% for i = 1:P
%     sub_matches(:, i) = matches(:, r(i));
%     sub_scores(i) = scores(r(i));
% end

% 
