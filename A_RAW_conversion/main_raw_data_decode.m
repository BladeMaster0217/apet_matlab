%% The purpose of preprocessing is to decode binary RAW data into 
%   data subsets, etc. energy, time, position. 
%% Example
filename = 'exp_1hmin.mat';
filepath = myPATHs.SAMPLE_DATA_PATH;

filename_f = fullfile(filepath,filename);
load(filename_f)

%% Decode a detector
panel_data = coincidence_data_pool(1:16,:);
[point3s_local_raw,e,t,pID] = detector_panel_local_decoder(panel_data);

%% Draw flood source
close all

figure('Position',[0 0 1600 900])

centers = -17:0.05:17;
for ii_panel = 1:12
    subplot(3,4,ii_panel)
        idx_p = pID == ii_panel;
        idx = idx_p;
        
        [N,c] = hist3(point3s_local_raw(1:2,idx)'*16,'Ctrs',{centers centers},'FaceColor','interp','CdataMode','auto');

        title(['pID=' num2str(ii_panel)])
        
        colormap hot
        
        I = imgaussfilt(N,1);
        I=localnormalize(I,50,10);
        imagesc(c{2},c{1},I)
        axis equal

        xlim([-17 17])
        ylim([-17 17])
end

sgtitle(filename_f,'Interpreter','none')


