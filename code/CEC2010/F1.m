function f = F1(x)

% F1 = F_{elliptic}(x)
d = size(x,1);
tmp = zeros(d,1);
const = 1e6;
assert(d>1,'err: the dim of x must bigger than 1');
for i=1:d
    tmp(i) = const^((i-1)/(d-1));
end
f = sum(tmp.*(x.^2));
