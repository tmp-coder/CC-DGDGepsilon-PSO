function f = F8( x )

%single-group shifted and m-rotate Rosenbrock's function
z = shift(x);
z = permutation(z);
D = size(x,1);
m = ceil(D/20);
f = 1e6*Frosenbrock(z(1:m))+Fsphere(z(m+1:D));
end

