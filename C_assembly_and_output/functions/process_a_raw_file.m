function LORs_output = process_a_raw_file(filename_f)
%PROCESS_A_RAW_FILE Summary of this function goes here
%   Detailed explanation goes here
load(filename_f)
%% Decode a detector
[gpos_A,e_A,pID_A,cID_global_A,t_A,em_A] = panelProcessor(coincidence_data(1:16,:));
[gpos_B,e_B,pID_B,cID_global_B,t_B,em_B] = panelProcessor(coincidence_data(17:32,:));

idx_p = pID_A == 4 | pID_B == 4;

clear coincidence_data_pool
%% Calibration Time & Time Selection
% input: time_difference, time window
% output: idx_t
idx_t = timing_selection(t_A,em_A,t_B,em_B);


%% Calibration Energy
% gain_measurement
%energy_gain_correction = panel_gain_correction(e_B,pID_B,idx_t);
energy_gain_correction = 1.19;
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
end

