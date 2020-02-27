function nImg = createTiledImage(bigImage, smallImage)
%CREATETILEDIMAGE 
%Yann Tal 321477333
%Maor Agai 305544546
%this function creates an image made out of smaller images
%insert big image to the output matrix
nImg=bigImage;
%create a temporary matrix
carry=zeros(size(smallImage));
%calculate how many times the small picture can fit into the large one
times=size(bigImage,1)/size(smallImage,1)*size(bigImage,2)/size(smallImage,2);
row=0;
col=0;
for k=1:times
    %fill temporrary matrix with pixels from the big picture
    for i=1:size(smallImage,1)
        for j=1:size(smallImage,2)
            carry(i,j)=bigImage(row+i,col+j);
        end
    end
    % perform the histshape algorithm to fit the hist of the small image
    % to the corrseponding place in the large image
    carry=histShape(smallImage,carry);
    %fill the temporrary image 
    for i=1:size(carry,1)
        for j=1:size(carry,2)
            nImg(row+i,col+j)=carry(i,j);
        end
    end
    %index adjustment
    col=col+size(smallImage,2);
    if col+size(smallImage,2)>size(bigImage,2)
        col=0;
        row=row+size(smallImage,1);
    end
end
end