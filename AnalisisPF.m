%Análisis PicketFence
Wmax=[3.3 3 3 3.3 3];
Wmean=[2.5 2.6 2.5 2.7 2.5];
Wmin=[1.9 1.9 1.9 1.9 1.9];
Wmeme=mean(Wmean);
%#Días 7-11 11-10 12-11 15-11 21-11

lastday=5;

figure
plot(Wmax,'*')
xlim([0 lastday+1])
ylim([0 5])
xlabel('# Picket Fence test')
ylabel('Ancho de pico (mm)')
title('Resultados de Picket Fence')
hold on
plot(Wmean,'*')
plot(Wmin,'*')
legend({'Ancho máximo', 'Ancho medio', 'Ancho mínimo'})
plot(xlim,[Wmeme Wmeme],'--k','HandleVisibility','off');
plot(xlim,[Wmeme-1 Wmeme-1],'r','HandleVisibility','off');
plot(xlim,[Wmeme+1 Wmeme+1],'r','HandleVisibility','off');