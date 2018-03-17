% test file

%test calc_diff function%
tic;

save_data=true;

addpath(genpath(pwd))
costf='F2';
nvar=1000;
range=100;
LB = -range*ones(nvar,1);
UB = range*ones(nvar,1);
max_FEs = 3e6;

times = 1;
result = zeros(times,1);
min_state = 0;
min_res = inf;
avg_cache=[];
t1 = clock;
for i = 1:times
clear pso;
disp(['run ',costf,' ',num2str(i),' times !']);
randstate = etime(clock ,t1);
rand('state',randstate);

[best, cache_fit,FEs,diff]= cc_gdg_pso(costf,nvar,LB,UB,max_FEs);
if isempty(avg_cache)
    avg_cache = zeros(size(cache_fit));
end
avg_cache = avg_cache+cache_fit;
result(i) = best.cost;
% server task
    if  best.cost<min_res
        min_res = best.cost;
        min_state = randstate;
        %if save_data
            %save([costf,'_diff.mat'],'diff');
            %save([costf,'_best.mat'],'best');
            %save([costf,'_cache_fit.mat' ],'cache_fit');
        %end
    end
end

avg_cache = avg_cache/times;
if save_data
    save([costf,'result.mat'],'result');
    save([costf,'min_fit.mat'],'min_res');
    save([costf,'avg_fit.mat'],'avg_cache');
end
t2 = clock;
disp(['avg run time:',num2str(etime(t2,t1)/times)]);
disp('best f is');
disp(min_res);

%x= 1:size(avg_cache,1);
semilogy(avg_cache);
saveas(gcf,[costf,'.jpg']);
