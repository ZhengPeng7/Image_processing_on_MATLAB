function [t] = circle2curve(b1)
    % 由于bwboundaries取的是圈, 每列上都有一个或多个像素,
    % 此函数使每个列上取排在最前的那一个参考, 这样就是一个连续的线
    % (若不这样处理, 效果差很多, 参见图2).

    c = fliplr(b1); % 颠倒1, 2列
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