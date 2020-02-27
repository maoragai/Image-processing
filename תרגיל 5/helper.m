
%[m,n]=size(img);
%mat = imread('house.tiff');
%mat = double(mat);
%img = double(img/255);
%[A,f]=edgeDetect(img);
img1=double(imread('fft1.tiff'))/255;
img2=double(imread('fft2.tiff'))/255;
img3=double(imread('fft3.tiff'))/255;
img4=double(imread('fft4.tiff'))/255;
[cImg1,cImg2,cImg3,cImg4] = fftClean(img1,img2,img3,img4);
subplot(2,2,1);
imshow(cImg1);
subplot(2,2,2);
imshow(cImg2);
subplot(2,2,3);
imshow(cImg3);
subplot(2,2,4);
imshow(rotateImage(cImg4,45));
% img1=double(imread('fft1.tiff'))/255;
% [m,n]=gauseEnhance(img1);
% subplot(1,3,1);
% imshow(n)
% subplot(1,3,2);
% imshow(m)
% subplot(1,3,3);
% imshow(img1)
