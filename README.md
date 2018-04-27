# Supplementary-Material-for-Identification-of-Plasma-Waves-at-Saturn-Using-Convolutional-Neural-Nets
This repository contains supplementary material to Suranga Ruhunusiri, "Identification of Plasma Waves at Saturn Using Convolutional Neural Networks", submitted to IEEE Transactions on Plasma Science, 2018.

The repository contains:
I. MATLAB programs for generating data sets for training, validating, and testing a Convolutional Neural Network,
II. MATLAB programs for training, validation, and testing a Convolutional Neural Network, and
III. Data for figures in the manuscript. 
Detail descriptions of the files are provided below:

1. An Excel file with times where whistler precursor waves are identified in the upstream region of Saturn: 
   Whistler_precursor_wave_event_times [27 KB]

2. A MATLAB program to read Cassini 1-second averaged MAG data file, load data into MATLAB Workspace, and 
   save MAG data as a .mat file: Cassini_MAG_Reader.m [3 KB]

3. A sample Cassini 1-second averaged calibrated MAG data file in .TAB format 
   (contains MAG data from Nov 08, 2004 to Nov 09, 2004): 04313_04314_0A_FGM_KSO_1S.TAB [11.4MB]

4. Two samples of Cassini 1-second averaged calibrated MAG data files in .mat format 
   (contains MAG data from Nov 08, 2004 to Nov 09, 2004 and Jul 26, 2007 to Jul 28, 2007): 
   Mag_1s_data_2004_Nov_08_to_Nov_09.mat [1.54 MB] & Mag_1s_data_2007_Jul_26_to_Jul_28.mat [2 MB]

5. A MATLAB program to plot Cassini MAG data: Cassini_MAG_Data_Plotter.m [2 KB]

6. A MATLAB program to save MAG time series with waves as 1D 8-bit RGB JPEG images: Cassini_MAG_Data_to_JPEG_Image_Converter_Wave.m [5 KB]

7. A MATLAB program to save MAG time series with turbulence as 1D 8-BIT RGB JPEG images:  
   Cassini_MAG_data_to_JPEG_Image_Converter_Turb.m [5 KB]

8. A folder containing JPEG images for training, validating, and testing a Convolutional Neural Network: CNN_TVT [62.8 MB]

9. A MATLAB program for generating image data store objects for training, validation, and testing of CNNs: 
    Dataset_generator_for_CNN_TVT.mat [11 KB]

10. A MATLAB program for training CNNs and performing 10-fold cross validation: CNN_trainer_and_ten_fold_cross_validator.m [7 KB]  
 
11. A CNN referred to as CNN1 in the manuscript: CNN1.mat [19 KB].

12. Validation accuracy data determined from a 10-fold cross validation for 144 different CNN architectures shown in Figure 7 of the manuscript in .mat format: ten_fold_cross_validation_results.mat [4 KB]

13. A MATLAB program for plotting the validation accuracies as a function of the CNN architecture parameters as shown in Figure 7 of the manuscript: Validation_Accuracy_Plotter.m [5 KB]

14. A MATLAB program for bootstrap testing a CNN and plotting results as shown in Figure 8 of the manuscript: CNN_bootstrap_tester_and_results_plotter.m [4 KB]

15. Bootstrap testing data for CNN1 shown in Figure 8 of the manuscript in .mat format: bootstrap_testing_results.mat [2 KB]

