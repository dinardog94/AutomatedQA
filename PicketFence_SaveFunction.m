function PicketFence_SaveFunction
global PlotNumber PicketFenceResult Variables callindex2 Functions
if callindex2==0
PicketFence.PicketFenceResult=PicketFenceResult;
PicketFence.PlotNumber=PlotNumber;
Variables.Functions.PicketFence=PicketFence;
    else
    f1=fieldnames(PicketFenceResult);
    for i=1:length(f1)
        L=length(PicketFenceResult.(char(f1(i))));
        f2=fieldnames(PicketFenceResult.(char(f1(i))));
        if L>1
           for k=1:L
                for j=1:length(f2)
    Variables.Functions.PicketFence.PicketFenceResult.(char(f1(i)))(k).(char(f2(j)))=PicketFenceResult.(char(f1(i)))(k).(char(f2(j)));
                end      
         end 
        else
    for j=1:length(f2)
    Variables.Functions.PicketFence.PicketFenceResult.(char(f1(i))).(char(f2(j)))=PicketFenceResult.(char(f1(i))).(char(f2(j)));
    end
    end
    end
end
varlist = {'PlotNumber','PicketFenceResult'};
clear('global',varlist{:})
end