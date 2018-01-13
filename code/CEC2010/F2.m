function f = F2(x)
%F_2 = F_{rastrigin}(x) = sum_{i=1}^D[z_{i}^2-10cos(2\pi z_i)+10]
% D: dim of x
D = size(x,1)
sqrt = x.^2;
sec_term = -10*cos(2*pi*x);
f = sum(sqrt+sec_term)+10*D;
