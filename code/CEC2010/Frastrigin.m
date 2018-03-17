function f = Frastrigin(x)
D = size(x,1);
squre = x.^2;
cos_vec = cos(2*pi*x);
f = sum(squre) - 10*sum(cos_vec)+10*D;