function [ res ] = the_formula( c, x )
%	c: L0, Lf, sigma Ϊ�Ա���, lambda, x, VhΪ��֪��
%   �˴���ʾ��ϸ˵��
%   f=1-8/9.8696.*exp(-9.8696.*c(1).*x/(c(2).^2));
    
    res = ( c(1) - c(2) ) .* exp( ( -c(3) .* ( 1.300510409196659e+04 ./ (x - 287) ) ) ) + c(2);

end

