
% http://matlaboratory.blogspot.nl/2015/05/alternative-function-normpdf.html

function y = normpdf2(x, mu, sigma)

f = @(u,o,x) 1/sqrt(2*pi*o^2) * exp(-(x-u).^2 / (2*o^2));

y = feval(f, mu, sigma, x);

end