function [best_m, best_t, matches, f_image1, f_image2] = RANSAC(N, P, image1, image2, visualize_connection)
%   RANSAC 
%     N: Repeat N times
%     P: Pick P matches at random from the total set of matches T 
    max_inliers_count = -1;
    best_m = zeros(2, 2);
    best_t = zeros(2, 1);
    
    for i = 1:N
        % Get the matching points
        [matches, ~, f_image1, f_image2, ~, ~] = keypoint_matching(image1, image2);

        % We will take a subset P of matches and scores
        % Generate P random numbers - indexes
        [~, columns] = size(matches);
        r = randi([1 columns],1, P);

        % Get the subset using this indexes
        A = zeros(2*P,6);
        b = zeros(2*P,1);

        % Get a random match and with sub_f_I and sub_f_J get the coordinates
        % of image I and J of this match
        for j = 1:P

            % Get the indexes
            sub_matches = matches(:, r(j));

            % Get (x, y) of I of this match point
            sub_f_image1 = f_image1((1:2), sub_matches(1));

            % Get (x', y') of J of this match point
            sub_f_image2 = f_image2((1:2), sub_matches(2));

            % Calculate matrix A and b
            current_A = [ sub_f_image1(1), sub_f_image1(2), 0, 0, 1, 0;
                0, 0, sub_f_image1(1), sub_f_image1(2), 0, 1;];
            
            current_b = [sub_f_image2(1); sub_f_image2(2) ];
            
            A = cat(1, A, current_A);
            b = cat(1, b, current_b);
        end
        
        % Solve the equation using pseudo-inverse
        % where x is the transformation of every point    
        x = pinv(A) * b;

        % Transform the locations of all T points in image1
        % Constract m and t matrixs
        m = [x(1), x(2); x(3), x(4)];
        t = [x(5); x(6)];
        
        % 3) Plot on the figure of the two images
        if visualize_connection
            figure; 
            hold off;
            imshow(cat(2, image1, image2));
            hold on;
        end
        
        current_inliers_count = 0;

        for j=1:length(matches)
            new_xy = m * f_image1(1:2, matches(1, j)) + t;
            
            if visualize_connection
                random_color = abs(rand(1,3));

                xa = f_image1(1, matches(1, j));
                xb = new_xy(1) + size(image1, 2);
                ya = f_image1(2, matches(1, j));
                yb = new_xy(2);

                l = line([xa ; xb], [ya ; yb]);
                set(l,'linewidth', 1.5, 'color', random_color);
            end
            
            image2_point = f_image2(1:2, matches(2, j));
            
            % check if the distance between the points is 
            % less than inlier_radius
            distance_between_points = pdist([new_xy(1) new_xy(2); image2_point(1) image2_point(2)]);
            if distance_between_points <= 10
               current_inliers_count = current_inliers_count + 1;
            end
        end
        
        if max_inliers_count < current_inliers_count
            % fprintf('found new best!');
            max_inliers_count = current_inliers_count;
            best_m = m;
            best_t = t;
        end
    end
    
%% Create transformed image
        
    new_image1 = transform_image(image1, best_m, best_t);
  
%% Display transformation

    figure, subplot(1,3,1), imshow(image1), title('left image');
    subplot(1,3,2), imshow(new_image1), title('transformed image');
    subplot(1,3,3), imshow(image2), title('right image');

%% Compare with MATLAB built-in function
    M_inv = best_m .* (- ones(length(best_m)) + 2 * eye(length(best_m)));
    tf_inv = maketform('affine', [M_inv ; best_t']);
    t_image_m = imtransform(image1, tf_inv, 'nearest');

    % Compare with MATLAB
    figure, subplot(1,2,1), imshow(new_image1), title('our transformation', 'FontSize', 16)
    subplot(1,2,2),imshow(t_image_m), title('MATLAB transformation', 'FontSize', 16)
end


