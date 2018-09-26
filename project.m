function x = project(MetaData, Para)
% delete all [0,0,0] in Point Cloud
pt = MetaData.ptCloud;
idx = find(pt(:,3)==0);
pt(idx,:) = [];
[m,n] = size(pt);
pt(:,4) = ones(m,1);

% set the tansform matrix from depth to camera
M = eye(4);
M(3,3) = -1;
M1 = Para.depth2rgb;
M11 = M*M1*M;

x1 = M1*pt';
x2 = Para.K(1:3,1:3)*x1(1:3,:);

figure
imshow(MetaData.deformIm);
hold on
scatter(x2(1,:),x2(2,:),[],pt(:,1:3),'filled');

% rgbT = Para.rgbT;
% pcT = Para.pcT;
% 
% M = eye(3);
% M(3,3) = -1;
% 
% rotmRGB = Para.rotmRGB;
% rotmPC = Para.rotmPC;
% K = Para.K;
% x = pt';
% rgbT(3) = -rgbT(3); 
% pcT(3) = -pcT(3);
% x1 = rotmRGB*(x+rgbT) ;