function [newImg] = skeletonizeImage(img)
%Maor Agai 305544546
%Yann Tal 321477333
%function that recieves a binary image and returns its skelaton
[m,n]=size(img);
newImg=img;
%initialize the number of changes made
count=1;
%if we didnt change anything in the matrix-stop the while loop
while count>0
count=0;
for i=1:m
    for j=1:n
    %represent the 4 neighbour of the pixel+the pixcel
        vec=[0,0,0,0,0];
        vec(1)=img(i,j);
        %take his 4 neighbours
        if i>1
            vec(2)=img(i-1,j);
        end
        if j>1
            vec(3)=img(i,j-1);
        end
        if i<m
            vec(4)=img(i+1,j);
        end
        if j<n
            vec(5)=img(i,j+1);
        end
        %check if all the neighbours are equal to the main pixel
        summ=sum(vec==vec(1));
        %in case theyre equal
        if summ==5 && vec(1)~=0
            newImg(i,j)=img(i,j)+1;
        %count how much change weve done
        count=count+1;
        end
    end
end
img=newImg;
end
newImg=zeros(m,n);
for i=1:m
    for j=1:n
    vec=[0,0,0,0];
    %take his 4 neighbours
    if i>1
        vec(1)=img(i-1,j);
    end
    if j>1
        vec(2)=img(i,j-1);
    end
    if i<m
        vec(3)=img(i+1,j);
    end
    if j<n
        vec(4)=img(i,j+1);
    end
    %take the max between his neighbours
    [x x]=max(vec);
    %checks if the main pixel his the biggest from others
    if img(i,j)>=vec(x) && img(i,j)~=0
    %if yes mark him in new img
        newImg(i,j)=1;
    end
    end
end
end
