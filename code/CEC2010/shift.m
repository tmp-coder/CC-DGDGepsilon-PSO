function vec = shift(x)

% shift transform
persistent o; % shifted center,Prevent the value of rot matrix in the iteration processing changes.

if isempty(o)
    sz = size(x);
    o = normrnd(0,1,sz);
end
vec = x - o;