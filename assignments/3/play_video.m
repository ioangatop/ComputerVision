function play_video(videoPath)
    shuttleAvi = VideoReader(videoPath);

    ii = 1;
    while hasFrame(shuttleAvi)
       mov(ii) = im2frame(readFrame(shuttleAvi));
       ii = ii+1;
    end

    movie(mov,1,shuttleAvi.FrameRate)
end

