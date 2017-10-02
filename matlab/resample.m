function new_particles = resample(particles, weights)
    % Returns a new set of particles obtained by performing
    % stochastic universal sampling.
    %
    % particles: M x 3 matrix of particles, each row representing a single
    %            particle (x, y, theta)
    % weights: M x 1 vector with the particle weigths
    % new_particles: M x 3 matrix with the resampled particles

    % TODO: implement
    % loop to generate M new points
    
    new_particles = [];

    M = size(particles, 1);
    
    c = zeros(M,1);

    c(1) = weights(1);
    for i = 2:M
      c(i) = c(i-1) + weights(i);
    end

    i = 1;
    u1 = unifrnd1(0, 1/M);
    for j = 1:M
      while (u1 > c(i))
        i = i + 1;
      end
      new_particles = [new_particles; particles(i,:)];
      u1 = u1 + 1/M;
    end
  
    
end
