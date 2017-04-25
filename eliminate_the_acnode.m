function [ h ] = eliminate_the_acnode( h, m, n, criteria, wh )
    % img, size_of_kernel, level_of_constraint, width_and_height_of_original_image
    % ѡȡ�Զ�����ܱ�����������Ϊ1�ĵ����� criteria �ĵ���Ϊ����������, ��Ϊ0.
    for k = m+1 : wh(1) - (m+1)
        for l = n+1 : wh(2) - (n+1)
            % change_to_0 = 1;
            neighbour_1 = 0;
            for i = -m : m
                for j = -n : n
                    if h(k - i, l - j) == 1
                        neighbour_1 = neighbour_1 +  1;
                    end 
                end
            end
            if neighbour_1 < criteria
                h(k, l) = 0;
            end
        end
    end

end

