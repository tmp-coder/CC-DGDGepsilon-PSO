function f = Fschwefel( x )
% schwefel function
s = cumsum(x);
f = sum(s.^2);
end

