function [newImg] = tagConnectedComponents(img)
%Maor Agai 305544546
%Yann Tal 321477333
%this function returns the picture with the labled connected elements
%create the output image eith the size of the input image
newImg=zeros(size(img,1)+2,size(img,2)+2);
%set the label value
label=1;
%iterate on every pixel in the matrix and looks if its neighbours contain
%any labeld pixel
for i=2:size(newImg,1)-1
   for j=2:size(newImg,2)-1
      if img(i-1,j-1)
         if newImg(i-1,j) + newImg(i+1,j) + newImg(i,j-1) + newImg(i,j+1) == 0
             newImg(i,j)=label;
             label=label+1;
         else
             newImg(i,j)=max(newImg(i+1,j),newImg(i-1,j));
             newImg(i,j)=max(newImg(i,j),newImg(i,j+1));
             newImg(i,j)=max(newImg(i,j),newImg(i,j-1));
         end
      end
   end
end
A=newImg;
B=zeros(size(A,1),size(A,2));
% we will iterate the image to detect any connected components that we
% didnt detect in the first iteration
while ~isequal(A,B)
    A=newImg;
    for i=2:size(newImg,1)-1
       for j=2:size(newImg,2)-1
           if newImg(i,j)~=0
               temp=newImg(i,j);
               if newImg(i-1,j)>0
                   newImg(i,j)=min(newImg(i,j),newImg(i-1,j));
               end
               if newImg(i+1,j)>0
                   newImg(i,j)=min(newImg(i,j),newImg(i+1,j));
               end
               if newImg(i,j-1)>0
                   newImg(i,j)=min(newImg(i,j),newImg(i,j-1));
               end
               if newImg(i,j+1)>0
                   newImg(i,j)=min(newImg(i,j),newImg(i,j+1));
               end
               if temp~=newImg(i,j)
                   newImg(newImg==temp)=newImg(i,j);
               end
           end
       end
    end
B=newImg;
end
newImg=newImg(2:end-1,2:end-1);
v=unique(newImg);
for k=2:size(v)
    newImg(newImg==v(k))=k-1;
end
end