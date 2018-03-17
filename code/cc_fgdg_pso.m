function [best, cache_fit,FEs,diff] = cc_fgdg_pso(costf,nvar,LB,UB,maxFEs)
% fixed gdg
global printFlag;
[diff,FEs] = calc_diff(costf,nvar,LB,UB);
epsilon = 1e-10;
samples = unifrnd(LB(1),UB(1),nvar,10);
res = zeros(10,1);
for i = 1:10
    res(i) = feval(costf,samples(:,i));
end
thre = epsilon*min(res);
FEs = FEs +10;
[labels,ng] = conncomp(diff>thre);

disp(['epsilong is ',num2str(thre),' cnn components is ',num2str(ng)])

groups = grouping(labels);
[best,cache_fit,tmpFE] = pso(groups,maxFEs-FEs,costf,LB,UB,true);
FEs = FEs + tmpFE;

end

