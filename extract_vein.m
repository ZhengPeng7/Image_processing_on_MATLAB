function [img] = extract_vein(BW)
	%目的: 去噪, 提取出叶脉.
	%步骤: 1. canny算子去噪 -> 2. sobel算子去噪 -> 3. 两者做与运算 
	%-> 4. 进行形态学处理 -> 5. 利用eliminate_the_acnode去除离散噪声 -> 6. 平滑滤波 -> 7. 提高亮度, 二值化处理 -> 8. imshow.

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
