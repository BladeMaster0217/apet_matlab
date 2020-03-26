function idx_t = timing_selection(time_stamp_A,e_max_ch_A,time_stamp_B,e_max_ch_B)
%TIMING_CORRECTIONANDSELECTION Summary of this function goes here
%   Detailed explanation goes here
ppp = 140000;
time_diff_adj = ppp./(e_max_ch_A.^2) - ppp./(e_max_ch_B.^2);
time_diff = (time_stamp_A - time_stamp_B)/256*5 - time_diff_adj;

xbin = -1000:1:1000;
n = hist(time_diff,xbin);

idx_t = abs(time_diff)<10;
end

