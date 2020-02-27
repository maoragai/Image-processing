function [newImg] = myMedian(img,rows,cols)
%Maor Agai 305544546
%Yann Tal 321477333
%this function preforms the median filter with a rows*cols kernel
[m,n] = size(img);
%i will determine the mid point of the filtering matrix
romid=floor(rows/2);
colmid=floor(cols/2);
%padding the image matrix wit zeros
y = [zeros(romid,n);img;zeros(romid,n)];
img=[zeros(colmid,size(y,1));y';zeros(colmid,size(y,1))]';
%building the output matrix
newImg=zeros(m,n);
row_indicator=1;

for i=1+romid:m-1
    col_indicator=1;
    for j=1+colmid:n-1
        %building the neighbours matrix
        v= [img(i-romid:1:i-1,j-colmid:1:j+colmid);
            img(i,j-colmid:1:j+colmid);
            img(i+1:1:i+romid,j-colmid:1:j+colmid)];
        %sorting the matrix as a vector
        v=sort(v(:)');
        %applying the middle value to the new matrix
        newImg(row_indicator,col_indicator)=v(floor(length(v)/2)+1);
        
        col_indicator=col_indicator+1;
    end
    row_indicator=row_indicator+1;
end
end
