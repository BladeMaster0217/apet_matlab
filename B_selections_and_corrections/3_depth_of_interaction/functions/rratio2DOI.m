function doi_corrected = rratio2DOI(raw_doi,pID,cID)

global doi_map
% 
% BASE_PATH = '/mnt/NetDisks/Xinyi_Server/A-PET/rawdata_processing/matlab/';
% load([BASE_PATH 'Z_data/system_parameters/doi_map_2.mat'])


doi_corrected = nan(size(raw_doi));

for ii_panel = 1:12

    idx_panel = pID==ii_panel;
    
    raw_doi_panel = raw_doi(idx_panel);
    
    doi_panel = nan(size(raw_doi_panel));
    
    cID_panel = cID(idx_panel);
for ii_crystal = 1:900
%    ii_crystal
    idx_crystal = cID_panel==ii_crystal;
    raw_doi_crystal = raw_doi_panel(idx_crystal);

    ft = doi_map{ii_panel,ii_crystal};

    doi_crystal = ft(raw_doi_crystal);
    
   doi_panel(idx_crystal) = doi_crystal;    
end

    doi_corrected(idx_panel) = doi_panel;
end

end