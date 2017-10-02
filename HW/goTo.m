% goal reaching controler for differential drive 
% using polar parameterization
% assumes that goal is at [0 0 0] and the initial position is 
% arbitrary


function [xn,yn,thetan] = goTo(xg);

xi = [0; 0; 0];

% inverse of this transformation which will put the origin at zero
T0 = [cos(xg(3)) -sin(xg(3)) xg(1);
           sin(xg(3)) cos(xg(3))  xg(2);
           0               0        1]
       
xg_origin = inv(T0)*[xg(1); xg(2); 1];

% transfor the initial position accordingly
xi_origin  = inv(T0)*[0; 0; 1];

% transformed goal pose [x,y,theta]
xg0 = [xg_origin(1:2); 0];

% transformed initial pose
xi0 = [xi_origin(1:2); -xg(3)];


kr = 3;
kb = -1.5;
ka = 8;
t = 1; 
stopFlag = 0;
deltat = 0.05;
x(1) = xi0(1); y(1) = xi0(2); theta(1) = xi0(3);
deltaX = xg0(1)-x(t)
deltaY = xg0(2)-y(t)
deltaTh = xg(3)-theta(t);

while (~stopFlag)
    rho = sqrt(deltaX^2 + deltaY^2)
    dd1= deltaX
    dd2= deltaY
    tt1= theta(t)
    alpha = atan2(deltaY, deltaX) - theta(t)
    if abs(alpha) > pi 
        alpha = alpha - sign(alpha)*2*pi
    end;
    beta = -theta(t) - alpha
    rhot(t) = rho;
    alphat(t) = alpha;
    betat(t) = beta;
    pause
    v = kr*rho;
    omega = (ka*alpha + kb*beta)
    ot(t) = omega;
    vt(t) = v;
    if ((alpha > -pi/2) & (alpha <= pi/2)) 
        warning('forward velocity');
    else
        v = -v; 
        warning('backward velocity');
    end
    t = t+1;
    
    [xn,yn,thn] = diffDrive([x(t-1),y(t-1),theta(t-1)],v,omega,1)
    x(t) = xn(2); y(t) = yn(2); theta(t) = thn(2);
    deltaX = xg0(1)-x(t);
    deltaY = xg0(2)-y(t);
    deltaTh = xg0(3)-theta(t);
    controls = [v, omega]
    pose = [x(t) y(t) theta(t)]
    pause;
    if (abs(deltaX) < 1e-1)& (abs(deltaY) < 1e-1) & (abs(deltaTh) < 1e-1)
        stopFlag = 1
    end
end

for i=1:t
    x_transf = T0*[x(i); y(i); 1];
    xn(i) = x_transf(1); 
    yn(i) = x_transf(2);
    thetan(i) = -theta(i);
end;




