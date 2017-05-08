function [t] = circle2curve(b1)
    % ����bwboundariesȡ����Ȧ, ÿ���϶���һ����������,
    % �˺���ʹÿ������ȡ������ǰ����һ���ο�, ��������һ����������
    % (������������, Ч����ܶ�, �μ�ͼ2).

    c = fliplr(b1); % �ߵ�1, 2��
    x_c = c(:, 1);
    y_c = c(:, 2);

    j=1;
    t = zeros(2);
    t(max(b1(:, 2)), 1) = 0;
    for i = 1 : floor(size(b1)/2)
        if i ~= 1 && x_c(i - 1) == x_c(i)
            continue;
        end
        t(j, 1) = x_c(i);
        t(j, 2) = y_c(i);
        j = j + 1;
    end
end