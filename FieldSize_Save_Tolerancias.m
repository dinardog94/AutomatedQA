function FieldSize_Save_Tolerancias
global myhandles4 FieldSizeResult PlotNumber
DatosTabla=get(myhandles4.uitable3,'data');

for i=1:PlotNumber(2)
FieldSizeResult.Perfil_FieldSizeX_datos(i).SiNo=DatosTabla{3*i-2,2};
FieldSizeResult.Perfil_FieldSizeX_datos(i).ValorEsperado=DatosTabla{3*i-2,4};
FieldSizeResult.Perfil_FieldSizeX_datos(i).T1=DatosTabla{3*i-2,5};
FieldSizeResult.Perfil_FieldSizeX_datos(i).T2=DatosTabla{3*i-2,6};

FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_SiNo=DatosTabla{3*i-1,2};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_ValorEsperado=DatosTabla{3*i-1,4};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T1=DatosTabla{3*i-1,5};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Izq_T2=DatosTabla{3*i-1,6};

FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_SiNo=DatosTabla{3*i,2};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_ValorEsperado=DatosTabla{3*i,4};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T1=DatosTabla{3*i,5};
FieldSizeResult.Perfil_FieldSizeX_datos(i).Der_T2=DatosTabla{3*i,6};
end


for i=1:PlotNumber(3)
FieldSizeResult.Perfil_FieldSizeY_datos(i).SiNo=DatosTabla{3*i+3*PlotNumber(2)-2,2};
FieldSizeResult.Perfil_FieldSizeY_datos(i).ValorEsperado=DatosTabla{3*i+3*PlotNumber(2)-2,4};
FieldSizeResult.Perfil_FieldSizeY_datos(i).T1=DatosTabla{3*i+3*PlotNumber(2)-2,5};
FieldSizeResult.Perfil_FieldSizeY_datos(i).T2=DatosTabla{3*i+3*PlotNumber(2)-2,6};

FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_SiNo=DatosTabla{3*i+3*PlotNumber(2)-1,2};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_ValorEsperado=DatosTabla{3*i+3*PlotNumber(2)-1,4};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T1=DatosTabla{3*i+3*PlotNumber(2)-1,5};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Izq_T2=DatosTabla{3*i+3*PlotNumber(2)-1,6};

FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_SiNo=DatosTabla{3*i+3*PlotNumber(2),2};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_ValorEsperado=DatosTabla{3*i+3*PlotNumber(2),4};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T1=DatosTabla{3*i+3*PlotNumber(2),5};
FieldSizeResult.Perfil_FieldSizeY_datos(i).Der_T2=DatosTabla{3*i+3*PlotNumber(2),6};
end


for i=1:PlotNumber(4)
FieldSizeResult.Perfil_FieldSizeO_datos(i).SiNo=DatosTabla{i+3*sum(PlotNumber(2:3)),2};
FieldSizeResult.Perfil_FieldSizeO_datos(i).ValorEsperado=DatosTabla{i+3*sum(PlotNumber(2:3)),4};
FieldSizeResult.Perfil_FieldSizeO_datos(i).T1=DatosTabla{i+3*sum(PlotNumber(2:3)),5};
FieldSizeResult.Perfil_FieldSizeO_datos(i).T2=DatosTabla{i+3*sum(PlotNumber(2:3)),6};
end

i=3*sum(PlotNumber(2:3))+PlotNumber(4)+1;
try
FieldSizeResult.FieldSize_X_mean.SiNo=DatosTabla{i,2};
FieldSizeResult.FieldSize_X_mean.ValorEsperado=DatosTabla{i,4};
FieldSizeResult.FieldSize_X_mean.T1=DatosTabla{i,5};
FieldSizeResult.FieldSize_X_mean.T2=DatosTabla{i,6};
i=i+1;
catch
end


try   
FieldSizeResult.FieldSize_Y_mean.SiNo=DatosTabla{i,2};
FieldSizeResult.FieldSize_Y_mean.ValorEsperado=DatosTabla{i,4};
FieldSizeResult.FieldSize_Y_mean.T1=DatosTabla{i,5};
FieldSizeResult.FieldSize_Y_mean.T2=DatosTabla{i,6};
catch
end


end