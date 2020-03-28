clc
filepath = '/mnt/NetDisks/Xinyi_Server/A-PET/experimental data/03-15-2020 point_source_3d/4x4x4';
filepath = 'D:\APET_DATA\03-15-2020 point_source_3d\4x4x4';
filepath = '/media/xinyi/LABDESK_2TB/APET/APET_DATA/';
filepath = '/media/xinyi/LABDESK_2TB/APET/APET_DATA/02-19-2020 ultramicro phantom/ultramicro_high_activity/';
%% Prepare paths
path_raw = fullfile(filepath,'raw');
path_processed = fullfile(filepath,'processed_rndn=0.1');
if ~exist(path_processed,'dir')
    mkdir(path_processed);
end

%% Bulk process
parfor ii_file = 1:300
    ii_file
    filename = sprintf('exp_%dhmin.mat',ii_file);
    filename_f = fullfile(path_raw,filename);
    LORs_output = process_a_raw_file(filename_f);
    
    
    filename = sprintf('exp_processed_%d.mat',ii_file);
    filename_f = fullfile(path_processed,filename);
    save_LORs(filename_f,LORs_output)
    
%     LORs = LORs_output';
%     event_numer = 100;
%     clf
%     hold on
%     
%     for ii_lor = 1:event_numer
%         line_data = [LORs(ii_lor,1:3); LORs(ii_lor,4:6)];
%         patchline(line_data(:,1),line_data(:,2),line_data(:,3),'edgealpha',0.2)
%     end
%     
%     hold off
%     
%     box on
%     axis equal
%     xlim([-90 90])
%     ylim([-90 90])
%     drawnow
end

%% Bulk save as one
filename = 'output.blst';
filename_f = fullfile(path_processed,filename);

if exist(filename_f,'file')
    delete(filename_f);
end

fileID = fopen(filename_f,'w');

for ii_file = 1:300
    ii_file
    filename = sprintf('exp_processed_%d.mat',ii_file);
    filename_f = fullfile(path_processed,filename);
    load(filename_f)
    
    fwrite(fileID,LORs_output,'float');

end
fclose(fileID);

%% Random input and output

listmode_filename = 'output.blst';
filename_f = fullfile(path_processed,listmode_filename);

fid = fopen(filename_f,'r');
LORs_input = single(fread(fid,'float'));
fclose(fid);

%%
listmode_filename = 'output_rand.blst';
ofilename = fullfile(path_processed,listmode_filename);
if exist(ofilename,'file')
    delete(ofilename)
end
LORs_input = reshape(LORs_input,6,[]);

%%
idx = randperm(length(LORs_input));


%%
LORs_output = LORs_input(:,idx);

%%
    LORs = LORs_output';
    event_numer = 200;
    clf
    hold on
    
    for ii_lor = 1:event_numer
        line_data = [LORs(ii_lor,1:3); LORs(ii_lor,4:6)];
        patchline(line_data(:,1),line_data(:,2),line_data(:,3),'edgealpha',0.2)
    end



%%
listmode_filename = 'output_rand.blst';
ofilename = fullfile(path_processed,listmode_filename);
if exist(ofilename,'file')
    delete(ofilename)
end
fileID = fopen(ofilename,'w');
fwrite(fileID,LORs_output,'float');
fclose(fileID);