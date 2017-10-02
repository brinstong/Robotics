% goal reaching and obstance avoidance 
% for a point like robot using potential fields 


function [x] = goToObst(xg);


x0 = [50; 50];   % initial pose is set

t = 1;
% initial position
x(1,t) = x0(1); 
x(2,t) = x0(2);

% obstacles are set
xo(:,1) = [40; 30]; 
xo(:,2) = [70; 40];

% you can experiment with different intial positions
radius = 5;                       % radius of obstacle 
goal_rad = 0.5;                   % radius of the goal
delta = 3;                        % sensitivity zone when to start avoiding
kr = 10;

[xc1,yc1] = plot_circle(xo(1,1), xo(2,1), radius);
[xc2,yc2] = plot_circle(xo(1,2), xo(2,2), radius);
plot(xc1,yc1);
plot(xc2,yc2);

  
  
stopFlag = 0; 
while (~stopFlag) % not in the vicinity of the goal
  % compute and add all repulsive components from each obstacle
  rep = zeros(2,size(xo,2)); attr=[0;0];
  for i=1:size(xo,2);    % for each obstactle 
      % distance from the obstacle
      r = norm(x(:,t) - xo(:,i)) - radius; 
      if r <= (radius+delta)       
         rep(:,i) = 10*(1/r - 1/(radius+delta))*(1/r^2)*((x(:,t)-xo(:,i))/r)
      else
          rep(:,i) = [0;0];
      end
  end	
  % compute attractive potential field
  goal_dist =  norm(x(:,t) - xg);
  if goal_dist > goal_rad
     attr = -(x(:,t) - xg)/goal_dist
  else
     attr = [0 0]'; 
  end 

  vfield = (sum(rep,2)+attr)
  xx = x(:,t)
  t = t+1;
  % simulate the point like robot one step forward
  
  x(:,t) = x(:,t-1) + vfield; 
  xxx = x(:,t)
  error = norm(xg - x(:,t));
  if error < 1
        stopFlag = 1;
  end
end


