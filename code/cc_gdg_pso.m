function [best, cache_fit,best_epsi,ng,FEs,diff]= cc_gdg_pso(costf,nvar,LB,UB,max_FEs,accurate_ng)
% main function
% args:
%     costf: the function of evaluation
%     nvar:  the number of variable
%     LB: lower boung of variables
%     UB: upper boung of variables
%     max_FEs:  the maximum number of fitness evalutions
%     accurate_ng:   the accurate number of groups
% 
% return:
%     best:   best.pos = besx;best.cost = bestf;
%     cachefit:   fitness changes over every groups pso compute
%     best_epsi:  the best Threshold
%     ng:     the number of groups
%     FEs:    actual fitness evaluations;
%     diff:    diff matrix of variables

[diff,FEs] = calc_diff(costf,nvar,LB,UB);
[epsilong,eps_idx] = bin_search(diff,accurate_ng);

best_epsi.value =epsilong;
best_epsi.idx = eps_idx;

[labels,~] = conncomp(diff>epsilong);
groups = grouping(labels);
ng = size(groups,1);
[best,cache_fit,tmp_fe] = pso(groups,max_FEs,costf,LB,UB);
FEs = FEs + tmp_fe;
