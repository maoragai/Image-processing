function [eImg,nImg] = shapesEnhance(img)
%Maor Agai 305544546
%Yann Tal 321477333
%this function adds 'salt & pepper' shaped-noise to an image and apply
%the myMedian filter on them with a 5*5 filter matrix
%(with which i got the optimal performence)
%building the noise shape matrix as required in the instructions

matrix=[1,0,0,0,1;
        0,1,0,1,0;
        0,0,1,0,0;
        0,1,0,1,0;
        1,0,0,0,1];
%new image-sized matrix to apply the noise on
mask=zeros(size(img));
%applying the noise
mask=imnoise(mask,'salt & pepper',0.003);
%using the matlab convolution method to "filter" create shaped noise
mask=~conv2(mask,matrix);
%applying the noise to the image
for i=1:size(img,1)
    for j=1:size(img,2)
        if mask(i,j)==0
            img(i,j)=0;
        end
    end
end
%output 
nImg=img;
eImg=myMedian(img,5,5);
end
