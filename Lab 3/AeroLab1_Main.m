%{ 
What do...

Names: ...
Class: ASEN 2002 Aerodymanics
Section(s): 014, 3pm - 5pm
Group: 9
Date: November 14, 2018
Lab: Aero Lab 1, Wind Tunnel Configuration
%}

%% House Keeping
clc;
clear;
close all;

%% Read in the Data
[Boundary_Data, Velocity_Data, Group_Boundary_Data] = ReadInFileData(); 

%% Air Speed
[AirSpeed_Volts, Volts, AirSpeed_Area, Sigma_AirSpeed, Pressure_Avg_Std, Std_Room_Press_Mean, Std_Room_Temp_Mean] = ComputeAirSpeed(Velocity_Data);

%% Air Speed with Manometer Height Difference
[Sigma_Man_Speed, AirSpeed_Manometer, Voltage, AirSpeed_VentiMan] = ComputeAirSpeed_Manometer(Velocity_Data);

%% Boundary Layer
[sigma_Boundary, A_2_1_Top, v_plot_top, boundary_plot_velocity, A_2_1_Top_Group, B_plot_vel_Group] = ComputeBoundaryLayer(AirSpeed_Volts,...
    Boundary_Data, Sigma_AirSpeed, Pressure_Avg_Std, Std_Room_Press_Mean, Std_Room_Temp_Mean, Group_Boundary_Data);

%% Plot Data
PlotAllData(Volts, AirSpeed_Volts, AirSpeed_Area, Voltage, AirSpeed_Manometer, AirSpeed_VentiMan, A_2_1_Top, v_plot_top,...
    boundary_plot_velocity, A_2_1_Top_Group, B_plot_vel_Group, Sigma_AirSpeed);