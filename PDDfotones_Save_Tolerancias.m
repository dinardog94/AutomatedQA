
function PDDfotones_Save_Tolerancias
global myhandles4 PDDfotonesResult PlotNumber
DatosTabla=get(myhandles4.uitable3,'data');

for i=1:PlotNumber(2)
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).SiNo=DatosTabla{i,2};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).VE=DatosTabla{i,4};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T1=DatosTabla{i,5};
PDDfotonesResult.Perfil_PDD_datos.Perc_asked(i).T2=DatosTabla{i,6};
end


for i=(PlotNumber(2)+1):sum(PlotNumber(2:3))
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).SiNo=DatosTabla{i,2};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).VE=DatosTabla{i,4};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T1=DatosTabla{i,5};
PDDfotonesResult.Perfil_PDD_datos.Z_asked(i-PlotNumber(2)).T2=DatosTabla{i,6};
end

for i=(sum(PlotNumber(2:3))+1):sum(PlotNumber(2:4))
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).SiNo=DatosTabla{i,2};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).VE=DatosTabla{i,4};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T1=DatosTabla{i,5};
PDDfotonesResult.Perfil_PDD_datos.R_asked(i-sum(PlotNumber(2:3))).T2=DatosTabla{i,6};
end


end