function f = F4(x)
%single-group shifted and m-rotate elliptic function
D = size(x,1);
m = ceil(D/20); 
z = shift(x);
z = permutation(z);
f = 1e6* F_rot_elliptic(z(1:m))+ Felliptic(z(m+1:D));