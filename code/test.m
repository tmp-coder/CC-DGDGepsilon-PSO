% test file

%test calc_diff function%

addpath(genpath(pwd))
fname = 'F4';
D=40;
LB = -100*ones(D,1);
UB = 100*ones(D,1);
epsilon = 1e-10;
[diff,FEs] = calc_diff(fname,D,LB,UB);
[fes,delta] = gdg(fname,D,LB,UB);
assert(isequal(delta,diff),'err: some bug in function calc_diff');

epsi = sort(diff(:));
%%test conncomp function%
% weight = rand(4,4) >0.9
% weight = weight+weight';
% weight = weight>=1;
% for i = 1:4
%     weight(i,i)=0
% end
% [label,groups] = conncomp(weight);
% label
% groups