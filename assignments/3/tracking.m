%% Configuration
frameRate = 30;

%% Person toy

% workingDir = 'pingpong';
% I = imread('pingpong/0000.jpeg');
% [~, r, c] = harris_corner_detector(I, 360000000, false);
% 
% initial_images = load_images(workingDir, '*.jpeg');
% result_images = lucas_video(initial_images, r, c);
% 
% videoName = 'pingpong.avi';
% 
% saved = save_video(videoName, result_images, frameRate);
% if ~saved
%    return 
% end
% 
% play_video(videoName);


%% Pingpong

workingDir = 'person_toy';

I = imread('person_toy/00000001.jpg');
[~, r, c] = harris_corner_detector(I, 148000000, false);

initial_images = load_images(workingDir, '*.jpg');
result_images = lucas_video(initial_images, r, c);

videoName = 'person_toy.avi';

saved = save_video(videoName, result_images, frameRate);
if ~saved
   return 
end

play_video(fullfile(videoName));

