function [nImg] = rotateImage(img, angle)
%Yann Tal 321477333
%Maor Agai 305544546
%this function rotates an image in a given angle clockwise
%getting the image dimensions
[m,n]=size(img);
%centers
row_cen=floor(m/2);
col_cen=floor(n/2);
%creating a new image
nImg=zeros(size(img));
%cosine and sine values for the angle
cod=cosd(-angle);
sid=sind(-angle);
for i=1:size(img,1)
    for j=1:size(img,2)   
        %creating a transformation to determine the new location of the
        %pixel
        row_loc=round((i-row_cen)*cod+(j-col_cen)*sid+row_cen);
        col_loc=round(0-(i-row_cen)*sid+(j-col_cen)*cod+col_cen);
        %checks if the new location is within the image boundries
        if (row_loc>=1 && row_loc<=m && col_loc>=1&&col_loc<=n)
          nImg(i,j)=img(row_loc,col_loc);
        end
    end
end
end