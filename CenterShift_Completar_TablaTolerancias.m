function CenterShift_Completar_TablaTolerancias
global CenterShiftResult PlotNumber callindex2 myhandles4 fdt_F warning_F ok_F Variables

if exist('CenterShiftResult','var') && ~isempty(CenterShiftResult) %call interno
else
    CenterShiftResult=Variables.Functions.CenterShift.CenterShiftResult;
    PlotNumber=Variables.Functions.CenterShift.PlotNumber;
end
try
    
DatosTabla(1,1)={CenterShiftResult.Xshift.Nombre};
try
DatosTabla(1,2)={CenterShiftResult.Xshift.SiNo};
catch
DatosTabla(1,2)={[]};
CenterShiftResult.Xshift.SiNo=[];
end
DatosTabla(1,3)={round(CenterShiftResult.Xshift.ValorObtenido,1)};
try
DatosTabla(1,4)={CenterShiftResult.Xshift.ValorEsperado};
catch
DatosTabla(1,4)={[]}; 
CenterShiftResult.Xshift.ValorEsperado=[];
end
try
DatosTabla(1,5)={CenterShiftResult.Xshift.T1};
catch
DatosTabla(1,5)={[]};
CenterShiftResult.Xshift.T1=[];
end
try
DatosTabla(1,6)={CenterShiftResult.Xshift.T2};
catch
DatosTabla(1,6)={[]};
CenterShiftResult.Xshift.T2=[];
end
try
DatosTabla(1,7)={round(CenterShiftResult.Xshift.ValorObtenido-CenterShiftResult.Xshift.ValorEsperado,1)};
catch
DatosTabla(1,7)={[]};
end



DatosTabla(2,1)={CenterShiftResult.Yshift.Nombre};
try
DatosTabla(2,2)={CenterShiftResult.Yshift.SiNo};
catch
DatosTabla(2,2)={[]};
CenterShiftResult.Yshift.SiNo=[];
end
DatosTabla(2,3)={round(CenterShiftResult.Yshift.ValorObtenido,1)};
try
DatosTabla(2,4)={CenterShiftResult.Yshift.ValorEsperado};
catch
DatosTabla(2,4)={[]}; 
CenterShiftResult.Yshift.ValorEsperado=[];
end
try
DatosTabla(2,5)={CenterShiftResult.Yshift.T1};
catch
DatosTabla(2,5)={[]};
CenterShiftResult.Yshift.T1=[];
end
try
DatosTabla(2,6)={CenterShiftResult.Yshift.T2};
catch
DatosTabla(2,6)={[]};
CenterShiftResult.Yshift.T2=[];
end
try
DatosTabla(2,7)={round(CenterShiftResult.Yshift.ValorObtenido-CenterShiftResult.Yshift.ValorEsperado,1)};
catch
DatosTabla(2,7)={[]};
end


DatosTabla(3,1)={CenterShiftResult.R.Nombre};
try
DatosTabla(3,2)={CenterShiftResult.R.SiNo};
catch
DatosTabla(3,2)={[]};
CenterShiftResult.R.SiNo=[];
end
DatosTabla(3,3)={round(CenterShiftResult.R.ValorObtenido,1)};
try
DatosTabla(3,4)={CenterShiftResult.R.ValorEsperado};
catch
DatosTabla(3,4)={[]}; 
CenterShiftResult.R.ValorEsperado=[];
end
try
DatosTabla(3,5)={CenterShiftResult.R.T1};
catch
DatosTabla(3,5)={[]};
CenterShiftResult.R.T1=[];
end
try
DatosTabla(3,6)={CenterShiftResult.R.T2};
catch
DatosTabla(3,6)={[]};
CenterShiftResult.R.T2=[];
end
try
DatosTabla(3,7)={round(CenterShiftResult.R.ValorObtenido-CenterShiftResult.R.ValorEsperado,1)};
catch
DatosTabla(3,7)={[]};
end


catch
end


colergen = @(color,text) ['<html><table border=0 width=800 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
for i=1:length(DatosTabla(:,1))
    if ((DatosTabla{i,2}==1)&(~isempty(DatosTabla{i,5}))&(~isempty(DatosTabla{i,6})))
    if ((abs(DatosTabla{i,7})>DatosTabla{i,6}) || (isnan(abs(DatosTabla{i,7})))) 
    DatosTabla(i,7)={colergen('#FF0000 ',num2str(DatosTabla{i,7}))};
    fdt_F=fdt_F+1;
    else
        if abs(DatosTabla{i,7})>DatosTabla{i,5}
        DatosTabla(i,7)={colergen('#FFA500 ',num2str(DatosTabla{i,7}))};
        warning_F=warning_F+1;
        else
        DatosTabla(i,7)={colergen('#00FF00 ',num2str(DatosTabla{i,7}))};  
        ok_F=ok_F+1;
        end
    end
    end
end

if callindex2==1 %Desde TablaResultados
callindex2=0;
else %Desde ProgramaQA2
set(myhandles4.uitable3,'Data',DatosTabla);
end
end