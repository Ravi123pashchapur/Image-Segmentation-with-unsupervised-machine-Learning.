%% Mean Shift Algorithm function
function [Seg no_clusters,aaa,centres_clusters,hs,hr] = mean_shift_function(IMG,height,width)
    
    % Spatial bandwidth
    hs = 16; 
    % Range bandwidth
    hr= 18;  
    % Threashold mean
    threshold_convergence_mean = 0.25;
    
    % Bandwidth
    bandwidth=[hs,hr];
    x=zeros(5,height*width);
    % Going from RGB space to Luv using the function RGB2LUV
    for j=1:height
        for l=1:width
            x(1,l+width*(j-1)) = j;
            x(2,l+width*(j-1)) = l;
            [x(3,l+width*(j-1)),x(4,l+width*(j-1)),x(5,l+width*(j-1))] = RGB2LUV(IMG(j,l,1),IMG(j,l,2),IMG(j,l,3));
        end
    end
    
    % finding the clusters  and plotting the clusters with their data points
    
    [centres_clusters,data2cluster,datapoints_cluster_no] = mean_s(x,bandwidth,threshold_convergence_mean);
    
    % Number of cluster
    no_clusters = length(datapoints_cluster_no);
    
    % Data point cluster number
    aaa = datapoints_cluster_no;
    
    % Creating a 3-D RGB matrix and then plotting the 3-D matrix to get the segmented image
    [h2,w2] = size(centres_clusters);
    zfilter=zeros(5,height*width);
    for i12=1:w2
        mem=datapoints_cluster_no{i12,1};
        p1=size(mem);
        
        for s1=1:p1(1,2)
            zfilter(:,mem(s1))=centres_clusters(:,i12);
        end
    end
    zluv(:,:,1)=(reshape(zfilter(3,:),width,height))';
    zluv(:,:,2)=(reshape(zfilter(4,:),width,height))';
    zluv(:,:,3)=(reshape(zfilter(5,:),width,height))';
    zrgb = colorspace('Luv->RGB',zluv);
    zrgb1=round(zrgb*255);
   
    Seg = zrgb;
    

    
    

end