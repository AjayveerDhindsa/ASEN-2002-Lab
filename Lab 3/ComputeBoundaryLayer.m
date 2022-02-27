function [sigma_Boundary, A_2_1_Top, v_plot_top, boundary_plot_velocity, A_2_1_Top_Group, B_plot_vel_Group] = ComputeBoundaryLayer(AirSpeed_Volts, Boundary_Data, Sigma_AirSpeed, Pressure_Avg_Std, Std_Room_Press_Mean, Std_Room_Temp_Mean, Group_Boundary_Data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

avgatpres = mean(Boundary_Data(:,1));
avgtemp = mean(Boundary_Data(:,2));
avgpresdif = mean(Boundary_Data(:,4));
Group_Room_Pres = mean(Group_Boundary_Data(:,1));
Group_Room_Temp = mean(Group_Boundary_Data(:,2));
Group_Press_Diff = mean(Group_Boundary_Data(:,4));

v_inf = AirSpeed_Volts(7);

R = 287; % [J / kg*K]
A_1 = 1 * (0.3048)^2;

A_2 = A_1 * (sqrt(1 - ((2*avgpresdif*R*avgtemp) / ((v_inf)^2 * avgatpres))));
A_2_Group = A_1 * (sqrt(1 - ((2*Group_Press_Diff*R*Group_Room_Temp) / ((v_inf)^2 * Group_Room_Pres))));

A_2_1_Top = linspace(A_2,A_1);
A_2_1_Top = A_2_1_Top(1,1:99);

A_2_1_Top_Group = linspace(A_2_Group,A_1);
A_2_1_Top_Group = A_2_1_Top_Group(1,1:99);

v_plot_top = sqrt( (2*avgpresdif*R*avgtemp) ./ (avgatpres*( 1 - (A_2_1_Top ./ A_1).^2))); 
v_plot_top_Group = sqrt( (2*Group_Press_Diff*R*Group_Room_Temp) ./ (Group_Room_Pres*( 1 - (A_2_1_Top_Group ./ A_1).^2))); 

boundary_plot_velocity = 0.95*v_plot_top;
B_plot_vel_Group = 0.95*v_plot_top_Group;

%% Uncertanity
sigma_Boundary = 0.5*sqrt((Pressure_Avg_Std(7)/avgpresdif)^2 + (Std_Room_Temp_Mean/avgtemp)^2 + (Std_Room_Press_Mean/avgatpres)^2 + (2*Sigma_AirSpeed(7)/(v_inf)^2)^2);

end

