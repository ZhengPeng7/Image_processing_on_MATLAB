function [point_x, point_y] = clicky( varargin ) 
    global text1;
    global text2;
    global clicky_points;
    global clicky_result;
    global counter;
    a=get(gca,'Currentpoint');
    set(findobj('style','text'),'String',strcat( 'x:',num2str(a(1,1)),'y:',num2str(a(1,2))));
    point_x = a(1, 1);
    point_y = a(1, 2);
    curvature = get_curvature_of_targeted_point(clicky_points, clicky_result, floor(a(1,1)), floor(a(1,2)));
    if isempty(curvature)
        % 对于无曲率的区域, 显示-1;
        curvature = '';
    end
    if counter == 0
        text1 = text(point_x+10, point_y+10, '+', 'color', 'r');
        set( text1,'string','');
        text2 = text(point_x+20, point_y-20,['curvature: ', num2str(curvature)],'color','b');
        set( text2,'string','');
        counter = 1;
    end
    set( text1,'string','');
    text1 = text(point_x-3, point_y+2, '+', 'color', 'r');
    set( text2,'string','');
    text2 = text(point_x+20, point_y-20,['curvature: ', num2str(curvature)],'color','b');
    
end