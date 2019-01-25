function PDDfotones_SaveFunction
global PlotNumber PDDfotonesResult Variables callindex2 Functions
if callindex2==0
PDDfotones.PDDfotonesResult=PDDfotonesResult;
PDDfotones.PlotNumber=PlotNumber;
Variables.Functions.PDDfotones=PDDfotones;
    else
    f1=fieldnames(PDDfotonesResult);
    for i=1:length(f1)
    f2=fieldnames(PDDfotonesResult.(char(f1(i))));
    for j=1:length(f2)
    Variables.Functions.PDDfotones.PDDfotonesResult.(char(f1(i))).(char(f2(j)))=PDDfotonesResult.(char(f1(i))).(char(f2(j)));
    end
    end
end
clear PlotNumber PDDfotonesResult
end