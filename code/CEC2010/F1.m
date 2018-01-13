function f = F1(x)

% F1 = F_{elliptic}(x)
d = size(x,1);
tmp = zeros(d,1);
const = 1e6;
for i=1:d
    tmp(i) = const^((i-1)/(d-1));
end
f = sum(tmp.*(x.^2));
