function conn_components(weight,root,cnt)
% the auxiliary function of compute all connected components of a undirected graph
% args:
%     weight: incidence matrix
%     root : search root
%     cnt  : counts the components
% return:
%     global variable label,label [1,1,1,...,1,2,..,4] 
global label;
n = size(weight,1);
label(root) = cnt;
for i = 1:n
    if weight(root,i) && ~label(i)
        conn_components(weight,i,cnt);
    end
end
    
