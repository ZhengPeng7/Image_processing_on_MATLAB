%	调用该脚本完毕之后, 调用get_curvature_of_targeted_point()函数, 获取该点曲率.
clear,clc;
BW = imread(strcat(pwd,'.\Leaves_UMU\10.jpg'));  
points = extract_vein(BW);
result = figure_out_curvature(points);
