function MPCRWhiten_Image2(im)


close all;
dbstop if error;
clc;


I=im;
I=rgb2gray(I);
I=im2double(I);
I=im_resize(I, 485, 485);


I1=MPCR_scale(MPCR_Whiten1(I));


I1=real(I1);
 

subplot(411)

imagesc(I)


colormap gray 

subplot(412)

imagesc(I1)

colormap gray 

 

subplot(413)

surf(I)

shading interp

 

subplot(414)

surf(I1)

shading interp

 

end
 

 

 

 





