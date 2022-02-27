%code for lab 4
%% Housekeeping
clear; clc; close all;
c=3.5;
%% Read in files and creates vairables for the data
Files = dir('*.csv');
FileNames = {Files.name};
information = zeros(240, 28, length(FileNames));
Counter = 0;
CheckB = 0;
CheckV = 0;
Info = zeros(1,28);

for i = 1:length(FileNames)
    Dimensions = size(csvread(char(FileNames(i)), 1,0));

    information(1:Dimensions(1), :, i) = csvread(char(FileNames(i)), 1,0);
    if i == 28
        Group_Boundary_Data(1:Dimensions(1),:) = csvread(char(FileNames(i)), 1,0);
    end
end

for i = 1:length(FileNames)
    Info = vertcat(Info, information(:,:,i));
end

Demi = size(Info);
for i = 1:Demi(1)
    if sum(Info(i,:)) ~= 0
        Counter = Counter + 1;
        Data(Counter,:) = Info(i,:);
    end
end
%% Calculates C_p 
rhoinf=Data(:,3);
Vinf=Data(:,4);
AoA=Data(:,23);
scanivals = Data(:,7:22);
C_p=zeros(length(Data),16);
for i=1:length(Data)
    C_p(i,:)=scanivals(i,:)./(rhoinf(i,1)*.5*Vinf(i,1)^2);
end
%% Find Cp at trailing edge
for i = 1:length(C_p)
    %extrapolates to find the Cp at 3.5" then takes the mean of the two
    %values
p1 = interp1([2.1 2.8],[C_p(i,8) C_p(i,9)],3.5,'linear','extrap');
p2 = interp1([2.1 2.8],[C_p(i,11) C_p(i,10)],3.5,'linear','extrap');
C_p11(i,1)=(p1+p2)/2;
end
% adds the found values of Cp at the trailing edge to the main matrix for
% Cp values
C_p1=C_p(:,1:9);
C_p2=C_p(:,10:end);
C_p=[C_p1,C_p11,C_p2];
%%
c=3.5;
%reads in the airfoil geometery to get the coordinates of the port
[geo, ports,usedports]=reading('AirfoilGeometry.xlsx');
% Round the airspeed to defined values because they are the same for each
% data set
Vinf=round(Vinf);
% finds where the velocity is 9m/s then gives the Cp and Angles of attack
% for when Vinf=9 this is the repeated for V=17 and V=34
vid9= Vinf==9;
C_p9= C_p(vid9,:);
AoA9=AoA(vid9,:);
vid17= Vinf==17;
C_p17= C_p(vid17,:);
AoA17=AoA(vid17,:);
vid34= Vinf==34;
C_p34= C_p(vid34,:);
AoA34=AoA(vid34,:);
%Adds the trailing edge location to the port coordinates and normalizes the
%values to the chord
usedport=[usedports(1:9,:);3.5 0 10; usedports(10:end,:)]/c;
%creates cell array of the angles of attack and the Cp values with
%corresponding velocities
AoA={AoA9,AoA17,AoA34};
C_p={C_p9,C_p17,C_p34};
Cd=zeros(32,2,3);
Cl=zeros(32,2);
for i=1:3
    % gives the corresponding Cp and Angles of attack for each velocity
    coolp=cell2mat(C_p(i));
    sub=cell2mat(AoA(i));
    for j=-15:16
        AoAid=sub==j;
        [Cdtemp,Cltemp]= coefficients(coolp(AoAid,:),usedport,sub(AoAid,1));
        Cd(j+16,1,i)=mean(Cdtemp);
        Cd(j+16,2,i)=mean(sub(AoAid,1));
        Cl(j+16,i)=mean(Cltemp);
        C_p9e(j+16,:,i)=mean(coolp(AoAid,:),1);
    end
end
%%
for i=1:8:32
figure(3)
plot(usedport(:,1),C_p9e(i,:,1))
legend('\alpha= -15°','\alpha= -7°','\alpha= 1°','\alpha= 9°','location','southeast')
title("Coefficient of Pressure vs X/C")
set(gca,'FontSize',18);
ylabel('C_p','FontSize',20)
xlabel('X/C','FontSize',20)
set(gca, 'YDir','reverse')
hold on
end
clc
%%
for i=1:3
    figure(1)
    plot(Cd(:,2,i),Cd(:,1,i))
    hold on;
    title('Coefficient of Drag Vs AoA','FontSize',18)
    xlabel('Angle of Attack in degrees','FontSize',18)
    ylabel('C_d','FontSize',18)
    legend("V=9 m/s","V=17 m/s","V=34 m/s",'location','northwest')
    figure(2)
    plot(Cd(:,2,i),Cl(:,i))
    title('Coefficient of Lift Vs AoA','FontSize',18)
    xlabel('Angle of Attack in degrees','FontSize',18)
    ylabel('C_l','FontSize',18)
    legend("V=9 m/s","V=17 m/s","V=34 m/s",'location','northwest')
    hold on;
end
clc