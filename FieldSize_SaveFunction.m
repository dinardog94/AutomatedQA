function FieldSize_SaveFunction
global PlotNumber FieldSizeResult Variables callindex2
if callindex2==0
FieldSize.FieldSizeResult=FieldSizeResult;
FieldSize.PlotNumber=PlotNumber;
Variables.Functions.FieldSize=FieldSize;
else
f1=fieldnames(FieldSizeResult);
   for i=1:length(f1)
       L=length(FieldSizeResult.(char(f1(i))));
       f2=fieldnames(FieldSizeResult.(char(f1(i))));
       if L>1
         for k=1:L
                for j=1:length(f2)
    Variables.Functions.FieldSize.FieldSizeResult.(char(f1(i)))(k).(char(f2(j)))=FieldSizeResult.(char(f1(i)))(k).(char(f2(j)));
                end      
         end
       else
         for j=1:length(f2)
    Variables.Functions.FieldSize.FieldSizeResult.(char(f1(i))).(char(f2(j)))=FieldSizeResult.(char(f1(i))).(char(f2(j)));
         end
       end
   end
varlist = {'PlotNumber','FieldSizeResult'};
clear('global',varlist{:})
end