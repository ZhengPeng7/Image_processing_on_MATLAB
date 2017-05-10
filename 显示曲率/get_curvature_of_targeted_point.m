function [ res ] = get_curvature_of_targeted_point( points, result, x_index, y_index )
    %	传入get_non_zero_points的点, 提取出对应于目标点(x_index, y_index)的曲率值.
    %   此处显示详细说明

    t = find(points(:, 1) == x_index & points(:, 2) == y_index);
    res = result(t);
end