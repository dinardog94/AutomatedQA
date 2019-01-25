function PDDfotones_Completar_TablaTolerancias
global myhandles4 PDDfotonesResult PlotNumber callindex2 fdt_F warning_F ok_F Variables

if exist('PDDfotonesResult','var') && ~isempty(PDDfotonesResult) %call interno
else
    PlotNumber=Variables.Functions.PDDfotones.PlotNumber;
    PDDfotonesResult=Variables.Functions.PDDfotones.PDDfotonesResult;
end

for i=1:PlotNumber(2)
DatosTabla(i,1)={[PDDfotonesResult.Perfil_PDD_datos.Nombre,' - ', num2str(PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).value*100),'%']};
try
DatosTabla(i,2)={PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).SiNo};
catch
DatosTabla(i,2)={[]};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).SiNo=[];
end
DatosTabla(i,3)={PDDfotonesResult.Perfil_PDD_datos.valor_Perc_asked(i)};
try
DatosTabla(i,4)={PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).VE};
catch
DatosTabla(i,4)={[]}; 
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).VE=[];
end
try
DatosTabla(i,5)={PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T1};
catch
DatosTabla(i,5)={[]};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T1=[];
end
try
DatosTabla(i,6)={PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T2};
catch
DatosTabla(i,6)={[]};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T2=[];
end
try
DatosTabla(i,7)={PDDfotonesResult.Perfil_PDD_datos.valor_Perc_asked(i)-PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).VE};
catch
DatosTabla(i,7)={[]};
end
end

for i=(PlotNumber(2)+1):sum(PlotNumber(2:3))
DatosTabla(i,1)={[PDDfotonesResult.Perfil_PDD_datos.Nombre,' - z= ', num2str(PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).value)]};
try
DatosTabla(i,2)={PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).SiNo};
catch
DatosTabla(i,2)={[]};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).SiNo=[];
end
DatosTabla(i,3)={PDDfotonesResult.Perfil_PDD_datos.valor_Z_asked(i-PlotNumber(2))};
try
DatosTabla(i,4)={PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).VE};
catch
DatosTabla(i,4)={[]}; 
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).VE=[];
end
try
DatosTabla(i,5)={PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T1};
catch
DatosTabla(i,5)={[]};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T1=[];
end
try
DatosTabla(i,6)={PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T2};
catch
DatosTabla(i,6)={[]};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T2=[];
end
try
DatosTabla(i,7)={PDDfotonesResult.Perfil_PDD_datos.valor_Z_asked(i-PlotNumber(2))-PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).VE};
catch
DatosTabla(i,7)={[]};
end
end


for i=(sum(PlotNumber(2:3))+1):sum(PlotNumber(2:4))
DatosTabla(i,1)={[PDDfotonesResult.Perfil_PDD_datos.N_asked{i-sum(PlotNumber(2:3))},' / ', PDDfotonesResult.Perfil_PDD_datos.D_asked{i-sum(PlotNumber(2:3))}]};
try
DatosTabla(i,2)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).SiNo};
catch
DatosTabla(i,2)={[]};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).SiNo=[];
end
DatosTabla(i,3)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).value};
try
DatosTabla(i,4)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).VE};
catch
DatosTabla(i,4)={[]}; 
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).VE=[];
end
try
DatosTabla(i,5)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T1};
catch
DatosTabla(i,5)={[]};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T1=[];
end
try
DatosTabla(i,6)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T2};
catch
DatosTabla(i,6)={[]};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T2=[];
end
try
DatosTabla(i,7)={PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).value-PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).VE};
catch
DatosTabla(i,7)={[]};
end
end


colergen = @(color,text) ['<html><table border=0 width=800 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
for i=1:length(DatosTabla(:,1))
    if DatosTabla{i,2}==1;
    if  abs(DatosTabla{i,7})>DatosTabla{i,6} 
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