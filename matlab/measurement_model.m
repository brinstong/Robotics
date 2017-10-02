function weight = measurement_model(z, x, l)
    % Computes the weights of all particles.
    %
    % The employed sensor model is range only.
    %
    % z: structure containing the landmark observations, see
    %    read_data for the format
    % x: matrix of dimension M x 3 containing the current particles, each
    %    row repersents a single particle (x, y, theta)
    % l: structure containing the landmark position and ids, see
    %    read_world for the format
    % weight: M x 1 vector with particle weights computed with by the
    %         distance-only sensor model
   
    %Complete the file measurement model.m by implementing the sensor model of a distance-only
    %sensor with measurement standard deviation σ = 0.2. Use matrix operations where possible.
    %Instead of computing a probability it is sufficient to compute the likelihood p(z|x, l)

    % Sensor readings can again be indexed and each of the entris has the
    % following fields:
    % - id      : id of the observed landmark
    % - range   : measured range to the landmark
    % - bearing : measured angle to the landmark (you can ignore this)
    %
    % Examples:
    % - Translational component of the odometry reading at timestep 10
    %   data.timestep(10).odometry.t
    % - Measured range to the second landmark observed at timestep 4
    %   data.timestep(4).sensor(2).range
    
    % Each landmark contains the following information:
    % - id : id of the landmark
    % - x  : x-coordinate
    % - y  : y-coordinate
    %
    % Examples:
    % - Obtain x-coordinate of the 5-th landmark
    %   landmarks(5).x
 

    sigma = [0.2];
    weight = ones(size(x, 1), 1);
    
    if size(z, 2) == 0
        disp('cannot process since no landmarks were found');
        return
    end
    
    
    for i = 1:size(z, 2)
        
        landmark_id = z(i).id;
        
        landmark_position = [l(landmark_id).x, l(landmark_id).y];
        measurement_range = [z(i).range];

        % Landmark
        L = double(repmat(landmark_position, size(x, 1), 1));
        
        % Observation
        Z = repmat(measurement_range, size(x, 1), 1);
       
        %% Compute difference in distance for all particles at once
        xt = x(:,1:2);
        range = L - xt;
        dist_delta = sqrt(sum(range .^ 2, 2));

        weight = weight .* normpdf2(dist_delta  - Z(:,1), 0, sigma(1));
    end

    weight = weight ./ size(z, 2);
    
    
    
    
    
    
    
    
end
    
