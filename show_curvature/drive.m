function [k, p] = drive(BW)
    % 鼠标悬浮获取点坐标和对应曲率.
    % 效果请见图5
    BW = im2bw(BW);

    [b,~] = bwboundaries(BW, 8);
    b1 = b{1};
    
    global mouse_hover_points;
    global mouse_hover_result;
    mouse_hover_points = b1;
    mouse_hover_result = figure_out_curvature(mouse_hover_points);
    h0 = figure;
    imshow(BW);
    h2 = uicontrol('style','text','Position',[30 15 100 15],'string','non');
    global counter;
    counter = 0;
    set(h0,'WindowButtonMotionFcn',@mouse_hover);
    figure;
    hold on;
    set(gca,'ylim',[0 2]);
    t = mouse_hover_points(:, 1);
    plot(t, mouse_hover_result, '.');
    k = mouse_hover_result;
    p = b1;
end