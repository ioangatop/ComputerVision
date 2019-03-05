function [saved] = save_video(videoName, workingDir, frameRate)
    imageNames = dir(fullfile(workingDir,'*.jpeg'));
    imageNames = {imageNames.name}';

    outputVideo = VideoWriter(fullfile(workingDir,videoName));
    outputVideo.FrameRate = frameRate;
    open(outputVideo);

    for ii = 1:length(imageNames)
       img = imread(fullfile(workingDir,imageNames{ii}));
       writeVideo(outputVideo,img);
    end

    close(outputVideo);
    saved = true;
end

