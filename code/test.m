% test file

%test calc_diff function%

addpath(genpath(pwd))
costf = 'F4';
nvar=32;
LB = -100*ones(nvar,1);
UB = 100*ones(nvar,1);
acc_conn = 38;
max_FEs = 1e5;
[best, cache_fit1,best_epsi,ng,FEs1,diff]= cc_gdg_pso(costf,nvar,LB,UB,max_FEs,acc_conn);


[GBest,cache_fit2,FEs2] = test_pso();

% test pso function
function [GBest,cache_fit,FEs] = test_pso()

    addpath(genpath(pwd))
    costf = 'F4';
    nvar=40;
    LB = -100*ones(nvar,1);
    UB = 100*ones(nvar,1);
    groups = true(1,nvar);
    max_FEs = 1e5;
    [GBest,cache_fit,FEs] = pso(groups,max_FEs,costf,LB,UB);
    
end