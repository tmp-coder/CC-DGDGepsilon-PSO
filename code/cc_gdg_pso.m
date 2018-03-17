function [best, cache_fit,FEs,diff]= cc_gdg_pso(costf,nvar,LB,UB,maxFEs)
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
% load diff.mat;
% FEs=0;
epsilon = sort(diff(:));
epsilon = unique(epsilon);
maxInterval = 3;
num = size(epsilon,1);
k = ceil(num/maxInterval);
now=num;
cache_fit=[];
%last_ng = 0;
maxFEs = maxFEs-FEs;
while maxFEs >0
    now = max(1,now);
    runIter = false;
    [labels,ng] = conncomp(diff>epsilon(now));
    groups = grouping(labels);
    disp(['epsilong = ',num2str(epsilon(now)),' number of conmponents ',num2str(ng),' groups ',num2str(size(groups,1))]);
    [tmpGB,tmpfit,tmpFE] = pso(groups,maxFEs,costf,LB,UB,runIter);
    best =tmpGB;
    disp(['Gbest = ',num2str(best.cost)]);
    maxFEs = maxFEs-tmpFE;
    FEs = FEs+tmpFE;
    now = now-k;
    cache_fit = [cache_fit;tmpfit];
end
