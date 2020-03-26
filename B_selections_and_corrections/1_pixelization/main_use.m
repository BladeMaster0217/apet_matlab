clearvars -except myPATHs

%% Example
filename = 'exp_1hmin.mat';
filepath = myPATHs.SAMPLE_DATA_PATH;

filename_f = fullfile(filepath,filename);
load(filename_f)

%% Decode a detector
panel_data = coincidence_data_pool(1:16,:);
[point3s_local_raw,e,t,pID] = detector_panel_local_decoder(panel_data);

%% Use LUT to get crystal id
load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters\LUT_struct_all_panels.mat'))

%%
ii_panel = 1;
points2d = point3s_local_raw*16;
LUT_struct = LUT_struct_all_panels{ii_panel};
crystal_id = getCrystalIDbyLUTmap(points2d,LUT_struct);

%%
%
clf
hold on
%scatter(all_events(1,:),all_events(2,:),1,mod(color_list,4))
scatter(points2d(2,1:100000),points2d(1,1:100000),2,mod(crystal_id(1:100000),4),'filled','MarkerFaceAlpha',0.4)
hold off
axis equal
xlim([-17 17])
ylim([-17 17])

