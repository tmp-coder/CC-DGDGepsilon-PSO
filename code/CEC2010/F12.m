function f = F12( x )

%UNTITLED2 rotate schwefle,CEC F12

D = size(x,1);
m = ceil(D/20);
z = shift(x);
z = permutation(z);
k = ceil(D/(2*m));
f =0;
for i = 1:k
    f = f+ Fschwefel(z((i-1)*m+1:i*m));
end
f = f+ Fsphere(z(k*m+1:D));

end

