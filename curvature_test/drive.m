function drive(BW)
    % 鼠标悬浮获取点坐标和对应曲率.
    % 效果请见图5
    BW = im2bw(BW);

    [b,~] = bwboundaries(BW, 8);
    b1 = b{1};
    t = circle2curve(b1);
    
    global clicky_points;
    global clicky_result;
    clicky_points = t;
    BW = bwmorph(BW,'thin',inf);
    clicky_result = figure_out_curvature(clicky_points);
    h0 = figure(1); imshow(BW);
    title('extract_vein');
    h2 = uicontrol('style','text','Position',[30 15 100 15],'string','non');
    global counter;
    counter = 0;
    set(h0,'WindowButtonMotionFcn',@clicky);
    figure(2);
    hold on;
    set(gca,'ylim',[0 2]);
    t = clicky_points(:, 1);
    plot(t, clicky_result, '.');

end