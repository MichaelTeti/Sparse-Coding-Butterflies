function dict_update(X, D_temp, alpha_temp)

Y=[];
alpha_comp=[];
[p ~]=find(alpha_temp~=0);  %Find only those dictionary patches that were used in reconstruction
Xcols=X(:, p)';  %Find signals that used that dictionary patch
Y=[Y; Xcols];
alpha_comp=[alpha_comp; alpha_temp(p)'];

cvx_begin;	
    minimize( sum(sum((alpha_comp*D_temp'-Y).^2)) );  %minimize difference between error 
    subject to;
        alpha_comp==alpha_comp;  %Keep alpha the same, just modify the dictionary atom
        Y==Y;
cvx_end;


end


