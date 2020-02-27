function [circles,cImg] = findCircles(img)
%Maor Agai 305544546
%Yann Tal 321477333
%The function preforms hough transform in order to find circles
nImg=edgeDetect(img);
[m,n]=size(nImg);
%create counters
count=zeros(m,n,floor(sqrt(m^2+n^2)+1));
radmax=45;%other pics values:balls1=31,balls4=45 (,balls5=59 )
radmin=15;%other pics values:balls1=10,balls4=15
minCnt=40;%other pics values:balls1=35 ,balls4=38 (,balls5=71 )

%preform counting for every point
for x=1:m
    for y=1:n
        if nImg(x,y)==1
            for Circlex=1:m
                for Circley=1:n
                r=floor(sqrt((x-Circlex)^2+(y-Circley)^2));
                count(Circlex,Circley,r+1)= count(Circlex,Circley,r+1)+1;
                
                end
            end
        end
    end
end

%%%%%%
%find point and radious 
circles=zeros(1,3);
idx=1;
%%%%%%

for Circlex=1:m
    for Circley=1:n
        for rad=radmin:radmax-3
            
            if count(Circlex,Circley,rad)>=minCnt
                %if the point is bigger then neighbors
                if is_maximum(count,Circlex,Circley,rad,radmax)==1
                    
                    %in case it is assign it to the circles list
                    circles(idx,1:3)=[Circlex,Circley,rad-1];
                    count(Circlex,Circley,rad)=count(Circlex,Circley,rad)+1;
                    idx=idx+1;
                    
                end
            end
        end
    end
end

%%%%
for z=1:idx-1
    %print the circles found
    fprintf('circle num %d:%d,%d,%d\n',z,circles(z,1),circles(z,2),circles(z,3));
end

%apply the circles to the image
cImg=apply_circles(img,circles);
end


function[newImg]=apply_circles(img,circles_list)
%apply the circles on a given image
[m,n]=size(img);
%create a rgb colored layers
newImg=zeros(m,n,3);
%apply the image to every layer
newImg(1:m,1:n,1)=img;
newImg(1:m,1:n,2)=img;
newImg(1:m,1:n,3)=img;
for circlex=1:m
    for Circley=1:n
        for z=1:size(circles_list,1)
            if floor(sqrt((circles_list(z,1)-circlex)^2+(circles_list(z,2)-Circley)^2))==circles_list(z,3)-1
                newImg(circlex,Circley,1:3)=[1 0 0];%create a circle only in specific layer (red)
            end
        end
    end
end
end

function [maxfound] = is_maximum(cnt,Circlex,Circley,radius,rmax)
maxfound=0;
maxi=max(max(max(cnt(Circlex-3:Circlex+3,Circley-3:Circley+3,radius-3:radius+3))));
c=cnt(Circlex,Circley,radius);
if (c>=maxi)
    if (radius<rmax)
        maxfound=1;
    end
end
end