function vec = shift(x)

% shift transform
persistent o; % shifted center,Prevent the value of rot matrix in the iteration processing changes.

if isempty(o)
    sz = size(x);
    o = randi([-3,3]);% [-5,5]
    disp('optimal x:');
    o
end
vec = x - o;