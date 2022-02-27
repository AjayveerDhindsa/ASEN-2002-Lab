function [Sigma_Man_Speed, AirSpeed_Manometer, Voltage, AirSpeed_VentiMan] = ComputeAirSpeed_Manometer(Velocity_Data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Read in Height
fileID = fopen('heightdata.txt');
Line = fgetl(fileID);
Counter = 1;
Index = 1;
while Line ~= -1
    if Counter > 1
        Temp = str2double(strsplit(Line));
        Voltage(Index) = Temp(1);
        HeightDiff(Index) = Temp(2)*0.0254; % convert from inches to meters
    end
    Index = Index + 1;
    Counter = Counter + 1;
    Line = fgetl(fileID);
end

%% Air Speed Pitot-Static
Avg_Room_Pressure = mean(Velocity_Data(:,1)); % [Pa]
Std_Room_Press_Mean = std(Velocity_Data(:,1))/sqrt(length(Velocity_Data(:,1))); % [Pa]

Avg_Room_Temp = mean(Velocity_Data(:,2)); % [K]
Std_Room_Temp_Mean = std(Velocity_Data(:,2))/sqrt(length(Velocity_Data(:,2))); % [K]

Red_Fluid_Density = 1000*0.826;
Gravity_Constant = 9.8;
R_Air = 287; % [J/(Kg*K)]

for i = 1:length(HeightDiff)
    Pressure_Diff(i) = Red_Fluid_Density*Gravity_Constant*HeightDiff(i);
end

AirSpeed_Manometer = zeros(length(HeightDiff), 1);
for i = 1:length(HeightDiff)
    AirSpeed_Manometer(i) = sqrt(2*Pressure_Diff(i)*((R_Air*Avg_Room_Temp)/(Avg_Room_Pressure)));
end

%% Air Speed Venturi Tube
Area_Ratio = 1/9.5;

AirSpeed_VentiMan = zeros(length(HeightDiff), 1);
for i = 1:length(HeightDiff)
    AirSpeed_VentiMan(i) = sqrt(2*Pressure_Diff(i)*((R_Air*Avg_Room_Temp)/(Avg_Room_Pressure*(1-Area_Ratio^2))));
end

%% Uncertanity
Sigma_Manometer = 0.05*0.0254;
for i = 1:length(AirSpeed_Manometer)
    Sigma_Man_Speed(i) = AirSpeed_Manometer(i)*(sqrt(2)/2)*sqrt((Sigma_Manometer/Pressure_Diff(i))^2 + (Std_Room_Press_Mean/Avg_Room_Pressure)^2 + (Std_Room_Temp_Mean/Avg_Room_Temp)^2);
end


end