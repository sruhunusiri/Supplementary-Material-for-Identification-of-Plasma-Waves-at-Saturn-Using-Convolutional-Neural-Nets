% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma Waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a on Windows 10.

% This program will read a Cassini 1-second averaged MAG data file, load data  
% into MATLAB Workspace, and save them as .mat file. 

% Before executing the code, the user should edit INPUT 1 and INPUT 2
% below.

% INPUT 1: data_file: location of the Cassini MAG data file. 
%          A sample MAG data file is provided in the repository (contains MAG data from Nov 08, 2004 to Nov 09, 2004): 04313_04314_0A_FGM_KSO_1S.TAB
%          The latest Cassini 1-second averaged calibrated MAG data can be downloaded from 
%          https://pds-ppi.igpp.ucla.edu/search/view/?f=yes&id=pds://PPI/CO-E_SW_J_S-MAG-4-SUMM-1SECAVG-V1.0/DATA 

data_file = 'C:\Cassini\04313_04314_0A_FGM_KSO_1S.TAB';


% INPUT 2: output_file: location of the MAG data to be saved in .mat format. 
%          This .mat file will contain row matrices for B_x, B_y, B_z, |B|,
%          and date in seconds.

output_file = 'C:\Cassini\Mag_1s_data_2004_Nov_08_to_Nov_09.mat';

FID = fopen(data_file, 'r');
data = textscan(FID,'%s %f %f %f %f %f');
fclose(FID);

time = cell2mat(data{1,1});
Bx = data{1,2};
By = data{1,3};
Bz = data{1,4};
B_mag = data{1,5};

Year = zeros(size(Bx,1),1);
Month = zeros(size(Bx,1),1);
Day = zeros(size(Bx,1),1);
hour = zeros(size(Bx,1),1);
mint = zeros(size(Bx,1),1);
sec = zeros(size(Bx,1),1);
Date_num = zeros(size(Bx,1),1);

for i=1:size(Bx,1)
  
    Year(i,1) = str2double(time(i,1:4));
    Month(i,1) = str2double(time(i,6:7));
    Day(i,1) = str2double(time(i,9:10));
    hour(i,1) = str2double(time(i,12:13));
    mint(i,1) = str2double(time(i,15:16));
    sec(i,1) = str2double(time(i,18:21));
    Date_num(i,1) = datenum(Year(i,1),Month(i,1),Day(i,1),hour(i,1),mint(i,1),sec(i,1));
end

save(output_file,'Bx','By','Bz','B_mag','Date_num','-v7.3');

clearvars -except Bx By Bz B_mag Date_num;