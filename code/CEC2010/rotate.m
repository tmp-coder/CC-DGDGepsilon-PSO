function vec=rotate(x)
% vec = X*M
%  M is a orthogonal matrix
D = size(x,1);
M = rand(D,D);
M = orth(M);
vec = x*M;