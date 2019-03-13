function show_histogram(histogram_array, clusters_amount)
    plot_array = zeros(1, sum(histogram_array));
    size(histogram_array)
    
    counter = 1;
    for i = 1:length(histogram_array)
        current_count = histogram_array(i);
        if current_count == 0
            continue
        end
        
        plot_array(counter:counter+current_count-1) = ones(1, current_count) * i; 
        
        counter = counter + current_count - 1;
    end
    
    histogram(plot_array, clusters_amount);
end

