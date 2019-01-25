function FieldSize_Completar_TablaTolerancias
global FieldSizeResult PlotNumber callindex2 myhandles4 fdt_F warning_F ok_F Variables

if exist('FieldSizeResult','var') && ~isempty(FieldSizeResult) %call interno
else
    FieldSizeResult=Variables.Functions.FieldSize.FieldSizeResult;
    PlotNumber=Variables.Functions.FieldSize.PlotNumber;
end
try
for i=1:PlotNumber(2)
DatosTabla(3*i-2,1)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Nombre};
try
DatosTabla(3*i-2,2)={FieldSizeResult.Perfil_FieldSizeX_datos(i).SiNo};
catch
DatosTabla(3*i-2,2)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).SiNo=[];
end
DatosTabla(3*i-2,3)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_mm,1)};
try
DatosTabla(3*i-2,4)={FieldSizeResult.Perfil_FieldSizeX_datos(i).ValorEsperado};
catch
DatosTabla(3*i-2,4)={[]}; 
FieldSizeResult.Perfil_FieldSizeX_datos(i).ValorEsperado=[];
end
try
DatosTabla(3*i-2,5)={FieldSizeResult.Perfil_FieldSizeX_datos(i).T1};
catch
DatosTabla(3*i-2,5)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).T1=[];
end
try
DatosTabla(3*i-2,6)={FieldSizeResult.Perfil_FieldSizeX_datos(i).T2};
catch
DatosTabla(3*i-2,6)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).T2=[];
end
try
DatosTabla(3*i-2,7)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_mm-FieldSizeResult.Perfil_FieldSizeX_datos(i).ValorEsperado,1)};
catch
DatosTabla(3*i-2,7)={[]};
end

DatosTabla(3*i-1,1)={[FieldSizeResult.Perfil_FieldSizeX_datos(i).Nombre, '_X-']};
try
DatosTabla(3*i-1,2)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_SiNo};
catch
DatosTabla(3*i-1,2)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_SiNo=[];
end
DatosTabla(3*i-1,3)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_Izq_mm,1)};
try
DatosTabla(3*i-1,4)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_ValorEsperado};
catch
DatosTabla(3*i-1,4)={[]}; 
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_ValorEsperado=[];
end
try
DatosTabla(3*i-1,5)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T1};
catch
DatosTabla(3*i-1,5)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T1=[];
end
try
DatosTabla(3*i-1,6)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T2};
catch
DatosTabla(3*i-1,6)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T2=[];
end
try
DatosTabla(3*i-1,7)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_Izq_mm-FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_ValorEsperado,1)};
catch
DatosTabla(3*i-1,7)={[]};
end

DatosTabla(3*i,1)={[FieldSizeResult.Perfil_FieldSizeX_datos(i).Nombre, '_X+']};
try
DatosTabla(3*i,2)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_SiNo};
catch
DatosTabla(3*i,2)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_SiNo=[];
end
DatosTabla(3*i,3)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_Der_mm,1)};
try
DatosTabla(3*i,4)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_ValorEsperado};
catch
DatosTabla(3*i,4)={[]}; 
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_ValorEsperado=[];
end
try
DatosTabla(3*i,5)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T1};
catch
DatosTabla(3*i,5)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T1=[];
end
try
DatosTabla(3*i,6)={FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T2};
catch
DatosTabla(3*i,6)={[]};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T2=[];
end
try
DatosTabla(3*i,7)={round(FieldSizeResult.Perfil_FieldSizeX_datos(i).FieldSize_Der_mm-FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_ValorEsperado,1)};
catch
DatosTabla(3*i,7)={[]};
end

end


for i=1:PlotNumber(3)
    
