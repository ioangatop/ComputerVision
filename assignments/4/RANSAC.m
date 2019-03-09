function [m, t ] = RANSAC(N, P, I, J)
%   RANSAC 
%     N: Repeat N times
%     P: Pick P matches at random from the total set of matches T 

% Get the matching points
[matches, scores, f_I, f_J, d_I, d_J] = keypoint_matching(I, J);

% We will take a subset P of matches and scores
% Generate P random numbers - indexes
[~, columns] = size(scores);

% assume at first count that all matches are outliers
best_inliners = 0;
% initialize a best x
best_x = zeros(6,1);

% Get a random match and with sub_f_I and sub_f_J get the coordinates
% of image I and J of this match
% do this N times
for n = 1:N
    A = zeros(2*P, 6);
    b = zeros(2*P, 1);
    % remember to randomize every loop
    r = randi([1 columns],1, P);
    
    for i = 1:P
        % Get the indexes
        sub_match = matches(:, r(i));

        % Get (x, y) of I of this match point
        sub_f_I = f_I((1:2), sub_match(1));
   
        % Get (x', y') of J of this match point
        sub_f_J = f_J((1:2), sub_match(2));
        
        % Calculate matrix A and b
        % watch out for 1,0 / 0,1 per equation 3
        % FILL A & B in descending order       
        A(2*i-1:2*i,:) = [ sub_f_I(1), sub_f_I(2), 0, 0, 1, 0;
            0, 0, sub_f_I(1), sub_f_I(2), 0, 1];
        b(2*i-1:2*i) = [ sub_f_J(1); sub_f_J(2) ];
        
    end
        
    % Solve the equation using pseduo-inverse
    % where x is the transformation of every point
    x = pinv(A)*b;
        
    % do test after applying transform for random points
    current_inliers = 0;
    % apply transform to each random selected point in r
    % calculate euclidean distance < 10 => inlier
    for i = 1:P
        % pick a random point
        sub_match = matches(:, r(i));
        % (x,y)
        sub_f_I = f_I((1:2), sub_match(1));
        % this is the transformed pixel
        sub_f_J = f_J(1:2, sub_match(2));
        % equation 3
        resulting_point = [sub_f_I(1), sub_f_I(2), 0, 0, 1, 0; 
            0, 0, sub_f_I(1), sub_f_I(2), 0, 1];
       
        % comparision
        % norm is euclidean distance (radius circle) 
        % resulting_point * x is the predicted projection
        if norm(sub_f_J - (resulting_point * x)) <= 10
            current_inliers = current_inliers + 1;
        end
    end
    % are we having a better score
    % if yes: then save
    if current_inliers > best_inliners
       best_inliners = current_inliers;
       best_x = x;
    end
end

% take the avg of all transformations to and approx all of the points 
% with it
% final_x = mean(best_x, 2);
final_x = best_x;

% Transform the locations of all T points in image1
% Constract m and t matrixs
m = [final_x(1), final_x(2); final_x(3), final_x(4)];
t = [final_x(5); final_x(6)];


end


