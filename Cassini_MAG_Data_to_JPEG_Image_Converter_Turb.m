% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a.

% This program generates 1D 8-bit RGB JPEG images from Cassini time series data for
% CNN training, validation, and testing. This program was specifically used to generate
% JPEG images of background turbulence in the folder "CNN_TVT" provided in the repository.


% Before executing this program, the user should load Cassini MAG data to 
% the MATLAB workspace (for example load Mag_1s_data_2007_Jul_26_to_Jul_28.mat provided in the repository)
% and specify INPUT1-INPUT7 below.

%INPUT1:train_folder 
%location to save the training image set
image_folder = 'C:\Cassini\CNN_TVT\turb\';

%INPUT2:st_fil
% variable for specifying the start index for image file name. 
% If you want to start the file name index with 1 use the default value of 0.
st_fil=0; 

%INPUT3:SDate
%Matrix of start times corresponding to background turbulence 
%The following example times are specified assuming that Mag_1s_data_2007_Jul_26_to_Jul_28.mat has
%been loaded into the MATLAB workspace
SDate = [   [2007,7,26,1,0,0];...
            %[2007,7,28,0,0,0];...
            
         ];
            
%INPUT4:EDate
%Matrix of end times corresponding to background turbulence  
%The following example times are specified assuming that Mag_1s_data_2007_Jul_26_to_Jul_28.mat has
%been loaded into the MATLAB workspace
EDate = [   [2007,7,26,24,0,0];...
            %[2007,7,28,24,0,0];...
            
            ];

      
 for row_select=1:length(EDate(:,1))
        num_wav = length(row_select);

        start_date = datenum(SDate(row_select,1),SDate(row_select,2),SDate(row_select,3),SDate(row_select,4),SDate(row_select,5),SDate(row_select,6));
        end_date = datenum(EDate(row_select,1),EDate(row_select,2),EDate(row_select,3),EDate(row_select,4),EDate(row_select,5),EDate(row_select,6));

        time_duration = end_date-start_date;
        sam = (time_duration*24.0*3600.0-120.0)/120;
        sam = sam-mod(sam,1);

        for i=1:sam
            
            start_date_now = start_date*24.0*3600.0 + 120.0*(i-1);
            end_date_now = start_date_now+120.0;
            start_date_now = start_date_now/(24.0*3600.0);
            end_date_now = end_date_now/(24.0*3600.0);
            indices = find(Date_num > start_date_now & Date_num < end_date_now); 
            Date_now = Date_num(indices,1);
            
            Bx_now = Bx(indices,1);
            By_now = By(indices,1);
            Bz_now = Bz(indices,1);
            Bmag_now = B_mag(indices,1);
            
            Bx_now = transpose(Bx_now);
            By_now = transpose(By_now);
            Bz_now = transpose(Bz_now);
            Bmag_now = transpose(Bmag_now);

            if length(Bz_now) == 120 
    
                Wave_nowx = Bx_now-mean(Bx_now);
                Wave_nowy = By_now-mean(By_now);
                Wave_nowz = Bz_now-mean(Bz_now);
                rms_holder_now = sqrt((rms(Wave_nowx))^2 +(rms(Wave_nowy))^2+(rms(Wave_nowz))^2)/3.0;
 
                Wave_now = Bx_now-min(Bx_now);
                Wave_now = Wave_now/max(Wave_now);
                Wave_now_x = Wave_now;
     
                Wave_now = By_now-min(By_now);
                Wave_now = Wave_now/max(Wave_now);
                Wave_now_y = Wave_now;
    
                Wave_now = Bz_now-min(Bz_now);
                Wave_now = Wave_now/max(Wave_now);
                Wave_now_z = Wave_now;
    
                rgb_pic=zeros(1,120,3);
 
                rgb_pic(:,:,1) =  Wave_now_x;
                rgb_pic(:,:,2) =  Wave_now_y;
                rgb_pic(:,:,3) =  Wave_now_z;
    
                file_ex = char(strcat(image_folder,'turb',string(i+st_fil),'.jpg'));

                imwrite(rgb_pic,file_ex);

            end
        end

st_fil =st_fil+sam;

        end