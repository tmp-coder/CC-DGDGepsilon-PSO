function f = F11( x )

%UNTITLED2 rotate ackley,CEC F11

D = size(x,1);
m = ceil(D/20);
z = shift(x);
z = permutation(z);
k = ceil(D/(2*m));
f =0;
for i = 1:k
    f = f+ Frot_ackley(z((i-1)*m+1:i*m));
end
f = f+ Fackley(z(k*m+1:D));

end
