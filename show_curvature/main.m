clear, clc
close all;

originalImage = imread(strcat(pwd,'.\Leaves_UMU\07.jpg'));
if numberOfColorBands > 1
	grayImage = originalImage(:, :, 2); % Take green channel.
else
	grayImage = originalImage;
end
[k, p] = drive(binaryImage);
