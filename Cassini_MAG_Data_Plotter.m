% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma Waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a on Windows 10.

% This program plots the Cassini 1-second averaged MAG data for a specified
% time range.

% Before executing this program, the user should perform the following tasks:
% 1. Run Cassini_MAG_Reader.m
%    or load .mat file containing MAG data produced by Cassini_MAG_Reader.m into MATLAB Workspace 
%    (for example load Mag_1s_data_2004_Nov_08_to_Nov_09.mat provide with the repository) 
%
% 2. Specify the time range to plot by setting the start date (SDate) and
%    the stop date (EDate) in [year, month, day, hour, minute, second] format

%The following example times are specified assuming that Mag_1s_data_2004_Nov_08_to_Nov_09.mat has
%been loaded into the MATLAB workspace
SDate = [2004,11,8,2,32,0]; %<--specify the start date for plotting here       
EDate = [2004,11,8,2,34,0]; %<--specify the end date for plotting here 
           
        row_select = 1;
      
start_date = datenum(SDate(row_select,1),SDate(row_select,2),SDate(row_select,3),SDate(row_select,4),SDate(row_select,5),SDate(row_select,6));
end_date = datenum(EDate(row_select,1),EDate(row_select,2),EDate(row_select,3),EDate(row_select,4),EDate(row_select,5),EDate(row_select,6));

indices = find(Date_num > start_date & Date_num < end_date); 

Date_now = Date_num(indices,1);
Bx_now = Bx(indices,1);
By_now = By(indices,1);
Bz_now = Bz(indices,1);
Bmag_now = B_mag(indices,1);

figure
subplot(4,1,1)
plot(Date_now,Bx_now)
title('B_X KSO')
datetick('x','HH:MM:SS')
subplot(4,1,2)
plot(Date_now,By_now)
title('B_Y KSO')
datetick('x','HH:MM:SS')
subplot(4,1,3)
plot(Date_now,Bz_now)
title('B_Z KSO')
datetick('x','HH:MM:SS')
subplot(4,1,4)
plot(Date_now,Bmag_now)
title('|B| KSO')

datetick('x','HH:MM:SS')

clearvars -except Bx By Bz B_mag Date_num;