% Author=Michael Anthony Teti
% Florida Atlantic University Center for Complex Systems 
% April 23, 2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dbstop if error;
clc;
close all;
clear all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load Data and create data matrix

img_size=64;
X=[];
patch_size=16;
num_classes=6;
cd ('/home/mpcr/Desktop/butterflies-master/butterflyphotos');
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
        im=im2double(im);  
        im_red=im(:, :, 1);
        im_green=im(:, :, 2);
        im_blue=im(:, :, 3);
        im_red=im_resize(im_red, img_size, img_size);
        im_green=im_resize(im_green, img_size, img_size);
        im_blue=im_resize(im_blue, img_size, img_size);
        im_red=im2col(im_red, [patch_size patch_size]);
        im_green=im2col(im_green, [patch_size patch_size]);
        im_blue=im2col(im_blue, [patch_size patch_size]);
        all_ims=[im_red; im_green; im_blue];
        X=[X all_ims];
    end
end

X=X(:, randperm(ceil(size(X, 2)/4)));
save('data.mat', 'X');



