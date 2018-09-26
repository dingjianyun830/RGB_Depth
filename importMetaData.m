function [MetaData,Para] = importMetaData(folder,NO)
% import the rgb frame
MetaData.im = imread([folder NO 'shot.jpg']);
% import the Point Cloud data
%MetaData.ptCloud = pcread([folder NO '.ply']);
MetaData.ptCloud = importPLY([folder NO '.ply']);
% reshape the ptCloud data to depth
%MetaData.depth = reshape(MetaData.ptCloud.Location,[352 287 3]);
MetaData.depth = reshape(MetaData.ptCloud,[352 287 3]);

% import the intrinsics parameter of RGB camera
Para.K = importIntrinsics([folder 'camera_Intr.txt']);

% import the Rotation and Trans Martix
[R1,T1] = importRTpara([folder NO 'shot_RT.txt']);
[R2,T2] = importRTpara([folder NO 'pc_RT.txt']);

Para.rgbR = R1;
Para.pcR = R2;
Para.rgbT = T1;
Para.pcT = T2;

% Compute the Rotation Matrix
[m,~] = size(R1);
if m == 3
    Para.rotmRGB = RotationM(R1');
    Para.rotmPC = RotationM(R2');
else
    Para.rotmRGB = Quat2Rotm(R1');
    Para.rotmPC = Quat2Rotm(R2');
end


%import the Transform Matrix
Para.depth2rgb = importdata([folder NO '_depth2rgb.txt']);
Para.rgb2depth = importdata([folder NO '_rgb2depth.txt']);
Para.depth2world = importdata([folder NO '_depth2world.txt']);
Para.rgb2world = importdata([folder NO '_rgb2world.txt']);
Para.world2rgb = importdata([folder NO '_world2rgb.txt']);
Para.world2depth = importdata([folder NO '_world2depth.txt']);