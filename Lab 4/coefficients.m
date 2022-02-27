function [Cd,Cl] = coefficients(C_p,usedport,AoA)
[r,~]=size(C_p);
Cl=zeros(1,r);
Cd=zeros(1,r);
for i=1:r
    %using trapazoidal method find Cn and Ca
   C_n=trapz(usedport(:,1),C_p(i,:)); 
   C_a=trapz(usedport(:,2),C_p(i,:));
   %calculates Cl and Cd
   Cl(i)=-C_n*cosd(AoA(i,1))-C_a*sind(AoA(i,1));
   Cd(i)=-C_n*sind(AoA(i,1))+C_a*cosd(AoA(i,1));
end
end