DatosTabla(3*i+3*PlotNumber(2)-2,1)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Nombre};
try
DatosTabla(3*i+3*PlotNumber(2)-2,2)={FieldSizeResult.Perfil_FieldSizeY_datos(i).SiNo};
catch
DatosTabla(3*i+3*PlotNumber(2)-2,2)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).SiNo=[];
end
DatosTabla(3*i+3*PlotNumber(2)-2,3)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_mm,1)};
try
DatosTabla(3*i+3*PlotNumber(2)-2,4)={FieldSizeResult.Perfil_FieldSizeY_datos(i).ValorEsperado};
catch
DatosTabla(3*i+3*PlotNumber(2)-2,4)={[]}; 
FieldSizeResult.Perfil_FieldSizeY_datos(i).ValorEsperado=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-2,5)={FieldSizeResult.Perfil_FieldSizeY_datos(i).T1};
catch
DatosTabla(3*i+3*PlotNumber(2)-2,5)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).T1=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-2,6)={FieldSizeResult.Perfil_FieldSizeY_datos(i).T2};
catch
DatosTabla(3*i+3*PlotNumber(2)-2,6)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).T2=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-2,7)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_mm-FieldSizeResult.Perfil_FieldSizeY_datos(i).ValorEsperado,1)};
catch
DatosTabla(3*i+3*PlotNumber(2)-2,7)={[]};
end

DatosTabla(3*i+3*PlotNumber(2)-1,1)={[FieldSizeResult.Perfil_FieldSizeY_datos(i).Nombre, '_Y-']};
try
DatosTabla(3*i+3*PlotNumber(2)-1,2)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_SiNo};
catch
DatosTabla(3*i+3*PlotNumber(2)-1,2)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_SiNo=[];
end
DatosTabla(3*i+3*PlotNumber(2)-1,3)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_Izq_mm,1)};
try
DatosTabla(3*i+3*PlotNumber(2)-1,4)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_ValorEsperado};
catch
DatosTabla(3*i+3*PlotNumber(2)-1,4)={[]}; 
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_ValorEsperado=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-1,5)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T1};
catch
DatosTabla(3*i+3*PlotNumber(2)-1,5)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T1=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-1,6)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T2};
catch
DatosTabla(3*i+3*PlotNumber(2)-1,6)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T2=[];
end
try
DatosTabla(3*i+3*PlotNumber(2)-1,7)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_Izq_mm-FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_ValorEsperado,1)};
catch
DatosTabla(3*i+3*PlotNumber(2)-1,7)={[]};
end


DatosTabla(3*i+3*PlotNumber(2),1)={[FieldSizeResult.Perfil_FieldSizeY_datos(i).Nombre, '_Y+']};
try
DatosTabla(3*i+3*PlotNumber(2),2)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_SiNo};
catch
DatosTabla(3*i+3*PlotNumber(2),2)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_SiNo=[];
end
DatosTabla(3*i+3*PlotNumber(2),3)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_Der_mm,1)};
try
DatosTabla(3*i+3*PlotNumber(2),4)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_ValorEsperado};
catch
DatosTabla(3*i+3*PlotNumber(2),4)={[]}; 
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_ValorEsperado=[];
end
try
DatosTabla(3*i+3*PlotNumber(2),5)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T1};
catch
DatosTabla(3*i+3*PlotNumber(2),5)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T1=[];
end
try
DatosTabla(3*i+3*PlotNumber(2),6)={FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T2};
catch
DatosTabla(3*i+3*PlotNumber(2),6)={[]};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T2=[];
end
try
DatosTabla(3*i+3*PlotNumber(2),7)={round(FieldSizeResult.Perfil_FieldSizeY_datos(i).FieldSize_Der_mm-FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_ValorEsperado,1)};
catch
DatosTabla(3*i+3*PlotNumber(2),7)={[]};
end

end


