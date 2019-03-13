function pdfs = calculate_pdfs(images, centers, clusters_amount)
    type = 'RGB';
    binSize = 8;
    magnif = 3;
    
    pdfs = zeros(size(images, 1), size(centers, 2));
    
    for i = 1:size(images, 1)
        image = reshape(images(i, :, :, :), 96, 96, 3);
        image_descriptors = get_densely_sampled_regions(image, type, binSize, magnif);
        pdf = calculate_pdf(image_descriptors, centers);
        pdfs(i, :) = pdf;
    end
end

