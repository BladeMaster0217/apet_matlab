function [DOI] = rratio2DOI_LUT(pID,cID,rratio)
%RRATIO2DOI_LUT Summary of this function goes here
%   Detailed explanation goes here
myPATHs = get_myPATHs();
load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters','doi_LUT.mat'))

Az_local = fix(rratio * DOI_BIN_NUM) + 1;

idx = Az_local>100;

Az_local(idx) = 100;

idx_cError = cID==0 | isnan(cID);
DOI_idx_global = (pID-1)*DOI_BIN_NUM*900 + (cID-1)*DOI_BIN_NUM + Az_local;
DOI_idx_global(idx_cError) = 1;

DOI = DOI_LUT_Global(DOI_idx_global)';
end

