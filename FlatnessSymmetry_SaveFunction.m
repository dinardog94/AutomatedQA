function FlatnessSymmetry_SaveFunction
global PlotNumber FlatnessSymmetryResult Variables callindex2
if callindex2==0
FlatnessSymmetry.FlatnessSymmetryResult=FlatnessSymmetryResult;
FlatnessSymmetry.PlotNumber=PlotNumber;
Variables.Functions.FlatnessSymmetry=FlatnessSymmetry;
else
f1=fieldnames(FlatnessSymmetryResult);
    for i=1:length(f1)
        L=length(FlatnessSymmetryResult.(char(f1(i))));
        f2=fieldnames(FlatnessSymmetryResult.(char(f1(i))));
        if L>1
         for k=1:L   
            for j=1:length(f2)
            Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.(char(f1(i)))(k).(char(f2(j)))=FlatnessSymmetryResult.(char(f1(i)))(k).(char(f2(j)));
            end
         end
        else
            for j=1:length(f2)
    Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.(char(f1(i))).(char(f2(j)))=FlatnessSymmetryResult.(char(f1(i))).(char(f2(j)));
            end
        end
    end
end
varlist = {'PlotNumber','FlatnessSymmetryResult'};
clear('global',varlist{:})
end