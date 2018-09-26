clc
clear

% set the work folder
folder = 'D:\shotFolder4\';
NO = '1392';

% import the data and parameters
[MetaData,Para] = importMetaData(folder,NO);

% deform the raw image
MetaData.deformIm = deformation(MetaData.im,Para.K);

% display point cloud
showPLY(MetaData.ptCloud);

% display depthmap from point cloud
showDepth(MetaData.depth);

% project point cloud to 2D image
x = project(MetaData, Para);
