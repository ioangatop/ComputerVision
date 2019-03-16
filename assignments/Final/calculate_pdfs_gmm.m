function pdfs = calculate_pdfs_gmm(images, means, covariances, priors, type, binSize, magnif, step)
    pdfs = zeros(size(images, 1), size(centers, 2));
    
    for i = 1:size(images, 1)
        image = reshape(images(i, :, :, :), 96, 96, 3);
        image_descriptors = get_densely_sampled_regions(image, type, binSize, magnif, step);
        pdf = calculate_pdf_gmm(image_descriptors, means, covariances, priors);
        pdfs(i, :) = pdf;
    end
end

