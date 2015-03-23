% --------------------------------------------------------------------------
% This is a matlab script to calcuate kmeans clustering processing
% NOTE: the same process in python is not feasible.
% Author: Hongwe Jin
% --------------------------------------------------------------------------

% cond from 1 - 42 and rela is relative error of each condition
X = [rela,ones(42)];
size = 3;
% kmeans clustering, NOTE: it will generate a sequence but not the exact same index
[idx, C] = kmeans(X, size);
figure('Position', [100, 100, 700, 250]);

cc = hsv(size);
% Plot each condition in different colors
for i=1:size
    plot(X(idx==i,1),X(idx==i,2),'.','color', cc(i, :),'markersize',12);
    hold on
end
% Plot marker
plot(C(:,1), C(:,2),'kx', 'MarkerSize', 12,'LineWidth', 3);
legend('Cluster 1','Cluster 2','Cluster 3', 'Centroids','Location','north','Orientation','horizontal');
title('Clustering 42 Cond. into 3 Using Kmeans Algo.', 'FontSize', 16);
xlabel('Relative Error');
set(gca,'YTick',[])
hold off
% print('clu3','-ds');