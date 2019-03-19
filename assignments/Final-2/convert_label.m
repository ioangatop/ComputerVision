function new_label = convert_label(old_label)
%CONVERT_LABEL Summary of this function goes here
%   Detailed explanation goes here
% {'airplanes', 'birds', 'ships', 'horses', 'cars'}
    if old_label < 3
        new_label = old_label;
    elseif old_label == 9
        new_label = 3;
    elseif old_label == 7
        new_label = 4;
    else
        new_label = 5;
    end
end

