clc
clear all

%% Load the path to the Extract dataset
path = 'C:\Users\s347520\OneDrive - Cranfield University\Desktop\Image-Clustering-master\Image-Clustering-master\';
cd (path)
imgDir = '\data\images\test\';
gtDir_test = '\data\groundTruth\test\'; 
D= dir(fullfile([path imgDir],'*.jpg')); 

%%
time_ms = tic;
for k = 1:200
  
    GT = load([path gtDir_test D(k).name(1:end-4) '.mat']);
    % plotting preparations, assuming max 6 segmentations, frequently there
    % are 5
    
    segments = double(GT.groundTruth{1}.Segmentation);
%     figure
%     imagesc(segments)
%     title(num2str(k))
     
    % Load Image
    im_1 = imread ([path imgDir D(k).name(1:end-4) '.jpg']);
    IMG = (im_1);
   
    % Extract Height width and frame from Image
    [height,width,frame] = size(IMG);
    
    % Calculation to opt segmented Image
    [s nc aa bb hs hr] = mean_shift_function(IMG,height,width);
    
    % Display images
    figure
    subplot(211)
    imshow(IMG)
    title('Original Image')
    
    subplot(212)
    imshow(s)
    title(['Segmented Image(Mean-shift) (hs,hr)=',num2str(hs),',',num2str(hr)]);
   
    Gray = im2gray(s);
    
    if [321 481] == size(Gray)
        seg(:,:,k) = Gray;
    else
        Gray_Resize = imresize(Gray,[321 481]);
        seg(:,:,k) = Gray_Resize;
    end
  
    
    
end

T_ms = toc/100;
% save 2.mat