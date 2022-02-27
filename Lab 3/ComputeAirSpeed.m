function [AirSpeed_Volts, Volts, AirSpeed_Area, Sigma_AirSpeed, Pressure_Avg_Std, Std_Room_Press_Mean, Std_Room_Temp_Mean] = ComputeAirSpeed(Velocity_Data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Air Speed Calculation from Equation 1
R_Air = 287; % [J/(Kg*K)]
Volts = [1, 1.5, 2, 3, 3.5, 4, 5, 5.5, 6, 7, 7.5, 8, 9, 9.5, 10]; % [Volts]

for j = 1:15
    temp = find(Velocity_Data(:,7) == Volts(j));
    for i = 1:length(temp)
        Pressure_Diff(i, j) = abs(Velocity_Data(temp(i),3));
    end
    Pressure_Avg(j) = mean(Pressure_Diff(1:length(temp),j)); % [Pa]
    Pressure_Avg_Std(j) = std(Pressure_Diff(1:length(temp),j))/sqrt(length(temp)); % [Pa]
end

Avg_Room_Pressure = mean(Velocity_Data(:,1)); % [Pa]
Std_Room_Press_Mean = std(Velocity_Data(:,1))/sqrt(length(Velocity_Data(:,1))); % [Pa]

Avg_Room_Temp = mean(Velocity_Data(:,2)); % [K]
Std_Room_Temp_Mean = std(Velocity_Data(:,2))/sqrt(length(Velocity_Data(:,2))); % [K]

AirSpeed_Volts = zeros(15,1); % [m/s]
for i = 1:15
    AirSpeed_Volts(i) = sqrt(2*Pressure_Avg(i)*((R_Air*Avg_Room_Temp)/(Avg_Room_Pressure)));
end

%% Air Speed Calculation from Equation 2
Area_Ratio = 1/9.5;
for i = 1:15
    AirSpeed_Area(i) = sqrt(2*Pressure_Avg(i)*((R_Air*Avg_Room_Temp)/(Avg_Room_Pressure*(1-Area_Ratio^2))));
end

%% Uncertanity
Sigma_AirSpeed = zeros(1,15);
for i = 1:15
    Sigma_AirSpeed(i) = AirSpeed_Volts(i)*(sqrt(2)/2)*sqrt((Pressure_Avg_Std(i)/Pressure_Avg(i))^2 + (Std_Room_Press_Mean/Avg_Room_Pressure)^2 + (Std_Room_Temp_Mean/Avg_Room_Temp)^2);
end


end