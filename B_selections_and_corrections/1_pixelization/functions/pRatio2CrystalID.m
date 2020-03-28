function cID = pRatio2CrystalID(points_rxry,pID)

myPATHs = get_myPATHs();

event_xy = points_rxry * 16;

cID = nan(1,size(points_rxry,2));

load(fullfile(myPATHs.PARAMETER_PATH,'system_parameters','LUT_struct_all_panels.mat'))

for ii_panel = 1:12
    idx_panel = pID == ii_panel;
    xy_data_pool = event_xy(:,idx_panel);
    
    
%     if ii_panel == 4
%         tmp = xy_data_pool(2,:);
%         idx = tmp>0;
%         tmp_2 = tmp;
%         tmp_2(idx) = tmp(idx)-16;
%         tmp_2(~idx) = tmp(~idx)+16;
%         
%         xy_data_pool(2,:) = -tmp_2;
%     end
    
    
    LUT_struct = LUT_struct_all_panels{ii_panel};
    cID(idx_panel) = getCrystalIDbyLUTmap(xy_data_pool,LUT_struct);
end
