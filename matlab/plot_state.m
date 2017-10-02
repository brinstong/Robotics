function plot_state(particles, weights, landmarks, timestep,x2,y2,theta2)
    % Visualizes the state of the particle filter.
    %
    % The resulting plot displays the following information:
    % - landmark positions
    % - particle positions
    % - estimate of the filter state
    %
    % particles: M x 3 matrix with the current particles
    % weights: M x 1 vector with the particle weights
    % timestep: current step in the filtering process
    clf
    hold on;
    grid on; 
    L = struct2cell(landmarks);
    h = figure(1); 
    set(h, 'Visible', 'off');
    plot(particles(:, 1), particles(:, 2), '.');
    
    %% draw orientation of robot (original position from odometry)
    [u,v] = pol2cart(theta2,1); 
    q = quiver(x2,y2,u,v);
    q.LineWidth = 1.5;
    q.LineStyle = '--';
    q.MaxHeadSize = 0.4;
    
    plot(cell2mat(L(2,:)), cell2mat(L(3,:)), 'o');
    %drawrobot(mean_position(particles, weights), 'r');
    xlim([-1, 11])
    ylim([-1, 11])
    filename = sprintf('../plots/pf_%03d.png', timestep);
    print(filename, '-dpng');
    hold off
end
