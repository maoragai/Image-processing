img=imread('house.tiff');
[m,n]=size(img);
mat = imread('house.tiff');
mat = double(mat);
mat = mat/255;
[henanced,noisy]= shapesEnhance(mat);
imshow(henanced);