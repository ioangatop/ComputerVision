%% Configuration
frameRate = 24;

%% Pingpong

workingDir = 'pingpong';
I = imread('pingpong/0000.jpeg');
[~, r, c] = harris_corner_detector(I, 1000000000, false);

initial_images = load_images(workingDir, '*.jpeg');
result_images = lucas_video(initial_images, r, c);

videoName = 'pingpong.avi';

saved = save_video(videoName, result_images, frameRate);
if saved
    play_video(videoName);
end


%% Person toy
 
workingDir = 'person_toy';

I = imread('person_toy/00000001.jpg');
[~, r, c] = harris_corner_detector(I, 140000000, false);

initial_images = load_images(workingDir, '*.jpg');
result_images = lucas_video(initial_images, r, c);
% 
videoName = 'person_toy.avi';

saved = save_video(videoName, result_images, frameRate);
if saved
   play_video(fullfile(videoName));
end

