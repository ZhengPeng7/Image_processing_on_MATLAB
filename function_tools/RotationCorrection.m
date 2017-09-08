function correctedImage = RotationCorrection(im)
	% Straight an image

	%%%%% Convertion of input image into a gray scale image....
	[~, ~, numberOfColorChannels] = size(im); 
	if( numberOfColorChannels > 2) 
		grayImage = rgb2gray(im);
	else
		grayImage = im;
	end
	%%%%%

	%%%%% Edge detection and edge linking....
	binaryImage = edge(grayImage,'canny'); % 'Canny' edge detector
	binaryImage = bwmorph(binaryImage,'thicken'); % A morphological operation for edge linking

	theta = -90:89;
	[R,xp] = radon(binaryImage,theta);
	[R1,r_max] = max(R); 

	theta_max = 90;
	while(theta_max > 50 || theta_max<-50)
		[R2,theta_max] = max(R1); % R2: Maximum Radon transform value over all angles. 
								  % theta_max: Corresponding angle 
		R1(theta_max) = 0; % Remove element 'R2' from vector 'R1', so that other maximum values can be found.
		theta_max = theta_max - 91;
	end
	correctedImage = imrotate(im,-theta_max); % Rotation correction
	correctedImage(correctedImage == 0) = 255; % Converts black resgions to white regions
end
