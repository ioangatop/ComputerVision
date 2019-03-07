function [] = RANSAC(N, P)
%   RANSAC 
%     N: Repeat N times
%     P: Pick P matches at random from the total set of matches T 

% Get the matching points
[matches, scores, f_I, f_J, d_I, d_J] = keypoint_matching(I, J);

% We will take a subset P of matches and scores
% i) Generate P random numbers - indexes
[~, columns] = size(scores);
r = randi([1 columns],1, P);

% ii) Get the subset using this indexes
sub_matches = zeros(2, P);
sub_scores = zeros(P);
for i = 1:P
    sub_matches(:, i) = matches(:, r(i));
    sub_scores(i) = scores(r(i));
end



end

