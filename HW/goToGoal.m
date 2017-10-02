% goal reaching controler for differential drive 
% assuming point point mass robot
% and current and goal position, generate linear 
% velocity vector x', y'


function [xdot] = goTo(x,xg);

v0 = 1;
e = xg-x;
alpha = 1; 
K = v0*(1-exp(-alpha*(norm(e))^2))/norm(e);
xdot = K*e; 





