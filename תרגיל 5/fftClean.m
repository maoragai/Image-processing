function [cImg1,cImg2,cImg3,cImg4] = fftClean(img1,img2,img3,img4)
%Yann Tal 321477333
%Maor Agai 305544546
%this function preforms the fft clean algorithm on 4 given pictures and
%returns the 4 clear images
cImg1=cleanFft(img1); 
cImg2=cleanFft(img2); %We use the same general function for every input, and save the output for each in the returned variables
cImg3=cleanFft(img3); 
cImg4=cleanFft(img4);
end
function [cImg] = cleanFft(img) %Takes in any image, and returns a clean version of it accourding to a set tolerance 
tol=0.008; %This tolerance value works perfectly for those specific 4 pictures, but could also work perfectly for others                      
fourier=fftshift(fft2(img)); %We apply both a fast fourier transform for 2D and then a fourier shift to centre all the high frequencies
pimg=log(abs(fourier)+1); %We apply the fourier algorithm, by taking the log of the absolute value we get a clear frequency domain, we add 1 so every point is defined
pimg=pimg/max(max(pimg)); %We take the norm of the frequency domain and set the frequency domain to its norm 
[mi,mj]=find(pimg==1); %We get the index in the middle of the frequency domain, where the highest peek of 1 is
pimg(mi-1:mi+1,mj-1:mj+1)=0; %We set the centre square of the frequency domain to 0 so we will ignore those high frequencies
maxPix=0; %We want to find the maximum peak where the noise is in the frequency domain, so we can remove it
for i=1:size(pimg,1) %Iterating over the frequency domain of the picture to find the maximum peak where the noise is
    for j=1:size(pimg,2)
        if pimg(i,j)>maxPix %Obviously the highest frequencies are right around the middle, so we ignore them and find other high frequencies
            maxPix=pimg(i,j); %Eventually homes in to the maximum frequencies which are not in the middle, they are most likely the noise signals
        end
    end
end
fourier(pimg>=maxPix-tol & pimg<=maxPix+tol)=0; %We eliminate all the potential noise, which is around the peaks we found, in the neighborhood of our tolerance
cImg=ifft2(ifftshift(fourier)); %We take inverse foourier shift function, and then the inverse fourier 2D transform to get back the image in the image domain
end