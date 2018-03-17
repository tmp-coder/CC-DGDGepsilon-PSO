% test std pso
tic;
t1 = clock;
[GBest,cache_fit2,FEs2] = test_pso();

disp('GBest:');
GBest

t2 = clock;
disp(['standard pso runtime: ',num2str(etime(t2,t1))]);
% test pso function
function [GBest,cache_fit,FEs] = test_pso()

    addpath(genpath(pwd))
    costf = 'F5';
    nvar=1000;
    LB = -100*ones(nvar,1);
    UB = 100*ones(nvar,1);
    groups = true(1,nvar);
    max_FEs = 3e6;
    [GBest,cache_fit,FEs] = pso(groups,max_FEs,costf,LB,UB,true);
end
