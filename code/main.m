% test file

%test calc_diff function%
clear shift;clear permutation;clear rotate;clear pso;
tic;
% running parameter
mode = 1;% 1: dynamic grouping,2:fixed grouping
save_data=false;
global printFlag;
printFlag = true;
addpath(genpath(pwd));

% function parametet
costf='F4';
nvar=1000;
range=100;
LB = -range*ones(nvar,1);
UB = range*ones(nvar,1);
max_FEs =3e6;

times = 1;
result = zeros(times,1);
avg_cache=[];
t1 = clock;
for i = 1:times
    clear pso;
    disp(['run ',costf,' ',num2str(i),' times !']);
    randstate = toc+rand()*10;
    rand('state',randstate);
    if mode==1
        [best, cache_fit,FEs,diff]= cc_gdg_pso(costf,nvar,LB,UB,max_FEs);
    elseif mode==2
        [best, cache_fit,FEs,diff]= cc_fgdg_pso(costf,nvar,LB,UB,max_FEs);
    end
    
    if isempty(avg_cache)
        avg_cache = zeros(size(cache_fit));
    end
    avg_cache = avg_cache+cache_fit;
    result(i) = best.cost;
end

avg_cache = avg_cache/times;
 if save_data
    save(['../result/',costf,'result.mat'],'result');
%     save([costf,'min_fit.mat'],'min_res');
    save(['../result/',costf,'avg_fit.mat'],'avg_cache');
 end
t2 = clock;
disp(['avg run time:',num2str(etime(t2,t1)/times)]);
[mi,med,avg,st ]= processData(result);
disp(['the min,median,mean,std,of function ',costf,]);
disp([num2str(mi),' ',num2str(med),' ',num2str(avg),' ',num2str(st)]);
semilogy(avg_cache);
if save_data
    saveas(gcf,['../curve/',num2str(mode),costf,'.jpg']);
end
