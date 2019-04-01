function [named_labels] = convert_labels(num_labels)
    named_labels = [];
    for i = 1:length(num_labels)
        if num_labels(i) == 1
            named_labels = [named_labels; "airplane"];
        elseif num_labels(i) == 2
            named_labels = [named_labels; "bird"];
        elseif num_labels(i) == 3
            named_labels = [named_labels; "ship"];
        elseif num_labels(i) == 4
            named_labels = [named_labels; "horse"];
        elseif num_labels(i) == 5
            named_labels = [named_labels; "car"];
        end
    end
end

