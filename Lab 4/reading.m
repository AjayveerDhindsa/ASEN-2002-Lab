function [geo, ports,usedports]=reading(filename2)
geotot=xlsread(filename2);
geo=geotot(1:17,1:6);
ports=geotot(1:19,8:12);
usedports=xlsread(filename2,2);
w=find(isnan(usedports(:,4))==1);
usedports(w,:)=[];
usedports(:,1)=[];
end