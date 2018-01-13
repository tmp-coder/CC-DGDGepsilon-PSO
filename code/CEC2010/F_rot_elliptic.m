function f = F_rot_elliptic(x)
D = size(x,1);
x = rotate(x);
f = Felliptic(x);