img=double(imread('balls4.tiff'));
%img=rgb2gray(img);
%[m,n]=size(img);
%mat = imread('house.tiff');
%mat = double(mat);
img = double(img/255);
%[A,f]=edgeDetect(img);
[A,f]=findCircles(img);
imshow(f)
