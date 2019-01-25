function PicketFence_Plot
global PlotNumber myhandles4 PicketFenceResult Variables OutputIMG S OrigenCoord
Data1=myhandles4.uitable1.Data;

if exist('PicketFenceResult','var') && ~isempty(PicketFenceResult) %call interno
else
    PlotNumber=Variables.Functions.PicketFence.PlotNumber;
    PicketFenceResult=Variables.Functions.PicketFence.PicketFenceResult;
end
    
try
if PlotNumber(1)==1
        hold off
        axes(myhandles4.axes1)
        delete(findall(gcf,'type','annotation'))
        axis=gca;
        delete(axis.Children)
        legendStr=cell(1,length(PicketFenceResult.Perfil_PicketFenceY_datos));
    for i=1:length(PicketFenceResult.Perfil_PicketFenceY_datos)
        legendStr{i}=PicketFenceResult.Perfil_PicketFenceY_datos(i).Nombre;
        xn=(1:length(PicketFenceResult.Perfil_PicketFenceY_datos(i).datos))*S;
        plot(xn,PicketFenceResult.Perfil_PicketFenceY_datos(i).datos)
        hold on
    end
        v=PicketFenceResult.PicketFence_Y_max.Pixel*S;
        plot([v v], ylim,'--k');
        v=PicketFenceResult.PicketFence_Y_min.Pixel*S;
        plot([v v], ylim,'--k');
        plot(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).pix_locs(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).w_max_idx)*S,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).pks(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).w_max_idx),'*r')
        plot(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).pix_locs(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).w_min_idx)*S,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).pks(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).w_min_idx),'*b')
        legend(legendStr)
        myhandles4.text2.String={[num2str(1),'/',num2str(sum(PlotNumber(2:end)))]};
        myhandles4.text3.String='Gaps overlap';
        hold off
elseif PlotNumber(1)==2
        hold off
        axes(myhandles4.axes1)
        axis=gca;
        delete(axis.Children)
        perfil=PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).datos;
        xn=(1:length(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).datos))*S;
        plot(xn,perfil)
        hold on
        v=PicketFenceResult.PicketFence_Y_max.Pixel*S;
        plot([v v], ylim,'--k');
        plot(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).pix_locs(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).w_max_idx)*S,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).pks(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).w_max_idx),'*r')
        myhandles4.text2.String={[num2str(2),'/',num2str(sum(PlotNumber(2:end)))]};
        myhandles4.text3.String='Max Gap';
        legend(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).Nombre)
elseif PlotNumber(1)==3
        hold off
        axes(myhandles4.axes1)
        delete(findall(gcf,'type','annotation'))
        axis=gca;
        delete(axis.Children)
        perfil=PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).datos;
        xn=(1:length(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).datos))*S;
        plot(xn,perfil)
        hold on
        v=PicketFenceResult.PicketFence_Y_min.Pixel*S;
        plot([v v], ylim,'--k');
        plot(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).pix_locs(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).w_min_idx)*S,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).pks(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).w_min_idx),'*b')
        myhandles4.text2.String={[num2str(3),'/',num2str(sum(PlotNumber(2:end)))]};
        myhandles4.text3.String='Min Gap';
        legend(PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).Nombre)
elseif PlotNumber(1)==4
        hold off
        axes(myhandles4.axes1)
        axis=gca;
        delete(axis.Children)
        imagesc(OutputIMG)
        PlotString=['Max Gap position: [',num2str(round(PicketFenceResult.PicketFence_Y_max.Posicion)),']  -  ','Min Gap position: [',num2str(round(PicketFenceResult.PicketFence_Y_min.Posicion)),']'];
        annotation('textbox', [0.6,0.01,0.1,0.1],'String', PlotString)
        hmax=impoint(gca,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_max.Index).w_max_pos);
        setColor(hmax,'red');
        hmin=impoint(gca,PicketFenceResult.Perfil_PicketFenceY_datos(PicketFenceResult.PicketFence_Y_min.Index).w_min_pos);
        setColor(hmin,'blue');
        myhandles4.text2.String={[num2str(4),'/',num2str(sum(PlotNumber(2:end)))]};
        myhandles4.text3.String='Max & Min Gap';
elseif PlotNumber(1)>4
        i=PlotNumber(1)-4;
        hold off
        axes(myhandles4.axes1)
        delete(findall(gcf,'type','annotation'))
        axis=gca;
        delete(axis.Children)
        ejeX=(PicketFenceResult.Perfil_PicketFenceX_datos(i).coordx - OrigenCoord.posicion(1))*S;
        plot(ejeX,PicketFenceResult.Perfil_PicketFenceX_datos(i).datos)
        hold on
        plot(ejeX(PicketFenceResult.Perfil_PicketFenceX_datos(i).datos_inf),PicketFenceResult.Perfil_PicketFenceX_datos(i).datos(PicketFenceResult.Perfil_PicketFenceX_datos(i).datos_inf),'*b')
        plot(ejeX(PicketFenceResult.Perfil_PicketFenceX_datos(i).datos_sup),PicketFenceResult.Perfil_PicketFenceX_datos(i).datos(PicketFenceResult.Perfil_PicketFenceX_datos(i).datos_sup),'*r')
        v=PicketFenceResult.PicketFence_Y_mean.ValorGapMean;
        plot(xlim,[v v],'--k');
        myhandles4.text2.String={[num2str(4+i),'/',num2str(sum(PlotNumber(2:end)))]};
        myhandles4.text3.String=PicketFenceResult.Perfil_PicketFenceX_datos(i).Nombre;
end    
catch
    uiwait(errordlg('Complete las tablas de datos de input'));
end
end