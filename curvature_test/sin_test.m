%% 效果见图1
clear, clc;
close all;
BW = imread(strcat(pwd,'.\Leaves_UMU\inv_sin_test.jpg'));  
BW = im2bw(BW);

[b,~] = bwboundaries(BW, 8);
b1 = b{1};
t = circle2curve(b1);
% x = b1(:,2);
% y = b1(:,1);
x = t(:, 1);
y = t(:, 2);

result = figure_out_curvature(t);

figure(1);
hold on;
set(gca, 'ylim',[0 1]);
plot(x, result, '.');
legend('离散傅里叶拟合');


%% 传统方法算 sinx 曲率
syms x1 y1
x0 = 0 : 0.01 : 2 * pi;
y0 = sin(x0);
points = [x0; y0]';
y1 = sin(x1);
yd2 = diff(y1, 2);
yd1 = diff(y1, 1);
l = abs(yd2) / (1+yd1^2)^(3/2);  %% 曲率公式
k1 = subs(l, x1, x0);
figure(2);hold on;
plot(x0, k1, 'r');
legend('原sinx曲率');