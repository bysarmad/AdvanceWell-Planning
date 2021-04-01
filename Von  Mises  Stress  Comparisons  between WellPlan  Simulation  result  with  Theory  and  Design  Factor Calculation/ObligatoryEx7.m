
clc

dataset = xlsread('exceldata','Ark1','A2:H383');

L = dataset(:,1)';% Here I gave you example how to read depth from excel
Sigma_t =dataset(:,2)';% Here read the Hoop stress excel
Sigma_r =dataset(:,3)' ;% Here read the radial stress from excel
Sigma_T =dataset(:,4)' ; % Here read the torsional stress from excel
Sigma_a = dataset(:,5)'; % Here read the axial from excel
Sigma_b = dataset(:,6)'; % Here read the bending stress from excel
Sigma_VON_WP =dataset(:,7)'; % Here read the calculated Sigma_VON_WP from excel
Sigma_y =dataset(:,8)' ;  % Here read the sigma_y data from excel

%% Calculations
% Here I gave you example how to write the von Mises stress, without
% incliding torsional and bending stress
%Sigma_von1 = sqrt(0.5*((Sigma_t-Sigma_r).^2+(Sigma_r-Sigma_a).^2+(Sigma_a-Sigma_t).^2)); % Here I gave you example

% Here you need to write the von Mises stres...Sigma_von

Sigma_von = sqrt(0.5*((Sigma_t-Sigma_r).^2+(Sigma_r-(Sigma_a+Sigma_b)).^2+((Sigma_a+Sigma_b)-Sigma_t).^2)+3*(Sigma_T.^2)); % Following the above example, here you need to write the von Mises stress which uses the above input


%% Plotting

figure

subplot(1,2,1)
plot(Sigma_VON_WP,L,Sigma_von,L,Sigma_y,L)
set(gca,'Ydir','reverse')
xlabel('Stress [psi]')
ylabel('Depth [ft]') 
legend({'WellPlan','Theory','Yield Limit'},'FontSize',10,'location','northwest')



subplot(1,2,2)

% Design factor analysis%
% Norsok design factor requirement DF =1.25.

NDF =ones(1,382)*1.25;

% Definition of DF or SF 
% The calculated design factor should be higher than the minimum NORSOK
% requirement i.e greater than 1.25

DF= Sigma_y./Sigma_von;

plot(DF,L,NDF,L)
set(gca,'Ydir','reverse')
xlabel('Desing factor[]')
ylabel('Depth [ft]') 
legend({'Calculated DF','NORSOK DF'},'FontSize',10,'location','northeast')