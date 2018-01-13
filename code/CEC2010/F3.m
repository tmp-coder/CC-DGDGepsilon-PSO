function f = F3(x)
% F3= F_{ackley}(x) = -20exp(-0.2\sqrt{\frac{1}{D}\sum(z_i^2)}) -
% exp(\frac{1}{D}\sum_{cos(2piz_i)})+20+e
% 
%   e = euler const
%   D:dim of x
D = size(x,1);
sum_sqr = sum(x.^2);
sum_cos = sum(cos(2*pi*x));
f = -20*exp(-0.2*sqrt(sum_sqr/D)) - exp(sum_cos/D)+20+exp(1);