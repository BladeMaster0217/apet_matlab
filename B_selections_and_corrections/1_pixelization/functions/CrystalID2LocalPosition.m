function [Ax, Ay] = CrystalID2LocalPosition(cID)
%CRYSTALID2LOCALPOSITION Summary of this function goes here
%   Detailed explanation goes here


%%
% sub_array_bias = 8.9; % mm
% 
% array_width = 16.8; % mm

panel_width = 34.7; %mm
array_width = 16.8; % mm
sub_array_bias = panel_width/2-array_width/2;

sub_array_edges = linspace(-array_width/2,array_width/2,16);

sub_array_center = (sub_array_edges(1:end-1) + sub_array_edges(2:end))/2;

xx = [sub_array_center-sub_array_bias sub_array_center+sub_array_bias];

[xx_m,yy_m] = meshgrid(xx,xx);

idx = cID>0;
points_2d(1,idx) = xx_m(cID(idx));
points_2d(2,idx) = yy_m(cID(idx));
points_2d(:,~idx) = nan; 

Ay = points_2d(1,:);
Ax = points_2d(2,:);
%%
% scatter(points_2d(1,:),points_2d(2,:))

end
