function I=MPCR_Whiten1(I)



f=MPCR_whiten_filter(size(I,1));

 

surf(f)

shading interp

pause



I = ifft2(fftshift(f.*fftshift(fft2(I))));

 


 

end

