%% 效果见图4
clear,clc;
close all;
% 多项式: x^3 - 10 * x^2 + 1 测试
x = 1 : 0.1 : 6.28;
y = polyval([2, -10, 0, 1], x );
points = [x ; y]';
k = figure_out_curvature(points);
figure(2),
plot(x , k, 'red');
hold on;

%% 传统方法求多项式曲率
syms x_syms
f=2*(x_syms^3) - 10 * x_syms^2 + 1;
f1=diff(f,x_syms);
f2=diff(f1,x_syms);
cur=f2/(1+f1^2)^(3/2);
xx=0:0.1:6.28;rr=zeros(size(xx));
for i=1:length(xx)
    rr(i)=abs(subs(cur,x_syms,xx(i)));
end
plot(xx,rr, 'blue')
xlabel('x')
ylabel('曲率cur')
[x,y] = ginput;