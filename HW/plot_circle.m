function [x,y] = plot_circle(xc,yc,radius)

t = linspace(0,2*pi,1000);  
x = radius*cos(t)+xc;                   
y = radius*sin(t)+yc;                   

