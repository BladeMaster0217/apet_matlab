function myPATHs = get_myPATHs()
%% PATH definitions
% Get current computer name
computer_name = char(java.net.InetAddress.getLocalHost.getHostName);

switch(computer_name)
    case 'XC-OPTIPLEX9020'
        BASE_PATH = 'C:\Users\xyche\Documents\MATLAB\APET_matlab';
    case 'xinyi-OptiPlex-7060'
        BASE_PATH = '/media/xinyi/LABDESK_2TB/APET/APET_matlab';
    otherwise
        disp('Cannot identify current computer.')
end
myPATHs.BASE_PATH = BASE_PATH;

% Sample data of an Ultramicro phantom.
SAMPLE_DATA_PATH = fullfile(BASE_PATH,'Z_Data','sample_data');
myPATHs.SAMPLE_DATA_PATH = SAMPLE_DATA_PATH;

PARAMETER_PATH = fullfile(BASE_PATH,'X_parameters');
myPATHs.PARAMETER_PATH = PARAMETER_PATH;


%%
