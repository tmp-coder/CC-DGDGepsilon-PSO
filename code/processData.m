function [mi,med,avg,st] = processData( res )
mi = min(res);
med = median(res);
avg = mean(res);
st = std(res);
end

