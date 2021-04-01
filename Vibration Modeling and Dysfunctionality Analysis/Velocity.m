%Example: Equation 2 will be implemented in matlab
%Parameters
xo=1.00;  % Initial displacement, m
vo=1.50;  % Initial velocity, m/s
k=25000;  % Spring constant, N/m
m=4000;   % Mass kg,
%Calculate
wn = (k/m)^0.5; % natural frequency, 1/s
Ao= sqrt(xo^2+(vo/wn)^2); %Amplitude, m
fo=atan(vo/(xo*wn)); % Phase angle, rad
%store data
xr=[]; % for displacement
tr=[];% for time
vr=[]; % for velocity
for t=0:0.01*pi/wn:6*pi/wn
    x=Ao*cos(wn*t-fo);
    v=-wn*Ao*sin(wn*t-fo);
    xr=[xr x];
    vr=[vr v];
    tr=[tr t];
end
    plot(tr,vr)
    grid
    xlabel('time, sec')
    ylabel('velocity, m/s')
    ylim([-5 5])
    yticks([-5 0 5])
    legend('velocity','Location','northwest')