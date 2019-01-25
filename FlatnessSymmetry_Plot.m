function FlatnessSymmetry_Plot
global PlotNumber myhandles4 FlatnessSymmetryResult OutputIMG Variables
Data1=myhandles4.uitable1.Data;
if exist('FlatnessSymmetryResult','var') && ~isempty(FlatnessSymmetryResult) %call interno
else
    PlotNumber=Variables.Functions.FlatnessSymmetry.PlotNumber;
    FlatnessSymmetryResult=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult;
end       

try
if PlotNumber(1)<=PlotNumber(2)
perfil=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).datos;
pix_central=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).pix_central;
pix_limite_50_1=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).pix50_1;
pix_limite_50_2=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).pix50_2;
pix_limite_80_1=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).pix80_1;
pix_limite_80_2=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).pix80_2;
pix_min=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).min_pix;
pix_max=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).max_pix;
CentralAxisValue=perfil(pix_central);
PerfilPloteado=FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos(PlotNumber(1)).Nombre;
percentage=Data1{1,1}/100;
hold off
axes(myhandles4.axes1)
axis=gca;
delete(axis.Children)
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
v=pix_limite_80_1;
plot([v v], ylim,'--k');
v=pix_limite_80_2;
plot([v v], ylim,'--k');
plot(pix_min,perfil(pix_min),'b*');
plot(pix_max,perfil(pix_max),'r*');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:4)))]};
myhandles4.text3.String=PerfilPloteado;

elseif PlotNumber(1)>PlotNumber(2) && PlotNumber(1)<=sum(PlotNumber(2:3))
perfil=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).datos;
pix_central=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).pix_central;
pix_limite_50_1=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).pix50_1;
pix_limite_50_2=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).pix50_2;
pix_limite_80_1=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).pix80_1;
pix_limite_80_2=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).pix80_2;
pix_min=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).min_pix;
pix_max=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).max_pix;
CentralAxisValue=perfil(pix_central);
PerfilPloteado=FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos(PlotNumber(1)-PlotNumber(2)).Nombre;
percentage=Data1{1,2}/100;
hold off
axes(myhandles4.axes1)
axis=gca;
delete(axis.Children)
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
v=pix_limite_80_1;
plot([v v], ylim,'--k');
v=pix_limite_80_2;
plot([v v], ylim,'--k');
plot(pix_min,perfil(pix_min),'b*');
plot(pix_max,perfil(pix_max),'r*');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:4)))]};
myhandles4.text3.String=PerfilPloteado;

elseif PlotNumber(1)>sum(PlotNumber(2:3))
pix_min_coord=FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(PlotNumber(1)-sum(PlotNumber(2:3))).min_coord_img;
pix_max_coord=FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(PlotNumber(1)-sum(PlotNumber(2:3))).max_coord_img;
VerticesPoly=FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(PlotNumber(1)-sum(PlotNumber(2:3))).Posicion;
PerfilPloteado=FlatnessSymmetryResult.Area_FlatnessSymmetry_datos(PlotNumber(1)-sum(PlotNumber(2:3))).Nombre;
hold off
axes(myhandles4.axes1)
imagesc(OutputIMG)
fcn = makeConstrainToRectFcn('impoly', [min(VerticesPoly(:,1)) max(VerticesPoly(:,1))],  [min(VerticesPoly(:,2)) max(VerticesPoly(:,2))]);
h=impoly(myhandles4.axes1,VerticesPoly);
setPositionConstraintFcn(h,fcn);
setColor(h,'green')
addNewPositionCallback(h,@newposcbpoly);
hmin=impoint(gca,pix_min_coord);
setColor(hmin,'blue');
hmax=impoint(gca,pix_max_coord);
setColor(hmax,'red');
myhandles4.text2.String={[num2str(PlotNumber(1)),'/',num2str(sum(PlotNumber(2:4)))]};
myhandles4.text3.String=PerfilPloteado;
end
    catch
    uiwait(errordlg('Complete las tablas de datos de input'));
    end
end
