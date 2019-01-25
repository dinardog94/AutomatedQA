%Análisis StarShot
Dist_C=[0.3 0.8 0.7 0.2 0.7];
R= [0.8 0.4 1 5.4 0.6];
DOCmax=[0.3 0.9 0.8 0.8 0.8];
DOCmean=[0.275 0.55 0.48 0.37 0.425];
%SS= 1 2 3 4 5(0.5cm)

lastday=5;

figure
plot(DOCmax,'*')
xlim([0 lastday+1])
ylim([-4 4])
xlabel('# Star shot test')
ylabel('Distancia (mm)')
title('Máxima distancia recta - origen de coordenadas')
hold on
plot(xlim,[0 0],'--k');
plot(xlim,[2 2],'r');

figure
plot(DOCmean,'*')
xlim([0 lastday+1])
ylim([-4 4])
xlabel('Días')
xlabel('# Star shot test')
ylabel('Distancia (mm)')
title('Distancia media rectas - origen de coordenadas')
hold on
plot(xlim,[0 0],'--k');
plot(xlim,[2 2],'r');