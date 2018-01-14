function groups = grouping(labels)

% grouping according to labels vector
% args:
%   labels: indicated variavle x_i belong to the components labels(i)
% return:
%   groups: a matrix,every vector indicates  a group with indicative vector
%   [0,....,1]

group_idx = labels;
for i = 1:max(labels)
    groupsize = sum(labels == i);
    if (groupsize == 1) % separable
        group_idx(labels == i) = 0;
        group_idx(labels > i) = group_idx(labels > i)-1;
    end
end
nNonSep = max(group_idx); % Nonseperabel group size
nsep = sum(group_idx ==0); % num of seperable variable;
seps = find(group_idx==0); % seperable group;
sep_sz = 32; % const sep group size;
nGroups = nNonSep+ceil(nsep/sep_sz); % ngroups
groups = false(nGroups,max(size(labels)));
for i = 1:nNonSep
    groups(i,:) =group_idx==i; 
end

g = nNonSep+1;
for i = 1:nsep
    groups(g,seps(i)) = true;
    if mod(i,sep_sz) == 0 
        g=g+1;
    end
end

