function [ret,groups]=conncomp(weight)
global label;
n = size(weight,1);
label = zeros(n,1);
groups =0;
for i=1:n
    if ~label(i)
        groups = groups+1;
        conn_components(weight,i,groups);
    end
end
ret = label;
