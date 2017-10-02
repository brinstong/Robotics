% simulates the differential drive robot for t time units 
function [x,y,theta] = diffDrive(xi,v,omega,tmax)
x(1) = xi(1); y(1) = xi(2); theta(1) = xi(3);
deltat = 0.05;
for t=1:tmax
    x(t+1) = x(t) + v*deltat*cos(theta(t));
    y(t+1) = y(t) + v*deltat*sin(theta(t));
    theta(t+1) = theta(t) + omega*deltat;
end
