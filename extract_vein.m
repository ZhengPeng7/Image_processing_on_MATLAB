function [img] = extract_vein(BW)

	% BW = imread(strcat(pwd,'.\Leaves_UMU\10.jpg'));   %读入图像的具体位置
	BW=rgb2gray(BW);      
	thresh=[0.1,0.2]; %阈值设置根据图像自定义范围   
	sigma=1;%定义高斯参数，1-3     
	f = edge(double(BW),'canny',thresh,sigma);      
	figure(1),imshow(f,[]);    
	title('canny 边缘检测');%canny边缘算子  
	g = edge(double(BW),'sobel', [], 'both'); 
	figure(2),imshow(g,[]);
	title('sobel');
	wh = size(BW);
	h = BW;
	for k = 1 : wh(1)
		for l = 1 : wh(2)
			h(k, l) = f(k, l) && g(k, l);
		end
	end
	% h = f;
	se=strel('disk',5');%圆盘型结构元素
	h=imdilate(h,se);%膨胀
	h=imerode(h,se);% Erosion
	h=imdilate(h,se);%膨胀
	h=imerode(h,se);% Erosion
	h=imdilate(h,se);%膨胀
	[h,lut] = bwmorph(h, 'thin', 'Inf'); 
	h=imdilate(h,se);%膨胀
	[h,lut] = bwmorph(h, 'thin', 'Inf');  
	h=imdilate(h,se);%膨胀
	[h,lut] = bwmorph(h, 'thin', 'Inf'); 
	figure(3),imshow(h,[]);
	title('Mixture and Open');
	wh = size(BW);
	m = 20; n = 20; criteria = 12;
	h = eliminate_the_acnode(h, m, n, criteria, wh);

	figure(4), imshow(h, []);
	title('Eliminate the acnode');
	k1 = filter2(fspecial('average',3),h)/255;  %进行3*3模板平滑滤波
	figure(5),imshow(k1,[]);
	img=imadjust(k1,stretchlim(k1),[0 1]);
	figure, imshow(img);
	title('extract_vein');
end
