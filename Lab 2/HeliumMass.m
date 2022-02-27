mPayload = 500; %kg
Altitude = 35000; %m
[T, ~, PPa, AirDensity] = atmoscoesa(Altitude); %K, Pa, kg/m3
P = PPa/1000; %kPa
R = 2.0769; %kPa*m3/(kg*K)
MylarDensity = 950; %kg/m3
SafetyFactor = 1;
TensileStrength = 5734; %kPa
%MD - 193053.2
%TD - 234421.75
g =  9.69978312; %m/s^2
GaugeP = .0010; %kPa

mHe = mPayload/(AirDensity*R*T/P-MylarDensity*3*R*T/P*SafetyFactor*GaugeP/(2*TensileStrength)-1);

V = mHe*R*T/P; %m3
r = (V*3/4/pi)^(1/3); %m

thickness = SafetyFactor*GaugeP*r/2/TensileStrength; %m
thinknessmm = thickness*10^3;
mMylar = MylarDensity*4*pi*r^2*(thickness); %m
FGrav = (mPayload+mMylar+mHe)*g; %N

Fbouy = AirDensity*mHe*R*T/P*g; %N

fprintf("\nProject Conditions:\nAltitude: %d m\nTemperature: %.3f K\nAir Pressure: %.3f kPa\nAir Density: %.3f kg/m^3\nFactor of Safety: %.1f\n",...
    Altitude, T, P, AirDensity, SafetyFactor);
fprintf("\nBalloon: \nMass of He: %.3f kg\nVolume: %.3f m^3\nRadius: %.3f m\nThickness: %.6f mm\nDownforce: %.3f N\nBuoyant Force: %.3f N\n",...
    mHe,V,r,thickness*10^3,FGrav, Fbouy);
