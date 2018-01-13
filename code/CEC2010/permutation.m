function z = permutation(x)
% generate a random permutation p,and return z = x[p_1:p_m];
persistent p;
if isempty(p)
    D = size(x,1);
    p = randsample(D,D);
end
z =zeros(size(x));
for i = 1:size(x,1)
    z(i) = x(p(i));
end