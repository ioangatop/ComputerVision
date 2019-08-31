function [new_image] = normalize_image(image)
%normalize_image:
%   Normalizes the image by taking all the neighbor pixels including the
%   current one, removing all those who are black and averaging the values
    [h, w, ~] = size(image);
    new_image = zeros(size(image));
    for y = 1:size(image, 1)
        for x = 1:size(image, 2)
            if ~pixel_is_black(image(y, x, :))
                new_image(y, x, :) = image(y, x, :);
                continue
            end
            
            all_neighbor_values = zeros(1, 1, size(image, 3));
            count = 0;
            
            if y > 1
                if ~pixel_is_black(image(y - 1, x, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y - 1, x, :);
                end
                
                if x > 1 && ~pixel_is_black(image(y - 1, x - 1, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y - 1, x - 1, :);
                end
                
                if x < w && ~pixel_is_black(image(y - 1, x + 1, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y - 1, x + 1, :);
                end
            end
            
            if y < h
                if ~pixel_is_black(image(y + 1, x, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y + 1, x, :);
                end
                
                if x > 1 && ~pixel_is_black(image(y + 1, x - 1, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y + 1, x - 1, :);
                end
                
                if x < w && ~pixel_is_black(image(y + 1, x + 1, :))
                    count = count + 1;
                    all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y + 1, x + 1, :);
                end
            end
            
            
            if x > 1 && ~pixel_is_black(image(y, x - 1, :))
                count = count + 1;
                all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y, x - 1, :);
            end

            if x < w && ~pixel_is_black(image(y, x + 1, :))
                count = count + 1;
                all_neighbor_values(1, 1, :) = all_neighbor_values(1, 1, :) + image(y, x + 1, :);
            end
            
            new_value = all_neighbor_values(1, 1, :) ./ count;
            new_image(y, x, :) = new_value(:);
        end
    end
end

