clc, clear all

%Guide 
%This will calculate ECD and pressure loss using NEWTONIAN and BINGHAM flow models''
% Use this for Obligatory Ex. #8
% Use this and modify..to answer the two tasks given in Obligatory Ex.8

% ==========Input parameters=============================================== 
% Drilling fluid viscometer data

Q600=98 ; % Here insert the value of Viscomenter data at RPM =600
Q300 =58; %Here insert the value of Viscomenter data at RPM =300
Q200 =46;%Here insert the value of Viscomenter data at RPM =200
Q100 =32;%Here insert the value of Viscomenter data at RPM =100
Q6= 10; %Here insert the value of Viscomenter data at RPM =6
Q3 =8 ;%Here insert the value of Viscomenter data at RPM =3

% Density of drilling fluid/rho = ppg

rho = 11;%Here insert the density of the drilling fluid in ppg

%geometry// inch
dw = 10.711; % Here insert the size of the wellbore
do = 5; % Here insert the Outer diameter of the drill pipe
dp = 4.5; %Here insert the Inner diameter of the drill pipe

L = 11000; %Length of the well

% Bit data
dn1 =28;  % Here insert only 28. 
dn2 =28;%
dn3 =28;%

%Surface pressure loss

DPsurf = 250; % Here insert surface pressure loss

% WellStability limits

Collapse= 11.5;        % Here insert collapse pressure
Fracture= 12;          % Here insert collapse pressure

%flow rate // GPM (gall per minuits)

Qr =[];

% for total pressure losses Newtonian and Bingham models

DP_tot_Newtr =[];
DP_tot_bingr =[];
 
% for total pressure losses Newtonian and Bingham models in annulus to be
% used for ECD
DP_a_Newtr =[];
DP_a_bingr =[];

% Pipe pressure losses Newtonian and Bingham models 
DP_p_Newtr =[];
DP_p_bingr =[];

% Pipe pressure through bit nozzle for both Newtonian and Bingham models 

DP_bitr =[];

% Well stability limits

Collapse_r=[];
Fracture_r=[];

% ECD density calculation using Newtonian and Bingham models 

rho_rB=[];
rho_rN=[];

i=0;
for Q=100:650;

%//////////////////////////////////////////////////////////////////////////

% Newtonian model Newtonian modelNewtonian modelNewtonian modelNewtonian model

%/////////////////////////////////////////////////////////////////////////


%=======================
% Flow in Pipe
%========================

%Velocity in pipe

vp_Newt =0.408*Q/(dp^2);

%Apparent viscosity 

ma_Newt = Q300;

%Reynolds number

Nre_Newt =928*dp*vp_Newt*rho/ma_Newt;

if Nre_Newt  <2000;
    
  f_Newt_p=16/Nre_Newt ;
    
else         
       f_Newt_p=0.0791/Nre_Newt ^0.25;
end 

% Pressure loss in pipe

DP_P_Newt =  f_Newt_p*rho*(vp_Newt).^2/(25.81*dp)*L;


%================================================
% Annular flow (Newtonian)
%================================================

% Annular flow velocity

va_Newt =0.408*Q/(dw.^2-dp.^2);



%Apparent viscosity 

ma_Newt = Q300;


%Reynolds number


Nre_Newt_a =757*(dw-dp)*va_Newt*rho/ma_Newt;

if Nre_Newt_a  <2000;
    
     f_Newt_a=16/Nre_Newt_a ;
    
else
    
    f_Newt_a=0.0791/Nre_Newt_a^0.25;

end 

DP_A_Newt =  f_Newt_a*rho*(va_Newt)^2/(25.81*(dw-dp))*L;


% Bit pressure loss

DP_bit =156*rho*Q.^2/(dn1.^2+dn2.^2+dn3.^2)^2;




% Total pressure loss DP = DPsrf + DPds  + DPb + DPa

DP_tot_Newt = DP_A_Newt + DP_P_Newt+DP_bit+DPsurf;

