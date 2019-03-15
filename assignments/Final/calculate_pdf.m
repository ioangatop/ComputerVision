function [pdf] = calculate_pdf(image_descriptors, centers)
%==========================================================================
%   CALCULATE_PDF: returns descriptors extracted from  densely sampled
%   regions.
%
%   - Argms:
%       * image_descriptors: 
%       * centers: 
%
%   - Procedure:
%     
%     
%     
%==========================================================================    

    image_descriptors = single(image_descriptors);
    pdf = zeros(1, size(centers, 2));

    for i=1:size(image_descriptors, 2)
        dist = vl_alldist(image_descriptors(:,i), centers);
        [~, k] = min(dist);
        pdf(k) = pdf(k) + 1;
    end
    pdf = pdf ./ size(image_descriptors, 2);
end

