function [newImg, tgTeta] = edgeDetect(img)
%Maor Agai 
%Yann Tal 
%this function preforms the canny edge detection algorithm, also using
%sobel algorithm
[m n]=size(img);
%setting h/l thresholds
upperthreshold=1;
bottomthreshold=0.5;
%smoothing the image using the gaussian filter
kernel = fspecial('gaussian',[3 3],0.5);
img=imfilter(img,kernel);
%creating the sobel gradient kernels
Gy=[-1 -2 -1;0 0 0;1 2 1];
Gx=Gy';
%convolution in order to find gradient magnitude and orientation
newImg=(conv2(img,Gx,'same').^2+conv2(img,Gy,'same').^2).^0.5;
tgTeta=atan(conv2(img,Gy,'same')./conv2(img,Gx,'same'));
tgTeta=tgTeta.*(180/pi);
%creating a copy of tgTeta
tgTetareal=tgTeta;
%cases rounding the angel values
tgTeta(tgTeta>(60)&(tgTeta<=(90)))=90;
tgTeta(tgTeta>(30)&(tgTeta<=(60)))=45;
tgTeta(tgTeta>(-30)&(tgTeta<=(30)))=0;
tgTeta(tgTeta>(-60)&(tgTeta<=(-30)))=-45;
tgTeta(tgTeta>=(-90)&(tgTeta<=(-60)))=90;
multmat=[];
newImg2=zeros(size(img));
for i=2:m-1
    for j=2:n-1
        applyon=newImg(i-1:i+1,j-1:j+1);
        if tgTeta(i,j)==90
            multmat=[0 1 0;0 1 0;0 1 0].*applyon;
        elseif tgTeta(i,j)==45
            multmat=[1 0 0;0 1 0;0 0 1].*applyon;  
        elseif tgTeta(i,j)==0
            multmat=[0 0 0;1 1 1;0 0 0].*applyon;
        elseif tgTeta(i,j)==(-45)
            multmat=[0 0 1;0 1 0;1 0 0].*applyon;
        end
        if max(multmat(:))~=0
           if newImg(i,j)==max(multmat(:))
               newImg2(i,j)=max(multmat(:));
           else
               newImg2(i,j)=0;
           end
        else
             newImg2(i,j)=0;
        end
    end
end
edges=zeros(size(img));
newImg2(newImg2>upperthreshold)=4;
newImg2(newImg2<bottomthreshold)=0;
%check for edge linkage
for i=2:m-1
    for j=2:n-1
        applyon=newImg2(i-1:i+1,j-1:j+1);
        if newImg2(i,j)==4
            edges(i,j)=1;
        elseif newImg2(i,j)~=0 && sum(applyon(:) == 4)>0
            edges(i,j)=1;
        end
    end
end
%in order to get the unrounded angel tgTeta- uncomment next line
%tgTeta=tgTetareal;
newImg=edges;
end
