% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a.

% This program performs a bootstrap testing on an already trained and
% validated CNN and plots the distributions of accuracies for wave and 
% turbulence identification as depicted in Figure 8 of the manuscript. 

% Prior to executing this program, the user should load an already trained
% CNN to MATLAB workspace. The CNN referred to as CNN1 in the manuscript is
% provided in the repository. 

% The user should also load the imagedatastore objects test_data_wav and 
% test_data_turb created by the Dataset_generator_for_CNN_TVT prior to executing this program.  

temp_boot_wave = [1:1:52];
temp_boot_turb = [1:1:2000];

[bootstat_wave,bootsam_wave] = bootstrp(1000,@corr,temp_boot_wave);
[bootstat_turb,bootsam_turb] = bootstrp(1000,@corr,temp_boot_turb);

 test_wave_lab = test_data_wav.Labels;
 test_wave_fil=test_data_wav.Files;

 test_turb_lab = test_data_turb.Labels;
 test_turb_fil=test_data_turb.Files;
 net_test_performance = zeros(1000,4);

for boot_inc=1:1000

cur_boot = boot_inc
    
    sel_wav = bootsam_wave(:,boot_inc);
    sel_turb = bootsam_turb(:,boot_inc);
    
    sel_lab_wav=test_wave_lab(sel_wav);
    sel_fil_wav = test_wave_fil(sel_wav);
    
    sel_lab_turb=test_turb_lab(sel_turb);
    sel_fil_turb = test_turb_fil(sel_turb);
    
    Test_set = imageDatastore(cat(1,sel_fil_wav,sel_fil_turb));
    Test_set.Labels = cat(1,sel_lab_wav,sel_lab_turb);
    
    imds_temp=shuffle(Test_set);
    
    testDigitData = imds_temp;

YTest2 = classify(convnetA, testDigitData);
TTest2 =   testDigitData.Labels;
TargetTr = zeros(length(TTest2),1);
OutputTr = zeros(length(TTest2),1);
wwat=find(TTest2 == 'wave');
wwao = find(YTest2 == 'wave');
TargetTr(wwat,1) = 1;
OutputTr(wwao,1) = 1;
net_test_performance(boot_inc,1) = length(find(TargetTr ==1 & OutputTr ==1));%*100/length(find(TargetTr ==1))
net_test_performance(boot_inc,2) = length(find(TargetTr ==1 & OutputTr ==0));%*100/length(find(TargetTr ==1)
net_test_performance(boot_inc,3) = length(find(TargetTr ==0 & OutputTr ==0));%*100/length(find(TargetTr ==0)
net_test_performance(boot_inc,4) = length(find(TargetTr ==0 & OutputTr ==1));%*100/length(find(TargetTr ==0)


end

wav_acc_bootstrap = zeros(1000,1);
turb_acc_bootstrap = zeros(1000,1);

for i=1:1000


wav_acc_bootstrap(i,1) = 100*net_test_performance(i,1)./(net_test_performance(i,1)+net_test_performance(i,2));

turb_acc_bootstrap(i,1) = 100*net_test_performance(i,3)./(net_test_performance(i,4)+net_test_performance(i,3));

end
f = figure;
p = uipanel('Parent',f,'BorderType','none'); 
p.Title = 'Bootstrap testing accuracies'
p.TitlePosition = 'centertop'; 
p.FontSize = 12;
p.FontWeight = 'bold';
subplot(2,1,1,'Parent',p) ;
histogram(turb_acc_bootstrap,10,'Normalization','probability','BinLimits',[min(min(turb_acc_bootstrap)),max(max(turb_acc_bootstrap))])
title('wave identificaiton accuracy (testing)');
xlabel('percentage accuracies');
ylabel('probability');
subplot(2,1,2,'Parent',p) ;
histogram(wav_acc_bootstrap,10,'Normalization','probability','BinLimits',[min(min(wav_acc_bootstrap)),max(max(wav_acc_bootstrap))])
title('turbulence identificaiton accuracy (testing)');
xlabel('percentage accuracies');
ylabel('probability');

quantile(wav_acc_bootstrap,[0.025 0.25 0.50 0.75 0.975])
quantile(turb_acc_bootstrap,[0.025 0.25 0.50 0.75 0.975])

clearvars -except bootsam_wave bootsam_turb test_data_wav test_data_turb