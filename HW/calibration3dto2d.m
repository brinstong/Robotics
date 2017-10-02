function [K,R,T] = calibration3dto2d(X, x);

% given 3D coordinates and their projections compute 
% the 3x4 projection matrix and factor it to R, K, and T

nc = size(X, 2);
X = [X; ones(1,nc)];
A = [];
for k = 1:nc
 A = [A; X(:,k)' 0 0 0 0 -x(1,k)*X(:,k)';
         0 0 0 0 X(:,k)' -x(2,k)*X(:,k)'];
end;

[u,s,v] = svd(A);
Ps = v(:,12);
Pi = reshape(Ps,4,3)';
[tempR,tempK] = qr(inv(Pi(1:3,1:3)));

scale = tempK(3,3);
tempK = tempK/tempK(3,3);
if tempK(1,1) < 0 
    tempR = tempR*[-1 0 0; 0 -1 0; 0 0 1];
    tempK = [-1 0 0; 0 -1 0; 0 0 1]*tempK;
end;
    
R = tempR';
K = tempK;
T = scale*inv(tempK)*Pi(:,4);


        
