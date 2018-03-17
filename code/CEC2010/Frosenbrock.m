function f = Frosenbrock(x)
%  rosenbrock's function
D = size(x,1);
sqr = x.^2;
t1 = 100*sum((sqr(1:D-1)-x(2:D)).^2);
t2 = sum((x(1:D-1)-1).^2);
f = t1+t2;
end

