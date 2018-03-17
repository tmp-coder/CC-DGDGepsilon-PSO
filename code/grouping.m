function ret = grouping(labels)

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
sep_sz = 64; % const sep group size;
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
ret = groups;
% import py.processGroup.*;
% s = sum(groups,2);
% pri = py.list();
% for i =1: size(s,1)
%     pri.append(s(i));
% end
% idx = solve(pri,sep_sz);
% ret = false(int64(py.len(idx)),size(groups,2));
% for i = 1:int64(py.len(idx))
%     for j =1:int64(py.len(idx{i}))
%         ret(i,:) = ret(i,:) | groups(int64(idx{i}{j}),:);      
%     end
% end

