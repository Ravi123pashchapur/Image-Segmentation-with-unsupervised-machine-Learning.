%% Kmean Agorithm
function [cmap,V,D] = k_mean_function(im, clusterNo, maxIter)


% Pixel Number evaluation
[pixelNo,~] = size(im);

% Randomly choosing of k samples as the initial cluster centers
rand_points = randperm(pixelNo,clusterNo);

centers = double(im(rand_points,:));

% Distance matrix
D = zeros(clusterNo,pixelNo);

% Partition the pixels of image into the clusters

for iter=1:maxIter
    
    % Calculate eucledian distance
    D = pdist2(centers,double(im));
    
    % Find each pixels' cluster by looking minimum distance values
    [~,min_indices] = min(D);
    
    % Update the cluster centers
    old_centers = centers;
    for j=1:clusterNo
        centers(j,:) = mean(im(min_indices == j,:));
    end
    
    % Check the convergence
    if sum(sum(abs(old_centers-centers))) == 0
        disp(['Centers converged in ' num2str(iter) ' iteration.' ]);
        break;
    end
end

if iter == maxIter
    disp(['Centers could not converged in ' num2str(maxIter) ' iteration.' ]);
end

% Cluster indices of each pixel.
cmap = min_indices';

% k cluster centroid locations.
V = centers;
end