function mean_pos = mean_position(particles, weights)
    % Returns a single estimate of filter state (x, y, theta) based
    % on the particle cloud.
    %
    % particles: matrix of dimension M x 3 representing the particles
    % weights: vector of dimension M x 1 containing the particle weights
    % mean_pos: 3 x 1 vector with the estimate of the filter state / pose

    mean_pos = zeros(1,3);
    
    part_01 = particles(:,1);
    part_02 = particles(:,2);
    part_03 = particles(:,3);

    mean_pos(1) = sum(part_01 .* weights);
    mean_pos(2) = sum(part_02 .* weights);
    mean_pos(3) = average_angle(part_03 .* weights);
   
    
end