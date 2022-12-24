%1399/08/18
%zahra farzadpour
%using lcp features to detect real and fake fingerprint
%120 sample for training and 400 sample for testing
close all
clear all
clc
%read input images(for train)
imagepath5='train';
filelist5=dir(fullfile(imagepath5,'*.bmp'));
list5={filelist5.name};
for i=1:length(list5)
    img5{i,1}=imresize(imread(fullfile(imagepath5,list5{i})),[96 96]); 
    
end
data_train=[img5];
for i=1:120
    input1=data_train{i,1};
    %intensityvalue=[Gx Gy];
    [Gx,Gy] = imgradientxy(input1);
    xx=[];
for x=2:95
    for y=2:95
        c5=[input1(x,y),Gx(x,y),Gy(x,y)]';
    c1=[input1(x-1,y-1),Gx(x-1,y-1),Gy(x-1,y-1)]';
     c2=[input1(x-1,y),Gx(x-1,y),Gy(x-1,y)]';
      c3=[input1(x-1,y+1),Gx(x-1,y+1),Gy(x-1,y+1)]';
       c4=[input1(x,y-1),Gx(x,y-1),Gy(x,y-1)]';
        c6=[input1(x,y+1),Gx(x,y+1),Gy(x,y+1)]';
         c7=[input1(x+1,y-1),Gx(x+1,y-1),Gy(x+1,y-1)]';
          c8=[input1(x+1,y),Gx(x+1,y),Gy(x+1,y)]';
           c9=[input1(x+1,y+1),Gx(x+1,y+1),Gy(x+1,y+1)]';
         C=double([c1,c2,c3,c4,c5,c6,c7,c8,c9]);
       z{i,1}=C;
       [U{i,1},W{i,1},V{i,1}] = svd(z{i,1});
 %computing thereshold for coherence pattern
D{i,1}=diag(W{i,1});
w1{i,1}=D{i,1}(1);
w2{i,1}=D{i,1}(2);
w3{i,1}=D{i,1}(3);
c{i,1}(x,y)=w1{i,1}-(w2{i,1}+w3{i,1});
%local coherence pattern
        pixel7=input1(x-1,y-1)>c{i,1}(x,y);
        pixel6=input1(x-1,y)>c{i,1}(x,y);
        pixel5=input1(x-1,y+1)>c{i,1}(x,y);
        pixel4=input1(x,y+1)>c{i,1}(x,y);
        pixel3=input1(x+1,y+1)>c{i,1}(x,y);
        pixel2=input1(x+1,y)>c{i,1}(x,y);
        pixel1=input1(x+1,y-1)>c{i,1}(x,y);
        pixel0=input1(x,y-1)>c{i,1}(x,y);
        lcp_image(x,y)=uint8(pixel7*2^7+pixel6*2^6+pixel5*2^5+pixel4*2^4+pixel3*2^3+pixel2*2^2+pixel1*2^1+pixel0);
        n{i,1}=lcp_image;
    end
end
end
 for i=1:120
    xx=[xx,reshape(n{i,1},9025,1)];
end
xdata=double([xx]');
%label
for q=1:60
    group{q,1}='real';
end
for q=61:120
    group{q,1}='fake';
end
%svm struct
svmStruct= svmtrain(xdata,group,'kernel_function','rbf','rbf_sigma',106,'showplot',false);
%% 

%testing 
%read input images
%input images for testing
imagepath1='test';
filelist1=dir(fullfile(imagepath1,'*.bmp'));
list1={filelist1.name};
for i=1:length(list1)
    img1{i,1}=imresize(imread(fullfile(imagepath1,list1{i})),[96 96]); 
    
end
data_test=[img1];
for i=1:400
    noisy_image{i,1}=awgn(double(img1{i,1}),-30);
end
for i=1:400
    input11=noisy_image{i,1};
    %intensityvalue=[Gx Gy];
    [Gx,Gy] = imgradientxy(input11);
    II=[];
for x=2:95
    for y=2:95
        j5=[input11(x,y),Gx(x,y),Gy(x,y)]';
    j1=[input11(x-1,y-1),Gx(x-1,y-1),Gy(x-1,y-1)]';
     j2=[input11(x-1,y),Gx(x-1,y),Gy(x-1,y)]';
      j3=[input11(x-1,y+1),Gx(x-1,y+1),Gy(x-1,y+1)]';
       j4=[input11(x,y-1),Gx(x,y-1),Gy(x,y-1)]';
        j6=[input11(x,y+1),Gx(x,y+1),Gy(x,y+1)]';
         j7=[input11(x+1,y-1),Gx(x+1,y-1),Gy(x+1,y-1)]';
          j8=[input11(x+1,y),Gx(x+1,y),Gy(x+1,y)]';
           j9=[input11(x+1,y+1),Gx(x+1,y+1),Gy(x+1,y+1)]';
         J=double([j1,j2,j3,j4,j5,j6,j7,j8,j9]);
       H{i,1}=J;
       [UU{i,1},WW{i,1},VV{i,1}] = svd(H{i,1});
 %computing thereshold for coherence pattern
DD{i,1}=diag(WW{i,1});
ww1{i,1}=DD{i,1}(1);
ww2{i,1}=DD{i,1}(2);
ww3{i,1}=DD{i,1}(3);
e{i,1}(x,y)=ww1{i,1}-(ww2{i,1}+ww3{i,1});
%local coherence pattern
        p7=input11(x-1,y-1)>e{i,1}(x,y);
        p6=input11(x-1,y)>e{i,1}(x,y);
        p5=input11(x-1,y+1)>e{i,1}(x,y);
        p4=input11(x,y+1)>e{i,1}(x,y);
        p3=input11(x+1,y+1)>e{i,1}(x,y);
        p2=input11(x+1,y)>e{i,1}(x,y);
        p1=input11(x+1,y-1)>e{i,1}(x,y);
        p0=input11(x,y-1)>e{i,1}(x,y);
        lcp_image_test(x,y)=uint8(p7*2^7+p6*2^6+p5*2^5+p4*2^4+p3*2^3+p2*2^2+p1*2^1+p0);
        nn{i,1}=lcp_image_test;
    end
end
end
 for i=1:400
    II=[II,reshape(nn{i,1},9025,1)];
end
sample=double([II]');
%svm test
Test = svmclassify(svmStruct,sample,'showplot',false);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%f-score
for i=1:300
    actual{i,1}=[0];
end
for i=301:400
    actual{i,1}=[1];
end
for i=1:400
    if Test{i,1}=='real'
        predicted{i,1}=[0];
    else
        predicted{i,1}=[1];
    end
end
ACTUAL=(cell2mat(actual));
PREDICTED=(cell2mat(predicted));
result=fscore(ACTUAL,PREDICTED);

