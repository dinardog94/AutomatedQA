function FlatnessSymmetry_Completar_TablaTolerancias
global myhandles4 FlatnessSymmetryResult PlotNumber callindex2 fdt_F warning_F ok_F Variables


if exist('FlatnessSymmetryResult','var') && ~isempty(FlatnessSymmetryResult) %call interno
else
    FlatnessSymmetryResult=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult;
    PlotNumber=Variables.Functions.FlatnessSymmetry.PlotNumber;
end

for i=1:PlotNumber(2)
DatosTabla(2*i-1,1)={[FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Nombre,' Flatness']};
try
DatosTabla(2*i-1,2)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_SiNo};
catch
DatosTabla(2*i-1,2)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_SiNo=[];
end
DatosTabla(2*i-1,3)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Flatness,1)};
try
DatosTabla(2*i-1,4)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_VE};
catch
DatosTabla(2*i-1,4)={[]}; 
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_VE=[];
end
try
DatosTabla(2*i-1,5)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T1};
catch
DatosTabla(2*i-1,5)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T1=[];
end
try
DatosTabla(2*i-1,6)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T2};
catch
DatosTabla(2*i-1,6)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T2=[];
end
try
DatosTabla(2*i-1,7)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Flatness-FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_VE,1)};
catch
DatosTabla(2*i-1,7)={[]};
end


DatosTabla(2*i,1)={[FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Nombre,' Symmetry']};
try
DatosTabla(2*i,2)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_SiNo};
catch
DatosTabla(2*i,2)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_SiNo=[];
end
DatosTabla(2*i,3)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Symmetry,1)};
try
DatosTabla(2*i,4)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_VE};
catch
DatosTabla(2*i,4)={[]}; 
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_VE=[];
end
try
DatosTabla(2*i,5)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T1};
catch
DatosTabla(2*i,5)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T1=[];
end
try
DatosTabla(2*i,6)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T2};
catch
DatosTabla(2*i,6)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T2=[];
end
try
DatosTabla(2*i,7)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).Symmetry-FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_VE,1)};
catch
DatosTabla(2*i,7)={[]};
end
end


try
for i=1:PlotNumber(3)
DatosTabla(2*i+2*PlotNumber(2)-1,1)={[FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Nombre,' Flatness']};
try
DatosTabla(2*i+2*PlotNumber(2)-1,2)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_SiNo};
catch
DatosTabla(2*i+2*PlotNumber(2)-1,2)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_SiNo=[];
end
DatosTabla(2*i+2*PlotNumber(2)-1,3)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Flatness,1)};
try
DatosTabla(2*i+2*PlotNumber(2)-1,4)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_VE};
catch
DatosTabla(2*i+2*PlotNumber(2)-1,4)={[]}; 
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_VE=[];
end
try
DatosTabla(2*i+2*PlotNumber(2)-1,5)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T1};
catch
DatosTabla(2*i+2*PlotNumber(2)-1,5)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T1=[];
end
try
DatosTabla(2*i+2*PlotNumber(2)-1,6)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T2};
catch
DatosTabla(2*i+2*PlotNumber(2)-1,6)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T2=[];
end
try
DatosTabla(2*i+2*PlotNumber(2)-1,7)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Flatness-FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_VE,1)};
catch
DatosTabla(2*i+2*PlotNumber(2)-1,7)={[]};
end

DatosTabla(2*i+2*PlotNumber(2),1)={[FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Nombre,' Symmetry']};
try
DatosTabla(2*i+2*PlotNumber(2),2)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_SiNo};
catch
DatosTabla(2*i+2*PlotNumber(2),2)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_SiNo=[];
end
DatosTabla(2*i+2*PlotNumber(2),3)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Symmetry,1)};
try
DatosTabla(2*i+2*PlotNumber(2),4)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_VE};
catch
DatosTabla(2*i+2*PlotNumber(2),4)={[]}; 
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_VE=[];
end
try
DatosTabla(2*i+2*PlotNumber(2),5)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T1};
catch
DatosTabla(2*i+2*PlotNumber(2),5)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T1=[];
end
try
DatosTabla(2*i+2*PlotNumber(2),6)={FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T2};
catch
DatosTabla(2*i+2*PlotNumber(2),6)={[]};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T2=[];
end
try
DatosTabla(2*i+2*PlotNumber(2),7)={round(FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).Symmetry-FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_VE,1)};
catch
DatosTabla(2*i+2*PlotNumber(2),7)={[]};
end
end




for i=1:PlotNumber(4)
DatosTabla(i+2*sum(PlotNumber(2:3)),1)={[FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).Nombre,' Flatness']};
try
DatosTabla(i+2*sum(PlotNumber(2:3)),2)={FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).SiNo};
catch
DatosTabla(i+2*sum(PlotNumber(2:3)),2)={[]};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).SiNo=[];
end
DatosTabla(i+2*sum(PlotNumber(2:3)),3)={round(FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).Flatness,1)};
try
DatosTabla(i+2*sum(PlotNumber(2:3)),4)={FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).ValorEsperado};
catch
DatosTabla(i+2*sum(PlotNumber(2:3)),4)={[]}; 
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).ValorEsperado=[];
end
try
DatosTabla(i+2*sum(PlotNumber(2:3)),5)={FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T1};
catch
DatosTabla(i+2*sum(PlotNumber(2:3)),5)={[]};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T1=[];
end
try
DatosTabla(i+2*sum(PlotNumber(2:3)),6)={FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T2};
catch
DatosTabla(i+2*sum(PlotNumber(2:3)),6)={[]};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T2=[];
end
try
DatosTabla(i+2*sum(PlotNumber(2:3)),7)={round(FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).Flatness-FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).ValorEsperado,1)};
catch
DatosTabla(i+2*sum(PlotNumber(2:3)),7)={[]};
end
end



