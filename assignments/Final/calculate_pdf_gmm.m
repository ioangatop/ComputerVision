function [pdf] = calculate_pdf_gmm(image_descriptors, means, covariances, priors);
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
    pdf = zeros(1, size(means, 2));

    for i=1:size(image_descriptors, 2)
        dist = vl_fisher(image_descriptors(:,i), means, covariances, priors);
        [k] = dist;
        pdf(k) = pdf(k) + 1;
    end
    pdf = pdf ./ size(image_descriptors, 2);
end

