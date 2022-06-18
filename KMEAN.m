%% Clear the workspace
clc
clear all
close all
time_km = tic;
%% Load the path to the Extract dataset
path = 'C:\Users\s347520\OneDrive - Cranfield University\Desktop\Image-Clustering-master\Image-Clustering-master\';
cd (path)
imgDir = '\data\images\test\';
gtDir_test = '\data\groundTruth\test\'; 
D= dir(fullfile([path imgDir],'*.jpg')); 

%%
for k = 1:200
    
    GT = load([path gtDir_test D(k).name(1:end-4) '.mat']);
    GT_seg = double(GT.groundTruth{3}.Segmentation);
    LHS = [321 481];
    
    RHS = size(double(GT.groundTruth{3}.Segmentation));
    
    if LHS==RHS
        segments1(:,:,k) = double(GT.groundTruth{3}.Segmentation);
    else
        GT_resize = imresize((GT.groundTruth{3}.Segmentation),[321 481]);
        segments1(:,:,k) = double(GT_resize);
    end
    % Load Image
    a1 = imread ([path imgDir D(k).name(1:end-4) '.jpg']);
    IMG = Pix(a1);
    im = IMG;
    im1 = double(IMG);
    
    % Reshape the Image
    im2 = reshape(im,[size(im,1)*size(im,2) 3]);
    %[height,width,frame] = size(im);
    % Image Size
    Img_size = size(im);
    
    % Seperate RGB pixels into individual list
    X1 = [];
    X2 = [];
    X3 = [];
    for i=1:Img_size(2)
        X1 = [X1;im1(:,i,1)];
    end
    
    for i=1:Img_size(2)
        X2 = [X2;im1(:,i,2)];
    end
    
    for i=1:Img_size(2)
        X3 = [X3;im1(:,i,3)];
    end
    
    % RGB pixel dataset
    X = [X1 X2 X3];
    max_Iter = 500;
% %     % Loop to find optimal K value
%     for cluster_Number=3
%         max_Iter = 500;
%         % Calculating clusters and silhouette co-efficent 
%         [Clust] = k_mean_function(im2,cluster_Number, max_Iter);
%         Sil(:,cluster_Number) = silhouette(X,Clust);
%         
%     end
% %     
%     %Find Optimal Number of Cluster K
%     [K_opt,S,K_mat] = Opt_K(Sil);
%     
%     % Plot Average Silhoutte Width v/s Number of cluster to varifiy Optimal Number of Cluster
%     figure
%     plot([0 K_mat],[0 S])
%     hold on
%     xline(K_opt,'g--')
%     xlabel('Cluster Number')
%     ylabel('Average Silhoutte Width')
%     title('Optimal Number of Cluster')
%     xlim([0 7])
%     ylim([0 1])
%     leg = sprintf('K_optimal = %d',K_opt);
%     legend(leg)
%     hold off
    % Cluster indices of each pixel and matrix containing the k cluster centroid locations.
     [Clust_map,centroid,DD] = k_mean_function(im2,3, max_Iter);

    
%     % Plot Average Silhoutte Co-efficent v/s Number of cluster
%     figure
%     silhouette(X,Clust_map)
%     hold on
%     xline(mean(S),'r--')
%     title(' Silhoutte Co-efficient')
%     leg2 = sprintf('Avg Sil Coefficent = %.2f',mean(S));
%     legend('',leg2)
%     hold off

    % Reshape the clustered Pixel into original image size
    cmap2 = reshape(Clust_map, [size(im,1) size(im,2)]);
    M = centroid / 255;
    
    % Final Segmented Image 
    Segmented_Image = label2rgb(cmap2,M);
    
    Gray = im2gray(Segmented_Image);
    
    if [321 481] == size(Gray)
        Seg(:,:,k) = Gray;
    else
        Gray_Resize = imresize(Gray,[321 481]);
        Seg(:,:,k) = Gray_Resize;
    end
    
%   plot both original image and segmented image 
    figure
    subplot(211)
    imshow(a1)
    title('Original Image')
    axis equal
    
    subplot(212)
    imshow(Segmented_Image)
    title('Segmented Image (K-mean)')
    axis equal
   
    

    % Pixel distribution in RGB co-ordinate.
    p = double(a1);
    q = double(Segmented_Image);

    
    sample = zeros(size(p,1),size(p,2));
    sample(1:3:end,1:3:end) = 1;
    
    R = p(:,:,1); Rx = R(sample==1); Rn = randn( numel(Rx),1 )/3;
    G = p(:,:,2); Gx = G(sample==1); Gn = randn( numel(Rx),1 )/3;
    B = p(:,:,3); Bx = B(sample==1); Bn = randn( numel(Rx),1 )/3;
    figure
    subplot(221), imshow(uint8(p)), axis image; title('Original image')
    subplot(223), imshow(uint8(q)), axis image; title('Segmented image (K-mean)')
    subplot(222)
    scatter3( Rx(:)-Rn, Gx(:)-Gn, Bx(:)-Bn, 25, [ Rx(:), Gx(:), Bx(:) ]/255 );
    title('Pixel Distribution Before K-mean Clustering')
    xlim([0,255]),ylim([0,255]),zlim([0,255]);
    axis square
    xlabel('R')
    ylabel('G')
    zlabel('B')
    
    R = q(:,:,1); Ry = R(sample==1); Rn = randn( numel(Rx),1 )/3;
    G = q(:,:,2); Gy = G(sample==1); Gn = randn( numel(Rx),1 )/3;
    B = q(:,:,3); By = B(sample==1); Bn = randn( numel(Rx),1 )/3;
    subplot(224)
    scatter3( Ry(:)-Rn, Gy(:)-Gn, By(:)-Bn, 45, [ Rx(:), Gx(:), By(:) ]/255 );
    title('Pixel Distribution After K-mean Clustering')
    xlim([0,255]),ylim([0,255]),zlim([0,255]);
    axis square
    colormap(M)
    colorbar
    xlabel('R')
    ylabel('G')
    zlabel('B')
    
end

T_km = toc/100;
% save 1.mat