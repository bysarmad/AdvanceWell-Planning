%Example: Equation 2 will be implemented in matlab
%Parameters
xo=1.00;  % Initial displacement, m
vo=1.50;  % Initial velocity, m/s
k=25000;  % Spring constant, N/m
m=4000;   % Mass kg,
g=9.81;   % Gravity constant, m/s2
%Calculate
wn = (k/m)^0.5; % natural frequency, 1/s
Ao= sqrt(xo^2+(vo/wn)^2); %Amplitude, m
fo=atan(vo/(xo*wn)); % Phase angle, rad
%store data
xr=[];% for displacement
tr=[];% for time
vr=[];% for velocity
ar=[];% for acceleration
alr=[];% for acceleration limit
for t=0:0.01*pi/wn:6*pi/wn
    x=Ao*cos(wn*t-fo);
    v=-wn*Ao*sin(wn*t-fo);
    a=-wn^2*Ao*cos(wn*t-fo);   
    al=1.5*g;
    xr=[xr x];
    vr=[vr v];
    ar=[ar a];
    alr=[alr al];
    tr=[tr t];
end
    plot(tr,ar,'b',tr,alr,'--r')
    grid
    xlabel('time, sec')
    ylabel('acceleration, m/s2')
    ylim([-20 20])
    yticks([-20 0 20])
    legend('acceleration','acceleration limit','Location','east')
    
    %% The Condition of the drill string is safe.