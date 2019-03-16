function pdfs = calculate_pdfs(images, centers, type, binSize, magnif, step)
    pdfs = zeros(size(images, 1), size(centers, 2));
    
    for i = 1:size(images, 1)
        image = reshape(images(i, :, :, :), 96, 96, 3);
        image_descriptors = get_densely_sampled_regions(image, type, binSize, magnif, step);
        pdf = calculate_pdf(image_descriptors, centers);
        pdfs(i, :) = pdf;
    end
end