for i=1:PlotNumber(4)
DatosTabla(i+3*sum(PlotNumber(2:3)),1)={FieldSizeResult.Perfil_FieldSizeO_datos(i).Nombre};
try
DatosTabla(i+3*sum(PlotNumber(2:3)),2)={FieldSizeResult.Perfil_FieldSizeO_datos(i).SiNo};
catch
DatosTabla(i+3*sum(PlotNumber(2:3)),2)={[]};
FieldSizeResult.Perfil_FieldSizeO_datos(i).SiNo=[];
end
DatosTabla(i+3*sum(PlotNumber(2:3)),3)={round(FieldSizeResult.Perfil_FieldSizeO_datos(i).FieldSize_mm,1)};
try
DatosTabla(i+3*sum(PlotNumber(2:3)),4)={FieldSizeResult.Perfil_FieldSizeO_datos(i).ValorEsperado};
catch
DatosTabla(i+3*sum(PlotNumber(2:3)),4)={[]}; 
FieldSizeResult.Perfil_FieldSizeO_datos(i).ValorEsperado=[];
end
try
DatosTabla(i+3*sum(PlotNumber(2:3)),5)={FieldSizeResult.Perfil_FieldSizeO_datos(i).T1};
catch
DatosTabla(i+3*sum(PlotNumber(2:3)),5)={[]};
FieldSizeResult.Perfil_FieldSizeO_datos(i).T1=[];
end
try
DatosTabla(i+3*sum(PlotNumber(2:3)),6)={FieldSizeResult.Perfil_FieldSizeO_datos(i).T2};
catch
DatosTabla(i+3*sum(PlotNumber(2:3)),6)={[]};
FieldSizeResult.Perfil_FieldSizeO_datos(i).T2=[];
end
try
DatosTabla(i+3*sum(PlotNumber(2:3)),7)={round(FieldSizeResult.Perfil_FieldSizeO_datos(i).FieldSize_mm-FieldSizeResult.Perfil_FieldSizeO_datos(i).ValorEsperado,1)};
catch
DatosTabla(i+3*sum(PlotNumber(2:3)),7)={[]};
end
end



i=3*sum(PlotNumber(2:3))+PlotNumber(4)+1;
try
DatosTabla(i,1)={FieldSizeResult.FieldSize_X_mean.Nombre};
try
DatosTabla(i,2)={FieldSizeResult.FieldSize_X_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FieldSizeResult.FieldSize_X_mean.SiNo=[];
end
DatosTabla(i,3)={round(FieldSizeResult.FieldSize_X_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FieldSizeResult.FieldSize_X_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FieldSizeResult.FieldSize_X_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FieldSizeResult.FieldSize_X_mean.T1};
catch
DatosTabla(i,5)={[]};
FieldSizeResult.FieldSize_X_mean.T1=[];
end
try
DatosTabla(i,6)={FieldSizeResult.FieldSize_X_mean.T2};
catch
DatosTabla(i,6)={[]};
FieldSizeResult.FieldSize_X_mean.T2=[];
end
try    
DatosTabla(i,7)={round(FieldSizeResult.FieldSize_X_mean.ValorObtenido-FieldSizeResult.FieldSize_X_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
end
i=i+1;
catch
end


try   
DatosTabla(i,1)={FieldSizeResult.FieldSize_Y_mean.Nombre};
try
DatosTabla(i,2)={FieldSizeResult.FieldSize_Y_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FieldSizeResult.FieldSize_X_mean.SiNo=[];
end
DatosTabla(i,3)={round(FieldSizeResult.FieldSize_Y_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FieldSizeResult.FieldSize_Y_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FieldSizeResult.FieldSize_Y_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FieldSizeResult.FieldSize_Y_mean.T1};
catch
DatosTabla(i,5)={[]};
FieldSizeResult.FieldSize_Y_mean.T1=[];
end
try
DatosTabla(i,6)={FieldSizeResult.FieldSize_Y_mean.T2};
catch
DatosTabla(i,6)={[]};
FieldSizeResult.FieldSize_Y_mean.T2=[];
end
try    
DatosTabla(i,7)={round(FieldSizeResult.FieldSize_Y_mean.ValorObtenido-FieldSizeResult.FieldSize_Y_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
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