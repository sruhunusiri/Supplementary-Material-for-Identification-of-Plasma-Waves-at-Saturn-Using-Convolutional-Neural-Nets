% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma Waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a on Windows 10.

% This program creates image datastore objects for performing CNN 10-fold cross validation and testing 

% Before executing this program, the user should specify INPUT1
% below.

%INPUT1:image folder 
%location of wave and turbulence images for training, validation, and
%testing of a CNN. The user may use the images already provided in the CNN_TVT folder in the repository 
image_folder = 'C:\CNN_TVT\';


 imds_waves=imageDatastore(fullfile(image_folder, {'wave'}),...
    'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});
 imds_turb=imageDatastore(fullfile(image_folder, {'turb'}),...
    'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

 testNumFiles=52; %Number of wave images allocated for testing 
 train_and_validate_NumFiles = 282-(testNumFiles); %Number of wave images allocated for training and validation

 %separate wave images into to training and validation data set and a
 %testing set 
 [train_and_val_data_wav,test_data_wav] = splitEachLabel(imds_waves, ...
  				 train_and_validate_NumFiles,testNumFiles,'randomize');
 
 %create 10-fold cross validation data set for waves       
 split_data = 23;%Number of wave images alloacated for each cross-validation data set 
 [CC_wave1,CC_wave2,CC_wave3,CC_wave4,CC_wave5,CC_wave6,CC_wave7,CC_wave8,CC_wave9,CC_wave10] = splitEachLabel(train_and_val_data_wav, ...
  split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data,'randomize');
             
                   
 testNumFiles=2000; %Number of turbulence images alloacted for testing
 train_and_validate_NumFiles = 8000; %Number of turbulence images allocated for training and validation
 extraNumFiles =  36909- (testNumFiles+train_and_validate_NumFiles);

 %separate turbulence images into to training and validation data set and a
 %testing set
 [train_and_val_data_turb,test_data_turb,extra_turb] = splitEachLabel(imds_turb, ...
  				train_and_validate_NumFiles,testNumFiles,extraNumFiles,'randomize');
            
 split_data = 800;%Number of turbulence images alloacated for each cross-validation data set 
 [CC_turb1,CC_turb2,CC_turb3,CC_turb4,CC_turb5,CC_turb6,CC_turb7,CC_turb8,CC_turb9,CC_turb10,] = splitEachLabel(train_and_val_data_turb, ...
  				  split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data, split_data,'randomize');
             
             
%Create image datastores for each of the cross validaion data sets            
CC_wav_turb1 = imageDatastore(cat(1,CC_wave1.Files,CC_turb1.Files));
CC_wav_turb1.Labels = cat(1,CC_wave1.Labels,CC_turb1.Labels);

CC_wav_turb2 = imageDatastore(cat(1,CC_wave2.Files,CC_turb2.Files));
CC_wav_turb2.Labels = cat(1,CC_wave2.Labels,CC_turb2.Labels);

CC_wav_turb3 = imageDatastore(cat(1,CC_wave3.Files,CC_turb3.Files));
CC_wav_turb3.Labels = cat(1,CC_wave3.Labels,CC_turb3.Labels);

CC_wav_turb4 = imageDatastore(cat(1,CC_wave4.Files,CC_turb4.Files));
CC_wav_turb4.Labels = cat(1,CC_wave4.Labels,CC_turb4.Labels);

CC_wav_turb5 = imageDatastore(cat(1,CC_wave5.Files,CC_turb5.Files));
CC_wav_turb5.Labels = cat(1,CC_wave5.Labels,CC_turb5.Labels);

CC_wav_turb6 = imageDatastore(cat(1,CC_wave6.Files,CC_turb6.Files));
CC_wav_turb6.Labels = cat(1,CC_wave6.Labels,CC_turb6.Labels);

CC_wav_turb7 = imageDatastore(cat(1,CC_wave7.Files,CC_turb7.Files));
CC_wav_turb7.Labels = cat(1,CC_wave7.Labels,CC_turb7.Labels);

CC_wav_turb8 = imageDatastore(cat(1,CC_wave8.Files,CC_turb8.Files));
CC_wav_turb8.Labels = cat(1,CC_wave8.Labels,CC_turb8.Labels);

CC_wav_turb9 = imageDatastore(cat(1,CC_wave9.Files,CC_turb9.Files));
CC_wav_turb9.Labels = cat(1,CC_wave9.Labels,CC_turb9.Labels);

CC_wav_turb10 = imageDatastore(cat(1,CC_wave10.Files,CC_turb10.Files));
CC_wav_turb10.Labels = cat(1,CC_wave10.Labels,CC_turb10.Labels);

%Image datastore creation for training and validation data for the
%iteration 1/10 of the 10-fold cross validation 
Cross_train1 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files));
Cross_train1.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels);

Cross_val1 = CC_wav_turb10;
Cross_val1.Labels = CC_wav_turb10.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 2/10 of the 10-fold cross validation 
Cross_train2 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb10.Files));
Cross_train2.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb10.Labels);

Cross_val2 = CC_wav_turb9;
Cross_val2.Labels = CC_wav_turb9.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 3/10 of the 10-fold cross validation 
Cross_train3 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train3.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val3 = CC_wav_turb8;
Cross_val3.Labels = CC_wav_turb8.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 4/10 of the 10-fold cross validation 
Cross_train4 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train4.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val4 = CC_wav_turb7;
Cross_val4.Labels = CC_wav_turb7.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 5/10 of the 10-fold cross validation 
Cross_train5 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train5.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val5 = CC_wav_turb6;
Cross_val5.Labels = CC_wav_turb6.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 6/10 of the 10-fold cross validation 
Cross_train6 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train6.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val6 = CC_wav_turb5;
Cross_val6.Labels = CC_wav_turb5.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 7/10 of the 10-fold cross validation 
Cross_train7 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train7.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val7 = CC_wav_turb4;
Cross_val7.Labels = CC_wav_turb4.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 8/10 of the 10-fold cross validation 
Cross_train8 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb2.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train8.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb2.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val8 = CC_wav_turb3;
Cross_val8.Labels = CC_wav_turb3.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 9/10 of the 10-fold cross validation 
Cross_train9 =imageDatastore(cat(1,CC_wav_turb1.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train9.Labels = cat(1,CC_wav_turb1.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val9 = CC_wav_turb2;
Cross_val9.Labels = CC_wav_turb2.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Image datastore creation for training and validation data for the
%iteration 10/10 of the 10-fold cross validation 
Cross_train10 =imageDatastore(cat(1,CC_wav_turb2.Files,CC_wav_turb3.Files,CC_wav_turb4.Files,CC_wav_turb5.Files,CC_wav_turb6.Files,CC_wav_turb7.Files,CC_wav_turb8.Files,CC_wav_turb9.Files,CC_wav_turb10.Files));
Cross_train10.Labels = cat(1,CC_wav_turb2.Labels,CC_wav_turb3.Labels,CC_wav_turb4.Labels,CC_wav_turb5.Labels,CC_wav_turb6.Labels,CC_wav_turb7.Labels,CC_wav_turb8.Labels,CC_wav_turb9.Labels,CC_wav_turb10.Labels);

Cross_val10 = CC_wav_turb1;
Cross_val10.Labels = CC_wav_turb1.Labels;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except Cross_train1 Cross_val1 Cross_train2 Cross_val2 Cross_train3 Cross_val3 Cross_train4 Cross_val4 Cross_train5 Cross_val5 Cross_train6 Cross_val6 Cross_train7 Cross_val7 Cross_train8 Cross_val8 Cross_train9 Cross_val9 Cross_train10 Cross_val10;