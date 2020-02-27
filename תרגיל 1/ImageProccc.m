%Yann Tal 321477333
%Maor Agai 305544546
%load the mozart picture into a x as a grayscale matrix
x=imread('bigMozart.tiff');
%load the mozart picture into a x as a grayscale matrix
y=imread('smallMozart.tiff');
%create a figure
figure(1);
%show the mozart original pictures
imshow(x);
title('Original source image');
figure(2);
imshow(y);
title('Original source image');
figure(3);
imshow(x);
hold on
carry=zeros(size(y,1),size(y,2));
times=(size(x,1)/size(y,1))*(size(x,2)/size(y,2));
row=0;
col=0;
disp(size(x,2));
for k=1:times
    for i=1:size(y,1)
        for j=1:size(y,2)
            carry(i,j)=x(row+i,col+j);
        end
    end
    carry=histShape(y,carry);
    image([col col], [row row],carry);
    col=col+size(y,2);
    if col+size(y,2)>size(x,2)
        col=0;
        row=row+size(y,1);
    end
end
hold off