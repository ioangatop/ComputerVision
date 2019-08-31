function [saved] = save_video(videoName, image_array, frameRate)
%     imageNames = dir(fullfile(workingDir,'*.jpeg'));
%     imageNames = {imageNames.name}';

    outputVideo = VideoWriter(fullfile(videoName));
    outputVideo.FrameRate = frameRate;
    open(outputVideo);
    
    [~, ~, ~, number_of_images] = size(image_array);

    for ii = 1:number_of_images
%        img = imread(fullfile(workingDir,imageNames{ii}));
       writeVideo(outputVideo, mat2gray(image_array(:, :, :, ii)));
    end

    close(outputVideo);
    saved = true;
end

