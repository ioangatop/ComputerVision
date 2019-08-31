function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

% convert image to double
I = im2double(image);

% Sobel filters
% Not allowed, but for testing purposes for the exercise:
% Sx = fspecial('sobel'), Sy = fspecial('sobel)' -> Sy'
Sx = [ 
   [1, 0, -1],
   [2, 0, -2],
   [1, 0, -1]
];
Sy = [ 
   [1, 2, 1],
   [0, 0, 0],
   [-1, -2, -2]
];

% Gradients using imfilter
Gx = imfilter(I, Sx);
Gy = imfilter(I, Sy);

% matrix wise square
im_magnitude = sqrt(Gx.^2 + Gy.^2);

% compute direction -> matrix division
im_direction = atan(Gy ./ Gx);

end

