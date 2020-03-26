function [point3s_local_raw,e,time_stamp,panel_ID,e_max_ch] = detector_panel_local_decoder(data)
%ONLINE_POSTPROCESSING Decode bytes into decimal data for further
%processing
%   This function is highly associated with FPGA code in which the data
%   format has been defined.
% Simple output version
% Relationship between range (1,16) and corresponding range (-1,1) is 
% y = 7.5x + 8.5 



% subdata8x2 = data(1:2,:);
% subdata16 = subdata8x2(1,:)+subdata8x2(2,:)*256;
% eA = subdata16;
% 
% subdata8x2 = data(3:4,:);
% subdata16 = subdata8x2(1,:)+subdata8x2(2,:)*256;
% eB = subdata16;
% 
% subdata8x2 = data(5:6,:);
% subdata16 = subdata8x2(1,:)+subdata8x2(2,:)*256;
% PAR = subdata16;
% pR = (PAR/256-8.5)/7.5;
% 
% subdata8x2 = data(7:8,:);
% subdata16 = subdata8x2(1,:)+subdata8x2(2,:)*256;
% PAC = subdata16;
% pC = (PAC/256-8.5)/7.5;
% 
% subdata8x4 = data(9:12,:);
% subdata32 = -subdata8x4(1,:)+subdata8x4(2,:)*256+subdata8x4(3,:)*256*256+subdata8x4(4,:)*256*256*256;
% time_stamp = subdata32;
% panel_ID = data(16,:);
% 
% subdata8x2 = data(13:14,:);
% subdata16 = subdata8x2(1,:)+subdata8x2(2,:)*256;
% e_max_ch = subdata16;
% 

eA = data(1,:)+data(2,:)*256;
eB = data(3,:)+data(4,:)*256;

PAR = data(5,:)+data(6,:)*256;
pR = (PAR/256-8.5)/7.5;

PAC = data(7,:)+data(8,:)*256;
pC = (PAC/256-8.5)/7.5;

time_stamp = -data(9,:)+data(10,:)*256+data(11,:)*256*256+data(12,:)*256*256*256;

panel_ID = data(16,:);

e_max_ch = data(13,:)+data(14,:)*256;

e = eA+eB;
rratio = eA./(eA+eB);
point3s_local_raw = [pR;pC;rratio];

end

