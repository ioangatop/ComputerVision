workingDir = 'pingpong';
frameRate = 30;
videoName = 'shuttle_out.avi';

saved = save_video(videoName, workingDir, frameRate);
if ~saved
   return 
end

play_video(fullfile(workingDir,videoName));
