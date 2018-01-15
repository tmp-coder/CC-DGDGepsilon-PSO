function [epsilong,eps_idx] = bin_search(diff,ng)
% alpay binary search algorithm to fin the best epsilon satisfied the
% numberof groups nearest to ng;
% 
% args:
%     diff: diff matrix of variables
%     ng : best number of groups
% return:
%     epsilong: best threshold
%     eps_idx : the idx of epsilong 

epsi = diff(:);
epsi = [epsi;-1;inf];
epsi = sort(epsi);
left = 1;
right = size(epsi,1);

while right >left
    mid = floor((left+right)/2);
    weight = diff >epsi(mid);
    [l,g] = conncomp(weight);
    if g >= ng % threshold is too big
        right = mid-1;
    else
        left = mid+1;
    end
end

eps_idx= right+1;
epsilong = epsi(eps_idx);
