function energy_gain_correction = panel_gain_correction(e,pID,idx_t)
%PANEL_GAIN_CORRECTION Summary of this function goes here
%   Detailed explanation goes here
for ii_panel = 1:12
        idx_p = pID == ii_panel;
        idx = idx_p & idx_t;

        energy = e(idx);
        [fitresult_511] = fit_expANDgaussian_2(energy);

        peak_panels(ii_panel) = fitresult_511.b1;
end

myPATHs = get_myPATHs();
load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters','energy_window_byCrystal_2.mat'))
TARGET_peaks = LUT_511_info_byPanel(:,1);

RAW_peaks = peak_panels;

energy_gain_correction = sum(TARGET_peaks)/sum(RAW_peaks);

hold on
plot(LUT_511_info_byPanel(:,1),'red')
plot(RAW_peaks,'blue')
plot(RAW_peaks*energy_gain_correction,'--b','LineWidth',2)
hold off
end

