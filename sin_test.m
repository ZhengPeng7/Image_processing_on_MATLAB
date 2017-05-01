%	用于验证程序的合理性
clear, clc;
x = 0 : 0.01 : 2 * pi;
y = sin(x);
points = [x; y]';
result = figure_out_curvature(points);
[x_index, y_index] = find(points(:, 1) == 0.77);
result(x_index, :)
