% Images to Video
% avconv -f image2 -i pf_%3d.png -r 76 -s 800x600 foo.avi

% This is the main particle filter. This script calls all the required
% functions in the correct order.
%
% You can disable the plotting or change the number of steps the filter
% runs for to ease the debugging. You should however not change the order
% or calls of any of the oter lines, as it might break the framework.
%
% If you are unsure about the input and return values of functions you
% should read their documentation which tells you the expected dimensions.
% You will often encounter "M" in the dimensions which is the number of
% particles used.

% Make librobotics available
addpath('librobotics');

tic;

% Read world data, i.e. landmarks
landmarks = read_world('../data/world.dat');
% Read sensor readings, i.e. odometry and range-bearing sensor
data = read_data('../data/sensor_data.dat');

% Initialize particles
particles = initialize_particles(500);

% Perform filter update for each odometry, observation pair read from the
% data file

t =0;

% adjustment for kidnapping
cn = 0;
temp = 2; % 1 for kidnap, else 2

while t+cn < 50 %size(data.timestep, 2)+cn
    
    t = t+1;



%for t = 1:100 %size(data.timestep, 2)
    % Propagate the old particles according to the motion model
    
    if t == 1 
       x2 = 0.100692392654;  
       y2 = 0.100072845247;
       theta2 = 0.000171392857486;
       
    end
    
    
    %% kidnapping
    
    % do not use with robot position since robot position is calculated
    % using odometry, if steps are skipped, odometry will not give proper
    % location.
    
    %{
    if t == 10 && temp == 1
       t = 100;
       cn = -90;
       temp = 2;
       
       particles = initialize_particles(4500,x2,y2);
    end
   
    %}
    
    
    odomet = data.timestep(t).odometry;
    new_particles = sample_motion_model(odomet, particles);
    
    dr1 = odomet.r1;
    dr2 = odomet.r2;
    dt = odomet.t;
    
    
    
    
   
    % Compute the weights of the new particles using the distance-only sensor
    % model
    weights = measurement_model(data.timestep(t).sensor, new_particles, landmarks);
    
    
    t;
    x2 = x2 + dt*cos(theta2+dr1);
    y2 = y2 + dt*sin(theta2+dr1);
    theta2 = theta2 + dr1 + dr2;
    
    [t+cn,x2,y2,theta2]
    

    % Generate visualization plots of the current state of the filter
    plot_state(new_particles, weights, landmarks, t+cn,x2,y2,theta2);
    
    
    
    % Normalize the weights of the particles for stability reasons
    weights = weights ./ sum(weights);

    % Create a new generation of particles by sampling particles from the
    % old set according to their weight.
    particles = resample(new_particles, weights);
    
    
    
end

% Display the final state estimate
disp('Final pose:')
disp(mean_position(particles, weights))
toc;
