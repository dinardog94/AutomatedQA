function PicketFence_Completar_TablaTolerancias
global PicketFenceResult PlotNumber callindex2 myhandles4 fdt_F warning_F ok_F Variables

if exist('PicketFenceResult','var') && ~isempty(PicketFenceResult) %call interno
else
    PicketFenceResult=Variables.Functions.PicketFence.PicketFenceResult;
    PlotNumber=Variables.Functions.PicketFence.PlotNumber;
end
try
    
DatosTabla(1,1)={PicketFenceResult.PicketFence_Y_mean.Nombre};
try
DatosTabla(1,2)={PicketFenceResult.PicketFence_Y_mean.SiNo};
catch
DatosTabla(1,2)={[]};
PicketFenceResult.PicketFence_Y_mean.SiNo=[];
end
DatosTabla(1,3)={round(PicketFenceResult.PicketFence_Y_mean.ValorObtenido,1)};
try
DatosTabla(1,4)={PicketFenceResult.PicketFence_Y_mean.ValorEsperado};
catch
DatosTabla(1,4)={[]}; 
PicketFenceResult.PicketFence_Y_mean.ValorEsperado=[];
end
try
DatosTabla(1,5)={PicketFenceResult.PicketFence_Y_mean.T1};
catch
DatosTabla(1,5)={[]};
PicketFenceResult.PicketFence_Y_mean.T1=[];
end
try
DatosTabla(1,6)={PicketFenceResult.PicketFence_Y_mean.T2};
catch
DatosTabla(1,6)={[]};
PicketFenceResult.PicketFence_Y_mean.T2=[];
end
try
DatosTabla(1,7)={round(PicketFenceResult.PicketFence_Y_mean.ValorObtenido-PicketFenceResult.PicketFence_Y_mean.ValorEsperado,1)};
catch
DatosTabla(1,7)={[]};
end



DatosTabla(2,1)={PicketFenceResult.PicketFence_Y_max.Nombre};
try
DatosTabla(2,2)={PicketFenceResult.PicketFence_Y_max.SiNo};
catch
DatosTabla(2,2)={[]};
PicketFenceResult.PicketFence_Y_max.SiNo=[];
end
DatosTabla(2,3)={round(PicketFenceResult.PicketFence_Y_max.ValorObtenido,1)};
try
DatosTabla(2,4)={PicketFenceResult.PicketFence_Y_max.ValorEsperado};
catch
DatosTabla(2,4)={[]}; 
PicketFenceResult.PicketFence_Y_max.ValorEsperado=[];
end
try
DatosTabla(2,5)={PicketFenceResult.PicketFence_Y_max.T1};
catch
DatosTabla(2,5)={[]};
PicketFenceResult.PicketFence_Y_max.T1=[];
end
try
DatosTabla(2,6)={PicketFenceResult.PicketFence_Y_max.T2};
catch
DatosTabla(2,6)={[]};
PicketFenceResult.PicketFence_Y_max.T2=[];
end
try
DatosTabla(2,7)={round(PicketFenceResult.PicketFence_Y_max.ValorObtenido-PicketFenceResult.PicketFence_Y_max.ValorEsperado,1)};
catch
DatosTabla(2,7)={[]};
end


DatosTabla(3,1)={PicketFenceResult.PicketFence_Y_min.Nombre};
try
DatosTabla(3,2)={PicketFenceResult.PicketFence_Y_min.SiNo};
catch
DatosTabla(3,2)={[]};
PicketFenceResult.PicketFence_Y_min.SiNo=[];
end
DatosTabla(3,3)={round(PicketFenceResult.PicketFence_Y_min.ValorObtenido,1)};
try
DatosTabla(3,4)={PicketFenceResult.PicketFence_Y_min.ValorEsperado};
catch
DatosTabla(3,4)={[]}; 
PicketFenceResult.PicketFence_Y_min.ValorEsperado=[];
end
try
DatosTabla(3,5)={PicketFenceResult.PicketFence_Y_min.T1};
catch
DatosTabla(3,5)={[]};
PicketFenceResult.PicketFence_Y_min.T1=[];
end
try
DatosTabla(3,6)={PicketFenceResult.PicketFence_Y_min.T2};
catch
DatosTabla(3,6)={[]};
PicketFenceResult.PicketFence_Y_min.T2=[];
end
try
DatosTabla(3,7)={round(PicketFenceResult.PicketFence_Y_min.ValorObtenido-PicketFenceResult.PicketFence_Y_min.ValorEsperado,1)};
catch
DatosTabla(3,7)={[]};
end


try
for i=1:length(PicketFenceResult.Perfil_PicketFenceX_datos)    
DatosTabla(3+i,1)={[PicketFenceResult.Perfil_PicketFenceX_datos(i).Nombre]};
try
DatosTabla(3+i,2)={PicketFenceResult.Perfil_PicketFenceX_datos(i).SiNo};
catch
DatosTabla(3+i,2)={[]};
PicketFenceResult.Perfil_PicketFenceX_datos(i).SiNo=[];
end
DatosTabla(3+i,3)={round(PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorObtenido,1)};
try
DatosTabla(3+i,4)={PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorEsperado};
catch
DatosTabla(3+i,4)={[]}; 
PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorEsperado=[];
end
try
DatosTabla(3+i,5)={PicketFenceResult.Perfil_PicketFenceX_datos(i).T1};
catch
DatosTabla(3+i,5)={[]};
PicketFenceResult.Perfil_PicketFenceX_datos(i).T1=[];
end
try
DatosTabla(3+i,6)={PicketFenceResult.Perfil_PicketFenceX_datos(i).T2};
catch
DatosTabla(3+i,6)={[]};
PicketFenceResult.Perfil_PicketFenceX_datos(i).T2=[];
end
try
DatosTabla(3+i,7)={round(PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorObtenido-PicketFenceResult.Perfil_PicketFenceX_datos(i).ValorEsperado,1)};
catch
DatosTabla(3+i,7)={[]};
end
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