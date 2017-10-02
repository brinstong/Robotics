function prob = landmark_sensor_model(z, x, l)
    % Range and bearing sensor model
    %
    % z: observation of the range and bearing to a single landmark l
    % x: position from which the observation was made
    % l: position of the observed landmark
    sigma = [0.5, 0.1];

    delta_d = sqrt( (l(1) - x(1)) ** 2 + (l(2) - x(2)) ** 2 );
    delta_theta = atan2(l(2) - x(2), l(1) - x(1)) - x(3);

    prob = normpdf(delta_d - z(1), 0, sigma(1)) * normpdf(delta_theta - z(2), 0, sigma(2));
end
