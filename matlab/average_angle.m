function avg_angle = average_angle(angles)
    % Computes the average angle of a vector of angles.
    %
    % angles: row vector of angles in radians
    % avg_angle: average angle in radians
    
    sum_ang = sum(angles);
    count_ang = length(angles);
    
    avg_angle = sum_ang/count_ang;
    
end