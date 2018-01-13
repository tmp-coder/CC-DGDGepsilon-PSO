function vec=rotate(x)
% vec = X*rot_matrix
%  rot_mat is a orthogonal matrix

persistent rot_mat; % Prevent the value of rot matrix in the iteration processing changes.
if isempty(rot_mat)
    D = size(x,1);
    M = rand(D,D);
    rot_mat = orth(M);
end
vec = (x'*rot_mat)';