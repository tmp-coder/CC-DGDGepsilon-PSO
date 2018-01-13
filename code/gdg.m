function [ FEs, DeltaMtx] = gdg(fname, D, LB, UB, epsilon)

% 需要修改

FEs = 0;
% % Randomly sample 10 points
% LBmtx = repmat(LB,10,1);
% UBmtx = repmat(UB,10,1);
% samples = LBmtx+rand(10, D).*(UBmtx-LBmtx);
% fsamples = feval(fname, samples);
% threshold = min(fsamples)*epsilon; % 随机选的10个组
FEs = FEs+10;
    
temp = 0;
p1 = LB;
P1 = feval(fname, p1);
FEs = FEs+1;
P2_vec = zeros(D,1);
for i = 1:D
   p2 = p1;
   p2(i) = UB(i);
   P2_vec(i) = feval(fname, p2);
   FEs = FEs+1;
end
P3_vec = zeros(D,1);
for i = 1:D
   p3 = p1;
   p3(i) = temp;
   P3_vec(i) = feval(fname, p3);
   FEs = FEs+1;
end
DeltaMtx = zeros(D);
for i = 1:D-1
    for j = i+1:D
        p4 = p1;
        p4(i) = UB(i);
        p4(j) = temp;
        P4 = feval(fname, p4);
        FEs = FEs+1;

        delta1 = P1-P2_vec(i);
        delta2 = P3_vec(j)-P4;

        DeltaMtx(i,j) = abs(delta1-delta2);
        DeltaMtx(j,i) = DeltaMtx(i,j);
    end
end
% FE 计算次数 (D-1)*D/2 + 2D = O(D^2)
% group the variables according to the matrix
% interact_mtx = (DeltaMtx > threshold);
% 
% [labels, rts] = graph_connected_components(interact_mtx);
% % transform labels to group_idx
% group_idx = labels;
% for i = 1:max(labels)
%     groupsize = sum(labels == i);
%     if (groupsize == 1) % separable
%         group_idx(labels == i) = 0;
%         group_idx(labels > i) = group_idx(labels > i)-1;
%     end
% end   
% 
% group_num = max(group_idx);
% seps = find(group_idx == 0);
% allgroups = cell(1, group_num);
% for i = 1:group_num
%     allgroups{i} = find(group_idx == i);
% end

