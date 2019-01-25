
function FlatnessSymmetry_Save_Tolerancias
global myhandles4 FlatnessSymmetryResult PlotNumber
DatosTabla=get(myhandles4.uitable3,'data');

for i=1:PlotNumber(2)
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_SiNo=DatosTabla{2*i-1,2};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_VE=DatosTabla{2*i-1,4};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T1=DatosTabla{2*i-1,5};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).F_T2=DatosTabla{2*i-1,6};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_SiNo=DatosTabla{2*i,2};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_VE=DatosTabla{2*i,4};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T1=DatosTabla{2*i,5};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(i).S_T2=DatosTabla{2*i,6};
end


for i=1:PlotNumber(3)
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_SiNo=DatosTabla{2*i+2*PlotNumber(2)-1,2};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_VE=DatosTabla{2*i+2*PlotNumber(2)-1,4};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T1=DatosTabla{2*i+2*PlotNumber(2)-1,5};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).F_T2=DatosTabla{2*i+2*PlotNumber(2)-1,6};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_SiNo=DatosTabla{2*i+2*PlotNumber(2),2};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_VE=DatosTabla{2*i+2*PlotNumber(2),4};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T1=DatosTabla{2*i+2*PlotNumber(2),5};
FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(i).S_T2=DatosTabla{2*i+2*PlotNumber(2),6};
end


for i=1:PlotNumber(4)
    
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).SiNo=DatosTabla{i+2*sum(PlotNumber(2:3)),2};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).ValorEsperado=DatosTabla{i+2*sum(PlotNumber(2:3)),4};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T1=DatosTabla{i+2*sum(PlotNumber(2:3)),5};
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(i).T2=DatosTabla{i+2*sum(PlotNumber(2:3)),6};
end

i=2*sum(PlotNumber(2:3))+PlotNumber(4)+1;
try
FlatnessSymmetryResult.Flatness_X_mean.SiNo=DatosTabla{i,2};
FlatnessSymmetryResult.Flatness_X_mean.ValorEsperado=DatosTabla{i,4};
FlatnessSymmetryResult.Flatness_X_mean.T1=DatosTabla{i,5};
FlatnessSymmetryResult.Flatness_X_mean.T2=DatosTabla{i,6};
i=i+1;
catch
end

try
FlatnessSymmetryResult.Symmetry_X_mean.SiNo=DatosTabla{i,2};
FlatnessSymmetryResult.Symmetry_X_mean.ValorEsperado=DatosTabla{i,4};
FlatnessSymmetryResult.Symmetry_X_mean.T1=DatosTabla{i,5};
FlatnessSymmetryResult.Symmetry_X_mean.T2=DatosTabla{i,6};
i=i+1;
catch
end

try   
FlatnessSymmetryResult.Flatness_Y_mean.SiNo=DatosTabla{i,2};
FlatnessSymmetryResult.Flatness_Y_mean.ValorEsperado=DatosTabla{i,4};
FlatnessSymmetryResult.Flatness_Y_mean.T1=DatosTabla{i,5};
FlatnessSymmetryResult.Flatness_Y_mean.T2=DatosTabla{i,6};
i=i+1;
catch
end

try   
FlatnessSymmetryResult.Symmetry_Y_mean.SiNo=DatosTabla{i,2};
FlatnessSymmetryResult.Symmetry_Y_mean.ValorEsperado=DatosTabla{i,4};
FlatnessSymmetryResult.Symmetry_Y_mean.T1=DatosTabla{i,5};
FlatnessSymmetryResult.Symmetry_Y_mean.T2=DatosTabla{i,6};
catch
end


end