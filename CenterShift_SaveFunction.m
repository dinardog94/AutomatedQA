function CenterShift_SaveFunction
global PlotNumber CenterShiftResult Variables callindex2 Functions
if callindex2==0
CenterShift.CenterShiftResult=CenterShiftResult;
CenterShift.PlotNumber=PlotNumber;
Variables.Functions.CenterShift=CenterShift;
    else
    f1=fieldnames(CenterShiftResult);
    for i=1:length(f1)
        f2=fieldnames(CenterShiftResult.(char(f1(i))));
            for j=1:length(f2)
    Variables.Functions.CenterShift.CenterShiftResult.(char(f1(i))).(char(f2(j)))=CenterShiftResult.(char(f1(i))).(char(f2(j)));
            end
    end
end
varlist = {'PlotNumber','CenterShiftResult'};
clear('global',varlist{:})
end