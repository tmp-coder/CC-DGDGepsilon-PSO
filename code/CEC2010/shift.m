function vec = shift(x)

% shift transform
persistent o; % shifted center,Prevent the value of rot matrix in the iteration processing changes.

if isempty(o)
    D = size(x,1);
    o = normrnd(0,1,D,1);
end
vec = x - o;