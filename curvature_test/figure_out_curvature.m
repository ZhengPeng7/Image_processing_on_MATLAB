function [ curvature ] = figure_out_curvature( points )
    %	重难点! 通过离散傅里叶变换, 求出该点的曲率
	%	公式: 第21行 k 的表达式.
    
    x_axis = points(:,1);
    y_axis = points(:,2);
    xf = fft(x_axis);
    yf = fft(y_axis);
    nx = length(xf);
    hx = ceil(nx/2)-1;
    ftdiff = (2i*pi/nx)*(0:hx);
    ftdiff(nx:-1:nx-hx+1) = -ftdiff(2:hx+1);
    ftddiff = (-(2i*pi/nx)^2)*(0:hx);
    ftddiff(nx:-1:nx-hx+1) = ftddiff(2:hx+1);
    xf(25:end-24) = 0;
    yf(25:end-24) = 0;
    dx = real(ifft(xf.*ftdiff'));
    dy = real(ifft(yf.*ftdiff'));
    ddx = real(ifft(xf.*ftddiff'));
    ddy = real(ifft(yf.*ftddiff'));
    k = sqrt((ddy.*dx - ddx.*dy).^2) ./ ((dx.^2 + dy.^2).^(3/2));

    curvature = k;
end

