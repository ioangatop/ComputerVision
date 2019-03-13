function [probability_distribution] = calculate_probability_distribution(image_descriptors, centers, type, binSize, magnif)
%CALCULATE_PROBABILITY_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    
    image_descriptors = single(image_descriptors);
    
    
    probability_distribution = [];
    for i=1:size(image_descriptors, 2)
        dist = vl_alldist(image_descriptors(:,i), centers);
        [~, k] = min(dist);
        probability_distribution = [probability_distribution , k];
    end
end

