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
%Load Data 

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
        im=MPCRWhiten_Image2(im);
        im=imresize(im, [img_size img_size]);
        impatch=im2col(im, [patch_size patch_size]);
        X=[X impatch];
    end
end

cd ('/home/mpcr/Desktop/butterflies-master')
X=X(:, randperm(ceil(size(X, 2)/3)));  %Data was making Matlab slow; took 1/3 of it 
save('X.mat', 'X');



