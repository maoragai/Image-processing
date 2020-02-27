function [eImg,nImg] = gauseEnhance(img)
%Maor Agai 305544546
%Yann Tal 321477333
%this function perfoems the directional smoothing algorithm on an image
%using specific vectors and will choose the closest element of them and
%apply it to the newly created image (the filters are arbitrerily chosen 
%and specified below as kernels)
%kernels:eye(5)/5,ones(5,1)/5,ones(1,5)/5,flipud(eye(7)/7),ones(5,1)/5,eye(9)/9
kernel1=eye(5)/5;
kernel2=ones(5,1)/5;
kernel3=ones(1,5)/5;
kernel4=flipud(eye(7)/7); 
kernel5=ones(5,1) / 5;
kernel6=eye(9)/9;

[m,n]=size(img);
eImg=zeros(m,n);
%applying noise
nImg=imnoise(img,'gaussian',0,0.004);
%apply the filters on the image
mask1=conv2(nImg,kernel1,'same');
mask2=conv2(nImg,kernel2,'same');
mask3=conv2(nImg,kernel3,'same');
mask4=conv2(nImg,kernel4,'same');
mask5=conv2(nImg,kernel5,'same');
mask6=conv2(nImg,kernel6,'same');
for i=1:m
 for j=1:n
 %storing the filtered images at the specific index in an array
 convo_elements=[mask1(i,j),mask2(i,j),mask3(i,j),mask4(i,j),mask5(i,j),mask6(i,j)];
 %find the closest to the element
 tmp=abs(convo_elements-nImg(i,j));
 %find the place of the closest
 place=find(tmp==min(tmp));
 %apply it to the new image
 eImg(i,j)=convo_elements(place(1));
 end
end
end