img=imread('balls4.tiff');
img=rgb2gray(img);
%[m,n]=size(img);
%mat = imread('house.tiff');
%mat = double(mat);
img = img/255;

[A,~]=edgeDetect(img);

imshow(A)
