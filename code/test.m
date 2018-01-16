% test file

%test calc_diff function%
tic;
addpath(genpath(pwd))
costf = 'F4';
nvar=1000;
LB = -100*ones(nvar,1);
UB = 100*ones(nvar,1);
acc_conn = nvar-ceil(nvar/20)+1;
max_FEs = 3e6;
t1 = clock;
[best, cache_fit1,best_epsi,ng,FEs1,diff]= cc_gdg_pso(costf,nvar,LB,UB,max_FEs,acc_conn);
t2 = clock;
disp(['cc_gdg_pso run time:',num2str(etime(t2,t1))]);

save cache_fit.mat cache_fit1;
save diff.mat diff;
save best.mat best;