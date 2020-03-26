%% Generate LUT for all crystals
global doi_map
tic
load('C:\Users\xyche\Documents\MATLAB\APET_matlab\X_parameters\system_parameters\doi_map_2.mat')
toc

%% Plot DOI curves
for ii_panel = 1:12

    subplot(3,4,ii_panel)
xbin = 0:0.01:1;


hold on
for ii_crystal = 1:900
    fitresult = doi_map{ii_panel,ii_crystal};
    % Plot fit with data.
    
    h = plot(xbin, fitresult(xbin) );
%    legend( h, 'target_doi vs. r_doi_in_a_crystal_sorted', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
    % Label axes

end
hold off

xlabel( 'r_doi_in_a_crystal_sorted', 'Interpreter', 'none' );
ylabel( 'target_doi', 'Interpreter', 'none' );
grid on

end

%% Build LUT for DOI
DOI_BIN_NUM = 100;

DOI_LUT_Global = nan(12*900*DOI_BIN_NUM,1);
xbin = linspace(0,1,DOI_BIN_NUM);

for ii_panel = 1:12
for ii_crystal = 1:900
    fitresult = doi_map{ii_panel,ii_crystal};
    v = fitresult(xbin);
    idx_start = (ii_panel-1)*900*DOI_BIN_NUM + (ii_crystal-1)*DOI_BIN_NUM + 1;
    DOI_LUT_Global(idx_start:(idx_start+DOI_BIN_NUM-1)) = v;
end
end










%% DOI_BIN_NUM = 100;

rratio = point3s_local_raw(3,:);

tic
[DOI] = rratio2DOI_LUT(pID,cID,rratio);
toc
%%
tic
load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters\doi_LUT.mat'))
toc