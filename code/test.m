diff = rand(1000,1000); 
[labels,ng] = conncomp(diff>0.999);
 g = grouping(labels);