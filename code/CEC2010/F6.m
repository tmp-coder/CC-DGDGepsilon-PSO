function f = F6(x)
z = shift(x);
z = permutation(z);
d = size(x,1);
m = ceil(size(x,1)/20);
t1 = Frot_ackley(z(1:m));
t2 = Fackley(z(m+1:d));
f = 1e6*t1+t2;