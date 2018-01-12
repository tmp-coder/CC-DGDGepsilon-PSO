function [diff,FEs] = calc_diff(fname,D,LB,UB)
% args:
%     fname: function name
%     D:     dim of input vector
%     LB:    lower bound vector of every variable, s.t lb[i] <= x_i
%     UB:    upper bound vector of every variable, s.t x_i <= ub[i]
% return:
%     diff: mat of Delta1-Delta2
%     FEs : the number of fitness evaluations

% init parameters%

diff = zeros(D,D);
FEs = 0;

% calculate diff matrix %

x=LB;
F1 = feval(fname,p1);
FEs = FEs+1;
F2_vec = zeros(1,D);
F3_vec = zeros(1,D);
for i=1:D
    x(i) = UB(i);
    F2_vec(i) = feval(fname,x);
    x(i) = 0;
    F3_vec(i) = feval(fname,x);
    x(i) = LB(i);% recover the raw value
    FEs = FEs+2
end

for i = 1: D-1
    delta1 = F1 - F2(i);
    x(i) = UB(i);
    for j = i+1:D
        x(j) = 0;
        F4 = feval(fname,x);
        delta2 = F3_vec(j) - F4;
        diff(i,j) = abs(delta1-delta2);
        diff(j,i) = diff(i,j);
        x(j) = LB(j);
        FEs = FEs+1;
    end
    x(i) = LB(i);
end
        
        
