function f = F5(x)
%single-group shifted and m-rotate Rastrigin's function
D = size(x,1);
m = ceil(D/20); 
z = shift(x);
z = permutation(z);
t1 = Frot_rastrigin(z(1:m));
t2 = Frastrigin(z(m+1:D));
f = 1e6*t1+t2;