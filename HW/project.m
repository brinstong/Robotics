function x = project(X, R, T, K)

x = K*(R*X + T*ones(1,max(size(X))));

%x(1,:)
%x(2,:)
%x(3,:)

for i=1:size(x,2)
    
    if not (isfinite(x(1,i)))
        x(1,i) = 0;
    end
    if not (isfinite(x(2,i)))
        x(2,i) = 0;
    end
    if not (isfinite(x(3,i))) || x(3,i) == 0
        x(3,i) = 1;
    end
    
   x(1,i) = x(1,i)./x(3,i);
   x(2,i) = x(2,i)./x(3,i);
   x(3,i) = x(3,i)./x(3,i);   
end

end