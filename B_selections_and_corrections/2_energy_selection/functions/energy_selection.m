function idx_e = energy_selection(e,c_global_id)
%ENERGY_SELECTION Summary of this function goes here
%   Detailed explanation goes here
myPATHs = get_myPATHs();
load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters','energy_window_byCrystal_2.mat'))


e_window = e*0;
idx = c_global_id>0;
e_window(1,idx) = peaks_byCrystal(c_global_id(idx)) - fwhms_byCrystal(c_global_id(idx))/2;
e_window(2,idx) = peaks_byCrystal(c_global_id(idx)) + fwhms_byCrystal(c_global_id(idx));

idx_e = (e)>e_window(1,:) ...
        & (e)<e_window(2,:);
    
    
end

