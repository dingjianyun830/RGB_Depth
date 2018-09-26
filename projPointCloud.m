function p_out = projPointCloud(pc,M44)

dim_norm = size(M44,1); % 3D
dim_proj = size(M44,2); % 4D

pc_in = pc;

if size(pc_in,2)<dim_proj
    pc_in(:,dim_proj) = 1;
end
p2_out = (M44*pc_in')';

% normalized
p_out = p2_out(:,1:dim_norm-1)./(p2_out(:,dim_norm)*ones(1,dim_norm-1));