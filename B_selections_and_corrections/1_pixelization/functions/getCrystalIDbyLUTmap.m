function crystal_id = getCrystalIDbyLUTmap(points2d,LUT_struct)
%GETCRYSTALIDBYLUTMAP Summary of this function goes here
%   Detailed explanation goes here

xx = LUT_struct.xx;
yy = LUT_struct.yy;
LUT = LUT_struct.LUT;

% xx_id = nan(size(points2d,2),1);
% yy_id = xx_id;

% for ii_x = 1:size(xx,2)
%     idx = abs(points2d(1,:) - xx(ii_x))<(xx(2)-xx(1));
%     xx_id(idx) = ii_x;
% end
% 
% for ii_y = 1:size(yy,2)
%     idx = abs(points2d(2,:) - yy(ii_y))<(yy(2)-yy(1));
%     yy_id(idx) = ii_y;
% end

%idx = ~(isnan(xx_id) | isnan(yy_id));

xx_id = ceil((points2d(1,:) + 17)/(xx(2)-xx(1))) + 1;
yy_id = ceil((points2d(2,:) + 17)/(yy(2)-yy(1))) + 1;

idx = ~(xx_id<=0 | xx_id>=512 | yy_id<=0 | yy_id>=512 | abs(points2d(1,:))<0.5 | abs(points2d(2,:))<0.5 );

crystal_id(idx) = LUT((xx_id(idx)-1)*512 + yy_id(idx));

crystal_id(~idx) = nan;
end

