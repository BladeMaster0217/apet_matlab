function [global_position,e,pID,cID_global,t,e_max_ch] = panelProcessor(panel_bytes)
%PANELPROCESSOR Summary of this function goes here
%   Detailed explanation goes here
[point3s_local_raw,e,t,pID,e_max_ch] = detector_panel_local_decoder(panel_bytes);

%% Calibration Positions
[cID] = pRatio2CrystalID(point3s_local_raw(1:2,:),pID);

cID_global = cID + (pID-1)*900;

[Ay, Ax] = CrystalID2LocalPosition(cID);

Ax = Ax + rand(size(Ax))-0.5;
Ay = Ay + rand(size(Ay))-0.5;

rratio = point3s_local_raw(3,:);
[Az] = rratio2DOI_LUT(pID,cID,rratio);

point3s_local_corrected = [Ay;Ax;Az];

global_position = position_Local2Global(point3s_local_corrected,pID);

end

