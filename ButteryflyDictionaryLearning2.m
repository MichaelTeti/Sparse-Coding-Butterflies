%Butterfly Sparse Coding

close all; 
clear;
clc;
dbstop if error;



load data.mat
img_size=64
patch_size=16;
num_classes=6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature Scaling

m=mean(X);
s=std(X);
for i=1:size(X, 2);
	X(:, i)=(X(:, i)-m(i))./s(i);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create Dictionary and alpha

k=100;
D=zeros(size(X, 1), k);
RandX=randperm(size(X, 2));
RandX=RandX(1:k);
for j=1:length(RandX)
	D(:, j)=X(:, RandX(j))
end

alpha=zeros(size(D, 2), size(X, 2)); 

% X is nxp, D is nxk, and alpha is kxp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sparse coding

for i=1:size(X, 2)
	alpha1=alpha(i, :);
	Y=X(:, i);
	error=sparse(Y, D, alpha1);
	[alpha(i, :) error]=fmincg(@(alpha1)sparse(Y, D, alpha1), alpha1);
end
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update Dictionary


for i=1:size(D, 2);
	D_temp=D(:, i);
	alpha_temp=alpha(i, :);
	r=dict_update(X, D_temp, alpha_temp);
	D(:, i)=fmincg(@(D_temp)dict_update(X, D_temp, alpha_temp), D_temp);
end



