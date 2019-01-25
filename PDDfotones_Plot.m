function PDDfotones_Plot
global PlotNumber myhandles4 PDDfotonesResult Variables

if exist('PDDfotonesResult','var') && ~isempty(PDDfotonesResult)  %call interno
else
    PlotNumber=Variables.Functions.PDDfotones.PlotNumber;
    PDDfotonesResult=Variables.Functions.PDDfotones.PDDfotonesResult;
end

try
perfil=PDDfotonesResult.Perfil_PDD_datos.datos;
pix_max=PDDfotonesResult.Perfil_PDD_datos.pix_max;
valor_max=PDDfotonesResult.Perfil_PDD_datos.datos(pix_max);
new_S=PDDfotonesResult.Perfil_PDD_datos.new_S;

if PlotNumber(1)<=PlotNumber(2)
Perc_asked=PDDfotonesResult.Perfil_PDD_datos.Perc_asked(PlotNumber(1)).value*100;
pix_Perc_asked=PDDfotonesResult.Perfil_PDD_datos.pix_Perc_asked(PlotNumber(1));
PerfilPloteado=[PDDfotonesResult.Perfil_PDD_datos.Nombre,' - ', num2str(Perc_asked),'%'];

hold off
axes(myhandles4.axes1)
axis=gca;
delete(axis.Children)
plot((1:length(perfil))/new_S,(perfil/valor_max)*100)
ylim([0 120])
hold on
v=pix_max/new_S;
plot([v v], ylim,'--k');
v=pix_Perc_asked/new_S;
plot([v v], ylim,'--k');
h=100;
plot(xlim,[h h],'--k');
h=Perc_asked;
plot(xlim,[h h],'--k');

plot(pix_Perc_asked/new_S,(perfil(pix_Perc_asked)/valor_max)*100,'r*');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:3)))]};
myhandles4.text3.String=PerfilPloteado;

elseif (PlotNumber(1)>PlotNumber(2))&&(PlotNumber(1)<=sum(PlotNumber(2:3)))
Z_asked=PDDfotonesResult.Perfil_PDD_datos.Z_asked(PlotNumber(1)-PlotNumber(2)).value;
valor_Z_asked=PDDfotonesResult.Perfil_PDD_datos.valor_Z_asked(PlotNumber(1)-PlotNumber(2));
pix_Z_asked=PDDfotonesResult.Perfil_PDD_datos.pix_Z_asked(PlotNumber(1)-PlotNumber(2));
PerfilPloteado=[PDDfotonesResult.Perfil_PDD_datos.Nombre,' - z=', num2str(Z_asked)];

hold off
axes(myhandles4.axes1)
axis=gca;
delete(axis.Children)
plot((1:length(perfil))/new_S,(perfil/valor_max)*100)
ylim([0 120])
hold on
v=pix_max/new_S;
plot([v v], ylim,'--k');
v=Z_asked;
plot([v v], ylim,'--k');
h=100;
plot(xlim,[h h],'--k');
h=valor_Z_asked;
plot(xlim,[h h],'--k');

plot(Z_asked,(perfil(pix_Z_asked)/valor_max)*100,'r*');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:3)))]};
myhandles4.text3.String=PerfilPloteado;
elseif PlotNumber(1)==sum(PlotNumber(2:4))
    PlotNumber(1)=sum(PlotNumber(2:3));
    
    
elseif PlotNumber(1)==sum(PlotNumber(2:3))+1
    PlotNumber(1)=1;
    
    Perc_asked=PDDfotonesResult.Perfil_PDD_datos.Perc_asked(PlotNumber(1)).value*100;
pix_Perc_asked=PDDfotonesResult.Perfil_PDD_datos.pix_Perc_asked(PlotNumber(1));
PerfilPloteado=[PDDfotonesResult.Perfil_PDD_datos.Nombre,' - ', num2str(Perc_asked),'%'];

hold off
axes(myhandles4.axes1)
axis=gca;
delete(axis.Children)
plot((1:length(perfil))/new_S,(perfil/valor_max)*100)
ylim([0 120])
hold on
v=pix_max/new_S;
plot([v v], ylim,'--k');
v=pix_Perc_asked/new_S;
plot([v v], ylim,'--k');
h=100;
plot(xlim,[h h],'--k');
h=Perc_asked;
plot(xlim,[h h],'--k');

plot(pix_Perc_asked/new_S,(perfil(pix_Perc_asked)/valor_max)*100,'r*');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:3)))]};
myhandles4.text3.String=PerfilPloteado;
end
catch
    uiwait(errordlg('Complete las tablas de datos de input'));

end