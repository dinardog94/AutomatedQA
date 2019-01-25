%Análisis CenterShift

%Cada grupo= 1 fila de 3 imágenes (1 x columna)
SX=[1.1 0.8 1.1; 0 0 0; 0.4 0.4 0.4; 0.6 0.6 0.6; 0.8 0.8 0.8];
SY=[-1.9 -1.9 -1.9; -0.8 -0.8 -0.8; -1.5 -1.5 -1.5; -1 -1 -1; -0.8 -0.8 -0.8];
R=[0.6 0.6 0.7; 0.6 0.6 0.6; 0.3 0.3 0.3; 0.5 0.5 0.5; 0.1 0.1 0.2];
SXmean=mean(SX,2);
SYmean=mean(SY,2);
Rmean=mean(R,2);

%#Días 7-11 11-10 1-10 15-11 21-11
lastday=5;

figure
plot(SX(1,:),'*')
xlim([0 3+1])
ylim([-2 2])
xlabel('# Imagen')
ylabel('Shift X (mm)')
title('Resultados de grupo 1')
hold on
plot(xlim,[mean(SX(1,:))-2*std(SX(1,:)) mean(SX(1,:))-2*std(SX(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(SX(1,:))+2*std(SX(1,:)) mean(SX(1,:))+2*std(SX(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(SX(1,:)) mean(SX(1,:))],'--k','HandleVisibility','off');

hold off
figure
plot(SY(1,:),'*')
xlim([0 3+1])
ylim([-3 0])
xlabel('# Imagen')
ylabel('Shift Y (mm)')
title('Resultados de grupo 1')
hold on
plot(xlim,[mean(SY(1,:))-2*std(SY(1,:)) mean(SY(1,:))-2*std(SY(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(SY(1,:))+2*std(SY(1,:)) mean(SY(1,:))+2*std(SY(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(SY(1,:)) mean(SY(1,:))],'--k','HandleVisibility','off');

hold off
figure
plot(R(1,:),'*')
xlim([0 3+1])
ylim([-2 2])
xlabel('# Imagen')
ylabel('Ándulo de rotación (rad)')
title('Resultados de grupo 1')
hold on
plot(xlim,[mean(R(1,:))-2*std(R(1,:)) mean(R(1,:))-2*std(R(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(R(1,:))+2*std(R(1,:)) mean(R(1,:))+2*std(R(1,:))],'r','HandleVisibility','off');
plot(xlim,[mean(R(1,:)) mean(R(1,:))],'--k','HandleVisibility','off');





hold off
figure
plot(SXmean,'*')
xlim([0 lastday+1])
ylim([-2 2])
xlabel('# Grupo')
ylabel('Shift X (mm)')
title('Resultados de todos los grupos')
hold on
plot(xlim,[mean(SXmean)-2*std(SXmean) mean(SXmean)-2*std(SXmean)],'r','HandleVisibility','off');
plot(xlim,[mean(SXmean)+2*std(SXmean) mean(SXmean)+2*std(SXmean)],'r','HandleVisibility','off');
plot(xlim,[mean(SXmean) mean(SXmean)],'--k','HandleVisibility','off');

hold off
figure
plot(SYmean,'*')
xlim([0 lastday+1])
ylim([-3 0])
xlabel('# Grupo')
ylabel('Shift Y (mm)')
title('Resultados de todos los grupos')
hold on
plot(xlim,[mean(SYmean)-2*std(SYmean) mean(SYmean)-2*std(SYmean)],'r','HandleVisibility','off');
plot(xlim,[mean(SYmean)+2*std(SYmean) mean(SYmean)+2*std(SYmean)],'r','HandleVisibility','off');
plot(xlim,[mean(SYmean) mean(SYmean)],'--k','HandleVisibility','off');

hold off
figure
plot(Rmean,'*')
xlim([0 lastday+1])
ylim([-2 2])
xlabel('# Grupo')
ylabel('Ándulo de rotación (rad)')
title('Resultados de todos los grupos')
hold on
plot(xlim,[mean(Rmean)-2*std(Rmean) mean(Rmean)-2*std(Rmean)],'r','HandleVisibility','off');
plot(xlim,[mean(Rmean)+2*std(Rmean) mean(Rmean)+2*std(Rmean)],'r','HandleVisibility','off');
plot(xlim,[mean(Rmean) mean(Rmean)],'--k','HandleVisibility','off');


for i=1:length(SX(:,1))
    sSX(i)=std(SX(i,:));
    fprintf('SD X # %f = %f\n',[i sSX(i)])
    sSY(i)=std(SY(i,:));
    fprintf('SD Y # %f = %f\n',[i sSY(i)])
    sR(i)=std(R(i,:));
    fprintf('SD R # %f = %f\n',[i sR(i)])
end

sSXintra=mean(sSX);
fprintf('SD X intra mean = %f\n',sSXintra)
sSYintra=mean(sSY);
fprintf('SD Y intra mean = %f\n',sSYintra)
sRintra=mean(sR);
fprintf('SD R intra mean = %f\n',sRintra)
sSXm=std(SXmean);
fprintf('SD X inter mean = %f\n',sSXm)
sSYm=std(SYmean);
fprintf('SD Y inter mean = %f\n',sSYm)
sRm=std(Rmean);
fprintf('SD R inter mean = %f\n',sRm)