i=2*sum(PlotNumber(2:3))+PlotNumber(4)+1;
if isfield(FlatnessSymmetryResult,'Flatness_X_mean')
try
DatosTabla(i,1)={FlatnessSymmetryResult.Flatness_X_mean.Nombre};
try
DatosTabla(i,2)={FlatnessSymmetryResult.Flatness_X_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FlatnessSymmetryResult.Flatness_X_mean.SiNo=[];
end
DatosTabla(i,3)={round(FlatnessSymmetryResult.Flatness_X_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FlatnessSymmetryResult.Flatness_X_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FlatnessSymmetryResult.Flatness_X_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FlatnessSymmetryResult.Flatness_X_mean.T1};
catch
DatosTabla(i,5)={[]};
FlatnessSymmetryResult.Flatness_X_mean.T1=[];
end
try
DatosTabla(i,6)={FlatnessSymmetryResult.Flatness_X_mean.T2};
catch
DatosTabla(i,6)={[]};
FlatnessSymmetryResult.Flatness_X_mean.T2=[];
end
try    
DatosTabla(i,7)={round(FlatnessSymmetryResult.Flatness_X_mean.ValorObtenido-FlatnessSymmetryResult.Flatness_X_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
end
i=i+1;
catch
end


try
DatosTabla(i,1)={FlatnessSymmetryResult.Symmetry_X_mean.Nombre};
try
DatosTabla(i,2)={FlatnessSymmetryResult.Symmetry_X_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FlatnessSymmetryResult.Symmetry_X_mean.SiNo=[];
end
DatosTabla(i,3)={round(FlatnessSymmetryResult.Symmetry_X_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FlatnessSymmetryResult.Symmetry_X_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FlatnessSymmetryResult.Symmetry_X_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FlatnessSymmetryResult.Symmetry_X_mean.T1};
catch
DatosTabla(i,5)={[]};
FlatnessSymmetryResult.Symmetry_X_mean.T1=[];
end
try
DatosTabla(i,6)={FlatnessSymmetryResult.Symmetry_X_mean.T2};
catch
DatosTabla(i,6)={[]};
FlatnessSymmetryResult.Symmetry_X_mean.T2=[];
end
try    
DatosTabla(i,7)={round(FlatnessSymmetryResult.Symmetry_X_mean.ValorObtenido-FlatnessSymmetryResult.Symmetry_X_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
end
i=i+1;
catch
end
end


if isfield(FlatnessSymmetryResult,'Flatness_Y_mean')
try
DatosTabla(i,1)={FlatnessSymmetryResult.Flatness_Y_mean.Nombre};
try
DatosTabla(i,2)={FlatnessSymmetryResult.Flatness_Y_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FlatnessSymmetryResult.Flatness_Y_mean.SiNo=[];
end
DatosTabla(i,3)={round(FlatnessSymmetryResult.Flatness_Y_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FlatnessSymmetryResult.Flatness_Y_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FlatnessSymmetryResult.Flatness_Y_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FlatnessSymmetryResult.Flatness_Y_mean.T1};
catch
DatosTabla(i,5)={[]};
FlatnessSymmetryResult.Flatness_Y_mean.T1=[];
end
try
DatosTabla(i,6)={FlatnessSymmetryResult.Flatness_Y_mean.T2};
catch
DatosTabla(i,6)={[]};
FlatnessSymmetryResult.Flatness_XYmean.T2=[];
end
try    
DatosTabla(i,7)={round(FlatnessSymmetryResult.Flatness_Y_mean.ValorObtenido-FlatnessSymmetryResult.Flatness_Y_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
end
i=i+1;
catch
end


try
DatosTabla(i,1)={FlatnessSymmetryResult.Symmetry_Y_mean.Nombre};
try
DatosTabla(i,2)={FlatnessSymmetryResult.Symmetry_Y_mean.SiNo};
catch
DatosTabla(i,2)={[]};
FlatnessSymmetryResult.Symmetry_Y_mean.SiNo=[];
end
DatosTabla(i,3)={round(FlatnessSymmetryResult.Symmetry_Y_mean.ValorObtenido,1)};
try
DatosTabla(i,4)={FlatnessSymmetryResult.Symmetry_Y_mean.ValorEsperado};
catch
DatosTabla(i,4)={[]};
FlatnessSymmetryResult.Symmetry_Y_mean.ValorEsperado=[];
end
try
DatosTabla(i,5)={FlatnessSymmetryResult.Symmetry_Y_mean.T1};
catch
DatosTabla(i,5)={[]};
FlatnessSymmetryResult.Symmetry_Y_mean.T1=[];
end
try
DatosTabla(i,6)={FlatnessSymmetryResult.Symmetry_Y_mean.T2};
catch
DatosTabla(i,6)={[]};
FlatnessSymmetryResult.Symmetry_Y_mean.T2=[];
end
try    
DatosTabla(i,7)={round(FlatnessSymmetryResult.Symmetry_Y_mean.ValorObtenido-FlatnessSymmetryResult.Symmetry_Y_mean.ValorEsperado,1)};
catch
DatosTabla(i,7)={[]};  
end
catch
end
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