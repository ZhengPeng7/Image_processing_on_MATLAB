function [ non_zero_points ] = get_non_zero_points( img )
    %GET_NON_ZERO_POINTS 此处显示有关此函数的摘要
    %   此处显示详细说明
    [img_width, img_height] = size(img);
    result = [];
    m = 1;
    for i = 1 : img_width
        for j = 1 : img_height
            if img(i, j) ~= 0
                result(m, 1) = i;
                result(m, 2) = j;
                m = m + 1;
            end
        end
    end
    non_zero_points = result;
end

