function [images, img_num, vertical_border] = import_images(file_path)
    % %% import pictures, and save into images{img_num}
    img_path_list = dir(strcat(file_path,'*.jpg'));%获取该文件夹中所有jpg格式的图像  
    img_num = length(img_path_list);%获取图像总数量  
    images = cell(1, img_num);
    if img_num > 0 %有满足条件的图像  
        for i = 1:img_num %逐一读取图像  
            image_name = img_path_list(i).name;% 图像名  
            images{i} =  im2bw(imread(strcat(file_path, image_name)));
            vertical_border{i} = [images{i}(:, 1), images{i}(:, end)];
            % fprintf(' %d %s\n',i,strcat(file_path,image_name));% 显示正在处理的图像名  
        end  
    end  
end
