function x_new = motion_model(x, u)
    % Samples a new position with the motion model
    %
    % x: old position
    % u: odometry reading
    noise = [0.1, 0.1, 0.05, 0.05];

    % Add noise to odometry reading
    odom = u;
    odom(1) += normrnd(0.0, noise(1) * abs(u(1)) + noise(2) * u(2));
    odom(2) += normrnd(0.0, noise(3) * u(2) + noise(4) * (abs(u(1)) + abs(u(3))));
    odom(3) += normrnd(0.0, noise(1) * abs(u(3)) + noise(2) * u(2));

    % Compute new pose
    x_new = x;
    x_new(1) += odom(2) * cos(x(3) + odom(1));
    x_new(2) += odom(2) * sin(x(3) + odom(1));
    x_new(3) += odom(1) + odom(3);
end
