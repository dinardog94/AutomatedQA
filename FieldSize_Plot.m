function FieldSize_Plot
global PlotNumber myhandles4 FieldSizeResult Variables
Data1=myhandles4.uitable1.Data;

if exist('FieldSizeResult','var') && ~isempty(FieldSizeResult) %call interno
else
    PlotNumber=Variables.Functions.FieldSize.PlotNumber;
    FieldSizeResult=Variables.Functions.FieldSize.FieldSizeResult;
end
    
try
if PlotNumber(1)<=PlotNumber(2)
perfil=FieldSizeResult.Perfil_FieldSizeX_datos(PlotNumber(1)).datos;
pix_central=FieldSizeResult.Perfil_FieldSizeX_datos(PlotNumber(1)).pix_central;
pix_limite_50_1=FieldSizeResult.Perfil_FieldSizeX_datos(PlotNumber(1)).pix50_1;
pix_limite_50_2=FieldSizeResult.Perfil_FieldSizeX_datos(PlotNumber(1)).pix50_2;
CentralAxisValue=perfil(pix_central);
PerfilPloteado=FieldSizeResult.Perfil_FieldSizeX_datos(PlotNumber(1)).Nombre;
FSindex=1;
elseif PlotNumber(1)>PlotNumber(2) && PlotNumber(1)<=sum(PlotNumber(2:3))
perfil=FieldSizeResult.Perfil_FieldSizeY_datos(PlotNumber(1)-PlotNumber(2)).datos;
pix_central=FieldSizeResult.Perfil_FieldSizeY_datos(PlotNumber(1)-PlotNumber(2)).pix_central;
pix_limite_50_1=FieldSizeResult.Perfil_FieldSizeY_datos(PlotNumber(1)-PlotNumber(2)).pix50_1;
pix_limite_50_2=FieldSizeResult.Perfil_FieldSizeY_datos(PlotNumber(1)-PlotNumber(2)).pix50_2;
CentralAxisValue=perfil(pix_central);
PerfilPloteado=FieldSizeResult.Perfil_FieldSizeY_datos(PlotNumber(1)-PlotNumber(2)).Nombre;
FSindex=2;
elseif PlotNumber(1)>sum(PlotNumber(2:3)) && PlotNumber(1)<=sum(PlotNumber(2:4))
perfil=FieldSizeResult.Perfil_FieldSizeO_datos(PlotNumber(1)-sum(PlotNumber(2:3))).datos;
pix_central=FieldSizeResult.Perfil_FieldSizeO_datos(PlotNumber(1)-sum(PlotNumber(2:3))).pix_central;
pix_limite_50_1=FieldSizeResult.Perfil_FieldSizeO_datos(PlotNumber(1)-sum(PlotNumber(2:3))).pix50_1;
pix_limite_50_2=FieldSizeResult.Perfil_FieldSizeO_datos(PlotNumber(1)-sum(PlotNumber(2:3))).pix50_2;
CentralAxisValue=perfil(pix_central);
PerfilPloteado=FieldSizeResult.Perfil_FieldSizeO_datos(PlotNumber(1)-sum(PlotNumber(2:3))).Nombre;
FSindex=3;
end    
percentage=Data1{1,FSindex}/100;
hold off
axes(myhandles4.axes1)
plot(perfil,'LineWidth',2)
hold on
v=pix_limite_50_1;
plot([v v], ylim,'--k');
v=pix_limite_50_2;
plot([v v], ylim,'--k');
v=pix_central;
plot([v v], ylim,'--k');
h=CentralAxisValue;
plot(xlim,[h h],'--k');
h=CentralAxisValue*percentage;
plot(xlim,[h h],'--k');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:4)))]};
myhandles4.text3.String=PerfilPloteado;
catch
    uiwait(errordlg('Complete las tablas de datos de input'));
end
end