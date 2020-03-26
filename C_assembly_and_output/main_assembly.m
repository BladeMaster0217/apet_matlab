%% Example
myPATHs = get_myPATHs();

%% Load data
filename = 'exp_1hmin.mat';
filepath = myPATHs.SAMPLE_DATA_PATH;

filename_f = fullfile(filepath,filename);
load(filename_f)

%% Decode a detector
[gpos_A,e_A,pID_A,cID_global_A,t_A,em_A] = panelProcessor(coincidence_data_pool(1:16,:));
[gpos_B,e_B,pID_B,cID_global_B,t_B,em_B] = panelProcessor(coincidence_data_pool(17:32,:));

%% Calibration Time & Time Selection
% input: time_difference, time window
% output: idx_t
idx_t = timing_selection(t_A,em_A,t_B,em_B);


%% Calibration Energy
% gain_measurement
energy_gain_correction = panel_gain_correction(e_B,pID_B,idx_t);
% gain_calibration
e_A_corrected = e_A * energy_gain_correction;
e_B_corrected = e_B * energy_gain_correction;


%% Selection
% Energy Selection
%   Input: energy, global_crystal_id, energy_window
%   Output: idx_e
idx_e_A = energy_selection(e_A_corrected,cID_global_A);
idx_e_B = energy_selection(e_B_corrected,cID_global_B);
idx_e = idx_e_A & idx_e_B;

% Nan selection
LORs = [gpos_A; gpos_B;];
idx_notnan = ~isnan(sum(LORs));

%%
idx = idx_t & idx_e & idx_notnan;

LORs_output = LORs(:,idx);

%% Draw LORs
EVENTNUM2DRAW = 1000;
LORs_2_draw = datasample(LORs_output,EVENTNUM2DRAW,2);

for ii = 1:EVENTNUM2DRAW
    LOR = [LORs_2_draw(1:3,ii) LORs_2_draw(4:6,ii)];
    patchline(LOR(1,:),LOR(2,:),LOR(3,:),'EdgeAlpha',0.01,'LineWidth',2)
end
axis equal

xlim([-90 90])
ylim([-90 90])
