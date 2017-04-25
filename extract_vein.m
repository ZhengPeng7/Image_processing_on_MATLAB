BW = imread(strcat(pwd,'.\Leaves_UMU\1,46.JPG'));   %����ͼ��ľ���λ��
BW=rgb2gray(BW);      
thresh=[0.1,0.2]; %��ֵ���ø���ͼ���Զ��巶Χ   
sigma=1;%�����˹������1-3     
f = edge(double(BW),'canny',thresh,sigma);      
figure(1),imshow(f,[]);    
title('canny ��Ե���');%canny��Ե����  
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
se=strel('disk',5');%Բ���ͽṹԪ��
h=imdilate(h,se);%����
h=imerode(h,se);% Erosion
h=imdilate(h,se);%����
h=imerode(h,se);% Erosion
h=imdilate(h,se);%����
[h,lut] = bwmorph(h, 'thin', 'Inf'); 
h=imdilate(h,se);%����
[h,lut] = bwmorph(h, 'thin', 'Inf');  
h=imdilate(h,se);%����
[h,lut] = bwmorph(h, 'thin', 'Inf'); 
figure(3),imshow(h,[]);
title('Open');
wh = size(BW);
m = 20; n = 20; criteria = 12;
h = eliminate_the_acnode(h, m, n, criteria, wh);

figure(4), imshow(h, []);
title('The mixture');
k1 = filter2(fspecial('average',3),h)/255;  %����3*3ģ��ƽ���˲�
figure(5),imshow(k1,[]);
