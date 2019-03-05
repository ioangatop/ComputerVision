%% Configuration
frameRate = 30;

%% Person toy

workingDir = 'pingpong';
I = imread('pingpong/0000.jpeg');
[~, r, c] = harris_corner_detector(I, 148000000);

initial_images = load_images(workingDir, '*.jpg');    
lucas_video(initial_images, r, c)
%imageFrames = lucas_kanade(r, c)

% videoName = '.avi';
% 
% saved = save_video(videoName, workingDir, frameRate);
% if ~saved
%    return 
% end
% 
% play_video(fullfile(workingDir,videoName));
% 

%% Pingpong

% workingDir = 'person_toy';
% 
% I = imread('pingpong/0000.jpeg');
% [~, r, c] = harris_corner_detector(I, 360000000);
% 
% initial_images = load_images(workingDir, '*.jpeg');    
% imageFrames = lucas_kanade(r, c)

