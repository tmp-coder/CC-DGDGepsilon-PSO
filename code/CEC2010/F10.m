function f = F10( x )
%UNTITLED2 rotate rastrigin,CEC F10

D = size(x,1);
m = ceil(D/20);
z = shift(x);
z = permutation(z);
k = ceil(D/(2*m));
f =0;
for i = 1:k
    f = f+ Frot_rastrigin(z((i-1)*m+1:i*m));
end
f = f+ Frastrigin(z(k*m+1:D));

end

