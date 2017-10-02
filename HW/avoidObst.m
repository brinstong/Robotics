function [xdot] = avoidObst(x,xo);

e = x-xo
epsilon = 1; 
c = 0.1;
K = (1/norm(e))*(c*(1/norm(e)^2 + epsilon));

if norm(e) < 25
xdot = K*e;
else
    xdot = 0; 
end

