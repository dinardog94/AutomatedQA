function CenterShift_Plot
global PlotNumber myhandles4 CenterShiftResult Variables OutputIMG R S T OrigenCoord
Data1=myhandles4.uitable1.Data;

if exist('CenterShiftResult','var') && ~isempty(CenterShiftResult) %call interno
else
    PlotNumber=Variables.Functions.CenterShift.PlotNumber;
    CenterShiftResult=Variables.Functions.CenterShift.CenterShiftResult;
end
    
try
if PlotNumber(1)==1
        hold off
        axes(myhandles4.axes1)
        axis=gca;
        delete(axis.Children)
        imagesc(OutputIMG)
        colormap(parula)
        h=impoint(gca,[OrigenCoord.posicion(1) OrigenCoord.posicion(2)]);
        setColor(h,[0 0 0]);
        h=imline(gca,[1 length(OutputIMG(1,:))], [OrigenCoord.posicion(2) OrigenCoord.posicion(2)]);
        setColor(h,[0 0 0]);
        h=imline(gca,[OrigenCoord.posicion(1) OrigenCoord.posicion(1)], [1 length(OutputIMG(:,1))]);
        setColor(h,[0 0 0]);
        
        Xcenter_img=round(length(OutputIMG(1,:))/2);
        Ycenter_img=round(length(OutputIMG(:,1))/2);
        h=impoint(gca,[Xcenter_img Ycenter_img]);
        setColor(h,'red');
        h=imline(gca,[1 length(OutputIMG(1,:))], [Ycenter_img Ycenter_img]);
        setColor(h,'red');
        h=imline(gca,[Xcenter_img Xcenter_img], [1 length(OutputIMG(:,1))]);
        setColor(h,'red');
        text(length(OutputIMG(1,:))*0.75,40,'Eje fiduciales s/rot','Color','black','FontSize',10);
        text(length(OutputIMG(1,:))*0.75,125,'Eje centro imagen','Color','red','FontSize',10);
        myhandles4.text2.String={[num2str(1),'/',num2str(2)]};
        myhandles4.text3.String='Center shift sin rotación';
        hold off
        zoom on

elseif PlotNumber(1)==2
        hold off
        axes(myhandles4.axes1)
        axis=gca;
        delete(axis.Children)
        imagesc(OutputIMG)
        colormap(parula)
        R_inv=inv(R);
        %X=0;
        Xxmin_pix=1;
        Xxmin_mm=((Xxmin_pix*S+T(2)*R_inv(1,2))/R_inv(1,1))+T(1);
        Yxmin_pix=round(((Xxmin_mm-T(1))*R_inv(2,1)-(T(2)*R_inv(2,2)))/S);
        Yxmin_mm=0;
        %X=Xmax;
        Xxmax_pix=length(OutputIMG(1,:));
        Xxmax_mm=((Xxmax_pix*S+T(2)*R_inv(1,2))/R_inv(1,1))+T(1);
        Yxmax_pix=round(((Xxmax_mm-T(1))*R_inv(2,1)-(T(2)*R_inv(2,2)))/S);
        Yxmax_mm=0;
        %Y=0;
        Yymin_pix=1;
        Yymin_mm=((Yymin_pix*S+T(1)*R_inv(2,1))/R_inv(2,2))+T(2);
        Xymin_pix=round(((Yymin_mm-T(2))*R_inv(1,2)-(T(1)*R_inv(1,1)))/S);
        Xymin_mm=0;
        %Y=Ymax;
        Yymax_pix=length(OutputIMG(:,1));
        Yymax_mm=((Yymax_pix*S+T(1)*R_inv(2,1))/R_inv(2,2))+T(2);
        Xymax_pix=round(((Yymax_mm-T(2))*R_inv(1,2)-(T(1)*R_inv(1,1)))/S);
        Xymax_mm=0;

        h=impoint(gca,[OrigenCoord.posicion(1) OrigenCoord.posicion(2)]);
        setColor(h,[0 0 0]);
        h=imline(gca,[Xxmin_pix Xxmax_pix], [Yxmin_pix Yxmax_pix]);
        setColor(h,[0 0 0]);
        h=imline(gca,[Xymin_pix Xymax_pix], [Yymin_pix Yymax_pix]);
        setColor(h,[0 0 0]);
        
        Xcenter_img=round(length(OutputIMG(1,:))/2);
        Ycenter_img=round(length(OutputIMG(:,1))/2);
        h=impoint(gca,[Xcenter_img Ycenter_img]);
        setColor(h,'red');
        h=imline(gca,[1 length(OutputIMG(1,:))], [Ycenter_img Ycenter_img]);
        setColor(h,'red');
        h=imline(gca,[Xcenter_img Xcenter_img], [1 length(OutputIMG(:,1))]);
        setColor(h,'red');
        text(length(OutputIMG(1,:))*0.75,40,'Eje fiduciales','Color','black','FontSize',10);
        text(length(OutputIMG(1,:))*0.75,125,'Eje centro imagen','Color','red','FontSize',10);
        myhandles4.text2.String={[num2str(2),'/',num2str(2)]};
        myhandles4.text3.String='Center shift con rotación';
        hold off
        zoom on
end    
catch
    uiwait(errordlg('Complete las tablas de datos de input'));
end
end