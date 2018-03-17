function [GB,cache_fit,FEs] = pso(groups,max_FEs,costf,LB,UB,runAllIter)
% args:
%     groups: the group of variables
%     max_FEs: the maximum number of fitness evaluations
%     costf:  cost function
%     LB : lower_bound of x(i)
%     UB:   upper_bound of x(i)
%     runAllIter: std pso,run all Iters
% return:
%     bestf: best function value
%     bestx: argmin_{x} f
%     cache_fit:  fitness value of every itration
%     FEs: consume number of fitness evaluations
%     

global printFlag;

%% PSO Parameters
ng = size(groups,1);
nPop = 25; % number of paticles
constMaxIter = 2000;% if want to run std pso ,u should change constMaxIter=inf;
if runAllIter
    constMaxIter = inf;
end
maxIter = ceil(max_FEs/nPop/ng);
maxIter = min(constMaxIter,maxIter);

% w=1;            % Inertia Weight
% wdamp=0.999;     % Inertia Weight Damping Ratio
% c1=1.5;         % Personal Learning Coefficient
% c2=2.0;         % Global Learning Coefficient

% If you would like to use Constriction Coefficients for PSO,
% uncomment the following block and comment the above set of parameters.
% 
% Constriction Coefficients
phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
c1=chi*phi1;    % Personal Learning Coefficient
c2=chi*phi2;    % Global Learning Coefficient
 
% Velocity Limits
VUB=0.1*(UB-LB);
VLB=-VUB;

persistent GBest;
persistent cnt;
if isempty(GBest)
    GBest.pos=[];
    GBest.cost = inf;
    cnt =0;
end

%% initialization

% template particle class
template_particle.best.pos=[];% pbest
template_particle.best.cost=inf;
template_particle.pos=[];   % now position
template_particle.cost=[];  % now cost
template_particle.velocity=[];  % now velocity

%template group class
template_group.pos =[];
template_group.var =[];
template_group.varsz=[];
template_group.varlb =[];
template_group.varub =[];
template_group.vlb =[];
template_group.vub =[];
template_group.par = repmat(template_particle,nPop,1);


% init return value

FEs = 0;
group = repmat(template_group,ng,1);

% init group
for i=1:ng
    group(i).var = groups(i,:);
    group(i).varsz = [sum(group(i).var),1];
    group(i).varlb = LB(group(i).var);
    group(i).varub = UB(group(i).var);
    group(i).vlb = VLB(group(i).var);
    group(i).vub = VUB(group(i).var);
end

% init parameter

for i=1:nPop
    tmppos=[];
    if ~cnt
        tmppos = unifrnd(LB,UB);
    else
        scaler = 0.01;
        if mod(i,3)==0
            scaler = scaler*2;
        elseif mod(i,3)==2
            scaler = scaler*6;
        end
        
        tmppos = normrnd(GBest.pos,(UB(1)-LB(1))*scaler,size(GBest.pos));
        if mod(i,3)==1
            tmppos = unifrnd(LB,UB);
        end
        tmppos = max(tmppos,LB);
        tmppos = min(tmppos,UB);
    end
    cost = feval(costf,tmppos);
    FEs= FEs+1;
    if cost < GBest.cost
        GBest.cost = cost;
        GBest.pos = tmppos;
    end
    for j = 1:ng
        group(j).par(i).pos =tmppos(group(j).var);
        group(j).par(i).best.pos = group(j).par(i).pos;
        group(j).par(i).cost = cost;
        group(j).par(i).best.cost = cost;
        group(j).par(i).velocity = zeros(group(j).varsz);
    end
end

for i=1:ng
    group(i).pos=  GBest.pos(group(i).var);
end


%% main loop

cache_fit = zeros(floor(maxIter/100),1);
for i = 1: maxIter
    for j =1 : ng
        for k = 1:nPop
            % update velocity
            group(j).par(k).velocity = w*group(j).par(k).velocity ...
                +c1*rand(group(j).varsz).*(group(j).par(k).best.pos - group(j).par(k).pos) ...
                +c2*rand(group(j).varsz).*(group(j).pos - group(j).par(k).pos);
           
            % aplay velocity limit
            group(j).par(k).velocity = max(group(j).par(k).velocity,group(j).vlb);
            group(j).par(k).velocity = min(group(j).par(k).velocity,group(j).vub);
            
            % update position
            group(j).par(k).pos = group(j).par(k).pos + group(j).par(k).velocity;
            
            % velocity mirror effect
            isout = (group(j).par(k).pos < group(j).varlb |group(j).par(k).pos>group(j).varub);
            group(j).par(k).velocity(isout) = - group(j).par(k).velocity(isout);
            
            % aplay position limit
            group(j).par(k).pos = max(group(j).par(k).pos,group(j).varlb);
            group(j).par(k).pos = min(group(j).par(k).pos,group(j).varub);
            
            % compute cost
            tmpx = GBest.pos;
            tmpx(group(j).var) = group(j).par(k).pos;
            group(j).par(k).cost = feval(costf,tmpx);
            FEs = FEs+1;
            
            % update pbest
            if group(j).par(k).cost < group(j).par(k).best.cost
                group(j).par(k).best.cost = group(j).par(k).cost;
                group(j).par(k).best.pos = group(j).par(k).pos;
                
                % update group gbest
                if group(j).par(k).best.cost < GBest.cost
                    group(j).pos = group(j).par(k).best.pos;
                    % update global best
                    GBest.cost = group(j).par(k).best.cost;
                    GBest.pos(group(j).var) = group(j).pos;
                end
            end
        end
    end
    w = w*wdamp;
    if mod(i,100)==0
        if printFlag
            disp(['iter ',num2str(i),'cost = ',num2str(GBest.cost)])
        end
            %disp('velocity')
%         group(randi([1,ng])).par(randi([1,nPop])).velocity
        cache_fit(ceil(i/100)) = GBest.cost;     
    end
end
cnt = cnt+1;
GB=GBest;

