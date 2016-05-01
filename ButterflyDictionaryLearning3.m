% Author=Michael A. Teti
% Florida Atlantic University Center for Complex Systems 
% Machine Perception and Cognitive Robotics Laboratory
% April 23, 2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dbstop if error;
clc;
close all;
clear all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load Data and create data matrix

img_size=64;
X=[];
patch_size=16;
num_classes=6;
cd ('\\Client\C$\Users\Michael\Documents\Work\MPCR\SparseButterfly\butterflyphotos');
basepath=pwd; % assign working directory to basepath
all_paths=dir(basepath);  % assign all subfolders in working dir. to all_paths
subfolds=[all_paths(:).isdir]; % get only subfolders
foldersNames = {all_paths(subfolds).name}';
foldersNames(ismember(foldersNames,{'.','..'})) = []; 
for i=1:length(foldersNames), %loop through all folders
    tmp = foldersNames{i};  %get folder by index
    p = strcat([basepath '/']); 
    currentPath =strcat([p tmp]); % add base to current folder
    cd(currentPath);   % change directory to new path
    files = dir('*.jpg'); % list all images in your path  
    for j=1:length(files), % loop through images 
        im = imread(files(j).name); % read each image 
        im=MPCRWhiten_Image2(im);
        im=imresize(im, [img_size img_size]);
        %im_red=im(:, :, 1);
        %im_green=im(:, :, 2);
        %im_blue=im(:, :, 3);
        %im_red=im2col(im_red, [patch_size patch_size]);
        %im_green=im2col(im_green, [patch_size patch_size]);
        %im_blue=im2col(im_blue, [patch_size patch_size]);
        %all_ims=[im_red; im_green; im_blue];
        impatch=im2col(im, [patch_size patch_size]);
        X=[X impatch];
    end
end

cd ('\\Client\C$\Users\Michael\Documents\Work\MPCR\SparseButterfly')
X=X(:, randperm(ceil(size(X, 2)/3)));
save('X.mat', 'X');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Feature Scaling

m=mean(X);
s=std(X);
for i=1:size(X, 2);
	X(:, i)=(X(:, i)-m(i))./s(i);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create Dictionary and alpha

k=350;
D=zeros(size(X, 1), k);
RandX=randperm(size(X, 2));
RandX=RandX(1:k);
for j=1:length(RandX)
	D(:, j)=X(:, RandX(j));
end

alpha=.1*rand(size(D, 2), size(X, 2)); 

% X is nxp, D is nxk, and alpha is kxp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sparse coding
%while err>.005
for i=1:size(X, 2)
    alpha1=alpha(:, i);
    Y=X(:, i);
    err=sparse_cod(Y, D, alpha1);
    [alpha_mod, error1]=fminsearch(@(alpha1)sparse_cod(Y, D, alpha1), alpha1);
    alpha(:, i)=alpha_mod;
end
%if err<.005
%    break
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update Dictionary


for i=1:size(D, 2);
    D_temp=D(:, i);
    alpha_temp=alpha(i, :);
    r=dict_update(X, D_temp, alpha_temp);
    D_mod=fminsearch(@(D_temp)dict_update(X, D_temp, alpha_temp), D_temp);
    D(:, i)=D_mod;
end
%end