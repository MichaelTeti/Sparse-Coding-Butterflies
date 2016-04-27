function f=MPCR_whiten_filter(N)

 

 

[fx fy] = meshgrid(-N/2:N/2-1);

[theta rho]=cart2pol(fx,fy);

 

 

f=rho.*exp(-0.5*(rho/(0.7*N/2)).^2);

 

 

end
