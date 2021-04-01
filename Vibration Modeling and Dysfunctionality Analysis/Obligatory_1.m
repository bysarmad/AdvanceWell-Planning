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
tr=[]; % for time
for t=0:0.01*pi/wn:6*pi/wn
    x=Ao*cos(wn*t-fo);
    xr=[xr x];
    tr=[tr t];
end
    plot(tr,xr)
    grid
    xlabel('time, sec')
    ylabel('displacement, m')
    ylim([-2 2])
    yticks([-2 0 2])
    legend('displacement','Location','northeast')