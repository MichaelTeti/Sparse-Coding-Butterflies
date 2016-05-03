close all;
clear all;
clc;
dbstop if error;



%Feature Scaling

load data1.mat;   %load training data

m=mean(X); 
s=std(X);
for i=1:size(X, 2);
	X(:, i)=(X(:, i)-m(i))./s(i);  
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create Dictionary and alpha

k=350;    %350 atoms in dictionary  
RandX=randperm(size(X, 2));  %Take 350 random signals from X to create D
D=X(:, RandX(1:k));
alpha=.1*rand(size(D, 2), size(X, 2)); 

% X is nxp, D is nxk, and alpha is kxp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sparse coding

iter=0;

while iter < 10;
    cvx_begin;
        minimize( norm((D*alpha-X), 2) ); %minimize l2-norm of reconstruction
        subject to;
            norm(alpha, 1) <= k; %use less than 350 dictionary atoms
            X==X;  %keep original data the same 
            D==D;  %keep dictionary same for this part
    cvx_end;

    iter=iter+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Update Dictionary

    for i=1:size(D, 2); %update 1 dictionary atom at a time
        D_temp=D(:, i); 
        alpha_temp=alpha(i, :);
        dict_update(X, D_temp, alpha_temp);
        D(:, i)=D_temp;
    end
end
