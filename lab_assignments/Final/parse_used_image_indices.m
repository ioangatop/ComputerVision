function used_image_indices_per_class = parse_used_image_indices(used_classes, class_size, labels)
%PARSE_USED_IMAGES Parses used images
%   We order them into one MxN matrix where M is the amount 
%   of classes and N is the number of class size we are using
    used_image_indices_per_class = zeros(length(used_classes), class_size);

    for i = 1:length(used_classes)
        y_class = find(labels == used_classes(i));
        y_class = y_class(1:class_size);
        used_image_indices_per_class(i, :) = y_class;
    end
end

