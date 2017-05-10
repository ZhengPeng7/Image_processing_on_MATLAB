clc;
clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  获取原始图像 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Read the 2nd image
originalImage = imread(strcat(pwd,'.\Leaves_UMU\07.jpg'));
% correct the image
%originalImage = RotationCorrection(originalImage);  
   %%%  righting here? it does not work all the time.
   %%%  这个扶正的函数是不匹配的，完全可以mark。
   
% Display the original image.
hFig = figure;
subplot(2, 3, 1);
imshow(originalImage, []);
axis on;
title('Original Image');
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by Xiaogang', 'NumberTitle', 'Off');

% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(originalImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = originalImage(:, :, 2); % Take green channel.
else
	% It's already grayscale.
	grayImage = originalImage;
end
%figure, imshow(grayImage);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 获取原始图像  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 消除高频噪声 获得灰度图像  %%%%%%%%%%%%%%%%%%%%%%%
% To remove higfreq.
% Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5  5],2); % 创建一个滤波器
%# Filter it
grayImageFiltered = imfilter(grayImage,G,'replicate'); % 'replicate'--超出边界的按离得最近的边界值算.
%figure, imshow(grayImageFiltered);

% Display the gray image.
subplot(2, 3, 2);
imshow(grayImage, []);
axis on;
title('Filtered grayImage Image');

%%%%%%%%%%%%%%%%%%%%%%%%%% 消除高频噪声 获得灰度图像 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%   灰度图像二值化 并获取单个连通体    %%%%%%%%%%%%%

% Binarize the image
level = graythresh(grayImageFiltered);
binaryImage = im2bw(grayImageFiltered, level);
% subplot(2, 3, 3);
% imshow(binaryImage);



% invert image 
% so 0's becomes 1's and 1's -> 0's
binaryImage = imcomplement(binaryImage);
%figure,imshow(binaryImage);

% Display the image.
subplot(2, 3, 3);
imshow(binaryImage, []);
axis on;
title('Initial Binary Image');

fprintf('information of connected components\n');
fprintf('before imfill\n');
CC1=bwconncomp(binaryImage)

% Fill holes
binaryImage = imfill(binaryImage, 'holes');
% Get rid of anything less than 10% of the image
fprintf('after imfill and before bwareaopen\n');
CC2=bwconncomp(binaryImage)

binaryImage = bwareaopen(binaryImage, round(0.1*numel(binaryImage)));
%%%%%%% 至此，获得了一个干净的二值化图像。(仅1个连通体)

% Display the image.
subplot(2, 3, 4);
imshow(binaryImage, []);
axis on;
hold on;
caption = sprintf('Filled, Cleaned Binary Image with \n Boundaries and Feret Diameters');
title(caption);

fprintf('after bwareaopen\n');
CC3=bwconncomp(binaryImage)


%%%%%%%%%%%%%%%%%%%%%%%%%%    灰度图像二值化 并获取单个连通体    %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%       获取图像边界 并画圈        %%%%%%%%%%%%%%%%

%Determine the row and column coordinates of a pixel on the border of 
% the object you want to trace. 
%bwboundary uses this point as the starting 
% location for the boundary tracing.

dim = size(binaryImage);
xPt = round(dim(2)/2)-90;
yPt = min(find(binaryImage(:,xPt)));

%Call bwtraceboundary to trace the boundary from the specified point. 
%As required arguments, you must specify a binary image, 
% the row and column coordinates of the starting point, and 
% the direction of the first step. The example specifies north ( 'N'),

boundary = bwtraceboundary(binaryImage,[yPt, xPt],'N');
%Display the original grayscale image and use 
% the coordinates returned by bwtraceboundary 
% to plot the border on the image.

% Copy the orignal image to the lower left.
subplot(2, 3, 5);
imshow(originalImage, []);
caption = sprintf('Original Image with\nBoundaries');
title(caption);
axis on;
hold on
plot(boundary(:,2),boundary(:,1),'g','LineWidth',3);



%%%%%%%%%%%%%%%%%%%%%%%%%%       获取图像边界 并画圈    %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

             %%%%%%%%%首先 计算出中心点 和 极值点 %%%%%%%%%%%%%%%%
figure;
imshow(binaryImage);
%imshow(originalImage);
title('Clean Binary Image');

set(gcf, 'Name', 'Demo by Xiaogang', 'NumberTitle', 'Off');
%%%plot(boundary(:,2),boundary(:,1),'y','LineWidth',3);

figure;
imshow(originalImage);
title('Original Image');
set(gcf, 'Name', 'Demo by Xiaogang', 'NumberTitle', 'Off');

                      %%%%%%%%%计算出中心 极值点 %%%%%%%%%%%%%%%%
x= boundary(:,2);% x = columns.    %%% 得到边界坐标  列
y = boundary(:,1); % y = rows.     %%% 得到边界坐标  行
                      
STATS=regionprops(binaryImage,'Centroid','Extrema','Orientation','MajorAxisLength','MinorAxisLength');

boundary_swap=[x,y];   %%%boundary矩阵中，左列是y，右列是x，颠倒了，在此纠正过来，符合正常思维。

bourdary_top_x=round((STATS.Extrema(1,1)+STATS.Extrema(2,1))/2);
bourdary_top_y=round((STATS.Extrema(1,2)+STATS.Extrema(2,2))/2);

bourdary_bottom_x=round((STATS.Extrema(5,1)+STATS.Extrema(6,1))/2);
bourdary_bottom_y=round((STATS.Extrema(5,2)+STATS.Extrema(6,2))/2);

bourdary_top=[bourdary_top_x,bourdary_top_y];
bourdary_bottom=[bourdary_bottom_x,bourdary_bottom_y];
center_point=round(STATS.Centroid);
%%%%这里需要补充一段代码，就是确认 bourdary_top  bourdary_bottom会否在bourdary矩阵中
%%%% 需要注意，regionprops这个函数，只能找到 03.jpg,04.jpg,07.jpg这种类型的树叶，对01.jpg无效

              %%%%%%%%%计算出中心点 和 极值点 %%%%%%%%%%%%%%%%

              %%%%%%%%% task to Tao WANG, Dezhi LI %%%%%%%%%
              
%%%%%%%%%%% boundary_swap  这是边界的坐标  第1列是 x  第2列是 y    郑鹏直接调用 boundary_swap 可以求边界的每一个点 曲率
%%%%%%%%%%% bourdary_top   顶端坐标        第1列是 x  第2列是 y  
%%%%%%%%%%% binaryImage    二值化图片  很干净，只有1个连通体     
%%%%%%%%%%% originalImage  原始图像







          


