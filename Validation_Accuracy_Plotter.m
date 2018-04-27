% Supplementary material to Suranga Ruhunusiri, "Identification of Plasma waves at Saturn 
% Using Convolutional Neural Networks", to be published in IEEE Transactions on Plasma Science, 2018.

% This program has been tested with MATLAB R2017a.

% The results shown in Figure 7 was plotted using this program.

% This program plots the validation accuracies determined
% from a 10-fold cross validation. 
% Prior to executing this program the user should create the array net_cross_val_performance 
% which contains the validation accuracies as a function of the CNN architecture parameters by executing
% CNN_trainer_and_ten_fold_cross_validator.m or load that array to MATLAB
% workspace. This array containing the results shown in Figure 7 of the
% manuscript is provided in the repository (net_cross_val_performance.mat).

%The user also needs to specify INPUT1 prior to executing this program

%INPUT1: Pool size selector. Specify values 1,2,3,or 4 to plot results
%corresponding to pool sizes of 4, 8, 16, or 32.
max_pool_s=1;

w_w_holder = zeros(10,6,6);
w_t_holder = zeros(10,6,6);
t_t_holder = zeros(10,6,6);
t_w_holder = zeros(10,6,6);



for i=1:10 

max_pool_1_cv_1_results_w_w=net_cross_val_performance(i,max_pool_s,:,:,1);
max_pool_1_cv_1_results_w_t=net_cross_val_performance(i,max_pool_s,:,:,2);
max_pool_1_cv_1_results_t_t=net_cross_val_performance(i,max_pool_s,:,:,3);
max_pool_1_cv_1_results_t_w=net_cross_val_performance(i,max_pool_s,:,:,4);

w_w_holder(i,:,:) = reshape(max_pool_1_cv_1_results_w_w,[6,6]);
w_t_holder(i,:,:) = reshape(max_pool_1_cv_1_results_w_t,[6,6]);
t_t_holder(i,:,:) = reshape(max_pool_1_cv_1_results_t_t,[6,6]);
t_w_holder(i,:,:) = reshape(max_pool_1_cv_1_results_t_w,[6,6]);

end

test_wave_accuracy = zeros(10,6,6);
test_turb_accuracy = zeros(10,6,6);
mean_accuracy = zeros(10,6,6);
for i=1:10
test_wave_accuracy(i,:,:) = 100*w_w_holder(i,:,:)./(w_w_holder(i,:,:)+w_t_holder(i,:,:));
test_turb_accuracy(i,:,:) = 100*t_t_holder(i,:,:)./(t_w_holder(i,:,:)+t_t_holder(i,:,:));
end

for i=1:10
mean_accuracy(i,:,:) = 0.5*(test_wave_accuracy(i,:,:)+test_turb_accuracy(i,:,:));
end

wave_accu_man=reshape(mean(test_wave_accuracy),[6,6]);
turb_accu_man=reshape(mean(test_turb_accuracy),[6,6]);
mean_accu_man = reshape(mean(mean_accuracy),[6,6]);

min_wave_accu_man=reshape(min(test_wave_accuracy),[6,6]);
min_turb_accu_man=reshape(min(test_turb_accuracy),[6,6]);
min_mean_accu_man = reshape(min(mean_accuracy),[6,6]);

max_wave_accu_man=reshape(max(test_wave_accuracy),[6,6]);
max_turb_accu_man=reshape(max(test_turb_accuracy),[6,6]);
max_mean_accu_man = reshape(max(mean_accuracy),[6,6]);


Max_pool_sel = [4,8,16,32];


f = figure;
p = uipanel('Parent',f,'BorderType','none'); 
p.Title = strcat('Validation accuracies for pool size = ',string(Max_pool_sel(1,max_pool_s))); 
p.TitlePosition = 'centertop'; 
p.FontSize = 12;
p.FontWeight = 'bold';
subplot(3,1,1,'Parent',p) ;
x_vec=[2,4,6,8,10,12]-0.9;
for i=1:6
hold on;
x_vec = x_vec+0.3;
errorbar(x_vec,wave_accu_man(i,:),(wave_accu_man(i,:)-min_wave_accu_man(i,:)),(max_wave_accu_man(i,:)-wave_accu_man(i,:)),'o');
title('wave identificaiton accuracy');
xlabel('number of filters M');
ylabel('validation accuracy (%)');
xticks([2 4 6 8 10 12]);
xticklabels({'2','4','8','16','32','64'});
end


subplot(3,1,2,'Parent',p) 
x_vec=[2,4,6,8,10,12]-0.9;
for i=1:6
hold on;
x_vec = x_vec+0.3;
errorbar(x_vec,turb_accu_man(i,:),(turb_accu_man(i,:)-min_turb_accu_man(i,:)),(max_turb_accu_man(i,:)-turb_accu_man(i,:)),'o');
title('turbulence identificaiton accuracy');
xlabel('number of filters M');
ylabel('validation accuracy (%)');
xticks([2 4 6 8 10 12]);
xticklabels({'2','4','8','16','32','64'});
end


subplot(3,1,3,'Parent',p) 
x_vec=[2,4,6,8,10,12]-0.9;
for i=1:6
hold on;
x_vec = x_vec+0.3;
errorbar(x_vec,mean_accu_man(i,:),(mean_accu_man(i,:)-min_mean_accu_man(i,:)),(max_mean_accu_man(i,:)-mean_accu_man(i,:)),'o');
title('average accuracy');
xlabel('number of filters M');
ylabel('validation accuracy (%)');
xticks([2 4 6 8 10 12]);
xticklabels({'2','4','8','16','32','64'});
end

lgd =legend('2','4','8','16','32','64');
title(lgd,'filter size N');


 [row,col]=find(mean_accu_man == max(max(mean_accu_man)))
 
 
 clearvars -except net_train_performance net_cross_val_performance wave_accu_man turb_accu_man mean_accu_man
