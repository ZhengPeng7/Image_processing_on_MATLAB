function [ res ] = get_curvature_of_targeted_point( points, result, x_index, y_index )
    %	����get_non_zero_points�ĵ�, ��ȡ����Ӧ��Ŀ���(x_index, y_index)������ֵ.
    %   �˴���ʾ��ϸ˵��

    t = find(points(:, 1) == x_index & points(:, 2) == y_index);
    res = result(t);
end