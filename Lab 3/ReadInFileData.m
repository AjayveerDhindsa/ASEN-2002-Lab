function [Boundary_Data, Velocity_Data, Group_Boundary_Data] = ReadInFileData() 

Files = dir('*.csv');
FileNames = {Files.name};
information = zeros(10000, 7, length(FileNames));
Counter = 0;
CheckB = 0;
CheckV = 0;
Info = zeros(1,7);

for i = 1:length(FileNames)
    Deminsions = size(csvread(char(FileNames(i)), 1,0));
    if i < length(FileNames)/2 + 1
        CheckB = CheckB + Deminsions(1);
    else
        CheckV = CheckV + Deminsions(1);
    end
    information(1:Deminsions(1), :, i) = csvread(char(FileNames(i)), 1,0);
    if i == 28
        Group_Boundary_Data(1:Deminsions(1),:) = csvread(char(FileNames(i)), 1,0);
    end
end

for i = 1:length(FileNames)
    Info = vertcat(Info, information(:,:,i));
end

Demi = size(Info);
Data = zeros((CheckB + CheckV), 7);
for i = 1:Demi(1)
    if sum(Info(i,:)) ~= 0
        Counter = Counter + 1;
        Data(Counter,:) = Info(i,:);
    end
end

VelCounter = 0;
Velocity_Data = zeros(CheckV,7);
BouCounter = 0;
Boundary_Data = zeros(CheckB,7);

for i = 1:(CheckB + CheckV)
    if i < CheckB + 1
        BouCounter = BouCounter + 1;
        Boundary_Data(BouCounter, :) = Data(i,:);
    else
        VelCounter = VelCounter + 1;
        Velocity_Data(VelCounter, :) = Data(i,:);
    end
end

end