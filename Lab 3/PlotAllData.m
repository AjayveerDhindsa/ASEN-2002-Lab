function [] = PlotAllData(Volts, AirSpeed_Volts, AirSpeed_Area, Voltage, AirSpeed_Manometer, AirSpeed_VentiMan, A_2_1_Top, v_plot_top,...
    boundary_plot_velocity, A_2_1_Top_Group, B_plot_vel_Group, Sigma_AirSpeed)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure(1)
plot(Volts, AirSpeed_Volts, 'r')
hold on;
plot(Volts, AirSpeed_Area, 'b')
plot(Voltage(2:length(Voltage)), AirSpeed_Manometer(2:length(AirSpeed_Manometer)), '--k')
plot(Voltage(2:length(Voltage)), AirSpeed_VentiMan(2:length(AirSpeed_VentiMan)), '-.g')
xlabel('Volts [Volts]')
ylabel('Air Speed [m/s]')
title('Air Speed Equation Comparison ')
legend('Air Speed Based on Volts and Pitot-Static Probe', 'Air Speed Based on Area Ratio and Venturi Tube', 'Air Speed Based on Manometer Readings and Pitot-Static Probe', 'Air Speed Based on Manometer Readings and Venturi Tube',  'location', 'northwest')
hold off

figure(2)
plot(A_2_1_Top, v_plot_top, 'g')
hold on
plot(A_2_1_Top, boundary_plot_velocity, 'r')
plot(A_2_1_Top_Group, B_plot_vel_Group, 'b')
xlabel('Boundary Area [m^2]')
ylabel('Velocity [m/s]')
title('Velocity vs. Area')
legend('Freestream Velocity','All Lab Sections Boundary Velcoity', 'Section 14 Group 9 Boundary Velocity', 'location', 'northwest')
hold off

figure(3)
plot(AirSpeed_Volts, Sigma_AirSpeed, 'k')
xlabel('Air Speed [m/s]')
ylabel('Uncertantiy in Air Speed [m/s]')
title('Uncertantiy in Air Speed vs. Air Speed')

figure(4)
plot(Volts, AirSpeed_Volts)
hold on
Error = errorbar(Volts, AirSpeed_Volts, Sigma_AirSpeed.*100, 'r');
plot(Volts, AirSpeed_Volts,'k')
hold off
xlabel('Voltage [voltage]')
ylabel('Air Speed [m/s]')
title('Air Speed vs Voltage with Error Bars')
end

