function global_position = position_Local2Global(local_position,pID)
%POSITION_2DTO3D Summary of this function goes here
%   Detailed explanation goes here
D = 161;
D = 160;

Ax = local_position(1,:);
Ay = local_position(2,:);
Az = local_position(3,:);

point3s_A = [Ax;-Az+D/2;Ay];

panel_theta = linspace(0,360,13)+90;
panel_theta = panel_theta(1:end-1)/180*pi;

global_position = zeros(size(local_position));
for ii_panel = 1:12
    rotate_para3 = [0 0 panel_theta(ii_panel)];
    idx = pID == ii_panel;
    global_position(:,idx) = [rotate3(point3s_A(:,idx)',rotate_para3)]';
end

