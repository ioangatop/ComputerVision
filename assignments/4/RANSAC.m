function [] = RANSAC(N, P, I, J)
%   RANSAC 
%     N: Repeat N times
%     P: Pick P matches at random from the total set of matches T 

% Get the matching points
[matches, scores, f_I, f_J, d_I, d_J] = keypoint_matching(I, J);

% We will take a subset P of matches and scores
% Generate P random numbers - indexes
[~, columns] = size(scores);
r = randi([1 columns],1, P);

% Get the subset using this indexes
sub_matches = zeros(2, P);
sub_f_I = zeros(2, P);
sub_f_J = zeros(2, P);
x = zeros(6, P);

% Get a random match and with sub_f_I and sub_f_J get the coordinates
% of image I and J of this match
for i = 1:P
    
    % Get the indexes
    sub_matches(:, i) = matches(:, r(i));
    
    % Get (x, y) of I of this match point
    sub_f_I(:, i) = f_I((1:2), sub_matches(1, i));
    
    % Get (x', y') of I of this match point
    sub_f_J(:, i) = f_J((1:2), sub_matches(2, i));
    
    % Calculate matrix A and b
    A = [ sub_f_I(1, i), sub_f_I(1, i), 0, 0, 1, 0;
        0, 0, sub_f_I(1, i), sub_f_I(1, i), 1, 0;];
    b = [ sub_f_I(1, i); sub_f_I(2, i) ];
    
    % Solve the equation using pseduo-inverse
    % where x is the transformation of every point
    x(:,i) = pinv(A)*b;
    
end   

% take the avg of all transformations to and approx all of the points 
% with it
x = mean(x, 2);

% Transform the locations of all T points in image1
% Constract m and t matrixs
m = [x(1), x(2); x(3), x(4)];
t = [x(5); x(6)];

% find the new transformed coordinates
% sub_f_I (x,y of I) -> new_xy (x, y)
new_xy = m * sub_f_I + t;
end