% ECD

ECDN = rho+DP_A_Newt/(0.052*L);


  
%//////////////////////////////////////////////////////////////////////////

% Bingham model% Bingham model% Bingham model% Bingham model% Bingham model

%//////////////////////////////////////////////////////////////////////////

%=======================
% Flow in Pipe
%========================

% velocity

vp_bing_p =0.408*Q/(dp.^2);

%apparent viscoicty

mp_bing = Q600-Q300;

ty_bing= Q300-mp_bing;

ma_bing = mp_bing+5*ty_bing*dp/vp_bing_p;


%Reynolds number

i=i+1;

Nre_bing_p =928*dp*vp_bing_p*rho/ma_bing;
Re_N_Bing_P(i)=Nre_bing_p;

if Nre_bing_p  <2000;
    
     f_bing_p=16/Nre_bing_p ;
    
else         
        f_bing_p=0.0791/Nre_bing_p ^0.25;

end 


% Pressure loss

DP_bing_p = f_bing_p*vp_bing_p.^2*rho/25.81/dp*L;
    
    
%=======================
% Flow in Annulus
%========================


vpa_bing_a =0.408*Q/(dw.^2-do.^2);

ma_bing_a=mp_bing+5*ty_bing*(dw-do)/vpa_bing_a;

%Reynolds number

Nre_bing_a =757*(dw-do)*vpa_bing_a*rho/ma_bing_a;
Re_N_Bing_a(i)=Nre_bing_a;

if Nre_bing_a <2000;
    
  f_bing_a=16/Nre_bing_a;
    
else         
        f_bing_a=0.0791/Nre_bing_a^0.25;
    
end

% Pressure loss

DP_bing_a = f_bing_a*vpa_bing_a^2*rho/25.81/(dw-do)*L;
        
    
%//////Total pressure loss Bingham model////////////

% Total pressure loss DP = DPsrf + DPds  + DPb + DPa


DP_tot_bing  = DPsurf +DP_bing_p +DP_bing_a;

% ECD 


ECDB = rho+DP_bing_a/(0.052*L);


% Store annulus pressure loss/ECD calculation

DP_a_Newtr =[DP_a_Newtr DP_A_Newt];
DP_a_bingr =[DP_a_bingr DP_bing_a];
 
%Store pipe pressure loss/ECD calculation
 
DP_p_Newtr =[DP_p_Newtr DP_P_Newt];
DP_p_bingr =[DP_p_bingr DP_bing_a];
 

%Store total pressure/Pump pressure    
     
DP_tot_Newtr =[DP_tot_Newtr DP_tot_Newt];
DP_tot_bingr =[DP_tot_bingr DP_tot_bing];

Qr =[Qr Q];

rho_rN=[rho_rN ECDN];
rho_rB=[rho_rB ECDB];


Collapse_r=[Collapse_r Collapse];
Fracture_r=[Fracture_r Fracture];

%Nre_Newtr=[Nre_Newtr Nre_Newt];

end

   
figure

% Total pressure plot
subplot(2,1,1)
plot(Qr,DP_tot_bingr,Qr,DP_tot_Newtr);
xlabel('Flow rate, gpm')
ylabel('Total Pressure loss, psi')
legend('Bingham','Newtonian')
grid on

% ECD plots
   
subplot(2,1,2)
plot(Qr,rho_rB,Qr,rho_rN,Qr,Collapse_r,Qr,Fracture_r);%
xlabel('Flow rate, gpm')
ylabel('ECD, ppg')
legend('Bingham','Newtonian','Collapse','Fracture')
grid on

% Here remember to include Reynolds number plots

figure
plot(Qr,Re_N_Bing_P,'r',Qr,Re_N_Bing_a,'b')
xlabel('Flow rate,gpm')
ylabel('Reynolds Number Bingham Model')
legend('Drill Pipe Reynolds Number','Annulus Reynold Number')

