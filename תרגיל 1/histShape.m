function [newImg] = histShape(srcimg,destimg)
%HISTSHAPE 
%Yann Tal 321477333
%Maor Agai 305544546
%this function performs the histogram shaping algorithem for an image
%to match the histogram of another one
%get the size of the destination image
[rows,cols]=size(destimg);
%create a zeros vector for the picure's histogram
hist=zeros(1,256);
%get the histogram of the destination image
for i=1:rows
    for j=1:cols
       hist(destimg(i,j)+1)=hist(destimg(i,j)+1)+1;
    end
end
%create the accumulation histogram
ahist=hist;
for color=2:256
    ahist(color)=ahist(color-1)+hist(color);
end
%normalize the accumulation histogram
nahist=ahist/(cols*rows);
%get the size of the source image
[rows,cols]=size(srcimg);
hist1=zeros(1,256);
%create the histogram of the source image
for i=1:rows
    for j=1:cols
       hist1(srcimg(i,j)+1)=hist1(srcimg(i,j)+1)+1;
    end
end
%create the accumulation histogram
ahist1=hist1;
for color=2:256
    ahist1(color)=ahist1(color-1)+hist1(color);
end
%normalize the accumulation histogram
nahist1=ahist1/(cols*rows);
%create a vector to hold the new grayscale color transformation
cv=zeros(1,256);
s=1;
d=1;
%create the transformation vector
while s<=256
    if nahist(d)<nahist1(s)
        d=d+1;
    else
        cv(s)=d-1;
        s=s+1;
    end
end
%create the new image according to the grayscale transformation vector
for i=1:rows
    for j=1:cols
        srcimg(i,j)=cv(srcimg(i,j)+1);
    end
end
newImg=srcimg;

end