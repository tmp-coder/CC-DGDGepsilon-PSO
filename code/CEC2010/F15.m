function f = F15(x)
% CEC 2010 F15
D = size(x,1);
m = ceil(D/20);
z = shift(x);
z = permutation(z);
k = ceil(D/(m));
f =0;
for i = 1:k
    f = f+ Frot_rastrigin(z((i-1)*m+1:i*m));
end
end

