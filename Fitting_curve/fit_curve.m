clear, clc;
close all;
curve_idx = input('请输入曲线的序号: ');
mat_name = strcat( strcat('curve_', num2str(curve_idx)), '.mat');
load(mat_name);

% const_list = [ lambda, Vh ];

% L0 = (L0_range(1) + L0_range(2)) / 2;
% Lf = (Lf_range(1) + Lf_range(2)) / 2;
% sigma = (sigma_range(1) + sigma_range(2)) / 2;

figure_idx = 1;
para_all = [0, 0, 0];
for i = 40 : 5 : 60   % i准精度1        
    for j = Lf_range(1) : 5 : Lf_range(2)   % j准精度1
        for k = sigma_range(1) : 0.0004 : sigma_range(2)    % sigma准精度0.0001
            var_list = [ i, j, k ];
            c0 = var_list;
            for m =1:100
                c = lsqnonlin (@the_formula, c0, X_axis_L_cut, Y_axis_L_cut) ;
                c0 = c; %以计算出的 c为初值进行迭代;
            end
            para_all(figure_idx, :) = c
            x_fit = X_axis_L_cut(1) : 1 : X_axis_L_cut( size(X_axis_L_cut) );
            res_fit = ( c(1) - c(2) ) .* exp( ( -c(3) .* ( 1.300510409196659e+04 ./ (x_fit - 287) ) ) ) + c(2);
            if  mod(figure_idx, 10) == 1
                figure(figure_idx);
                plot(X_axis_L_cut, Y_axis_L_cut, 'blue', x_fit, res_fit, 'red');
                legend ('实验数据 ','拟合曲线')
            end
            figure_idx = figure_idx + 1;
        end    % k in sigma
    end    % j in Lf
end    % i in L0