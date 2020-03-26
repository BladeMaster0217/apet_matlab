%%

xbin = 0:10:2000;
for ii_panel = 1:12

        idx_p = pID_A == ii_panel;
        idx_A = idx_p & idx_t;
        idx_p = pID_B == ii_panel;
        idx_B = idx_p & idx_t;
%         hist([e_A(idx_A) e_B(idx_B)],xbin)
        energy = [e_A(idx_A) e_B(idx_B)];
        [fitresult_511] = fit_expANDgaussian_2(energy);

        peak_panels(ii_panel) = fitresult_511.b1;
end

clf

RAW_peaks = peak_panels;
TARGET_peaks = LUT_511_info_byPanel(:,1);
energy_gain_correction = sum(RAW_peaks)/sum(TARGET_peaks);

hold on
plot(LUT_511_info_byPanel(:,1),'red')
plot(RAW_peaks,'blue')
plot(RAW_peaks/energy_gain_correction,'--b','LineWidth',2)
hold off


%%
clf
energy_gain_correction = panel_gain_correction(e_B,pID_B,idx_t);