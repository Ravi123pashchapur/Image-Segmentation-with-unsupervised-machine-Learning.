load 1.mat
load 2.mat

A = im2gray(s);
B = im2gray(Segmented_Image);

% Gray scale Mean shift segmented Image
figure
imshow(A)
title('Gray scale Mean shift segmented Image')

% Gray scale K mean segmented Image
figure
imshow(B)
title('Gray scale Mean shift segmented Image')

% Mean Shift Edge 
figure
edge(A,'canny')
title('Meanshift Edge')

% K mean Edge
figure
edge(B,'canny')
title('K mean Edge')
