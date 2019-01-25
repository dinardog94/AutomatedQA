%Análisis FieldSize

FX_Total=[200.6 200.4 200.8 200.6 201.8 201.6 201.9 201.1 201.4 201.4 199.5 199.2];
FY_Total=[197.3 196.9 197.5 198.7 197.7 197.5 197.9 197.4 199.6 199 198.1 198.7];
%dias=1 2 8 9 16 17 22 23 24 29 30 31.

lastday=12;

figure
plot(FX_Total/10,'*')
xlim([0 lastday+1])
ylim([16 24])
xlabel('Días')
ylabel('Tamaño de campo (cm)')
title('Análisis crossplane')
hold on
plot(xlim,[20 20],'--k');
plot(xlim,[18 18],'r');
plot(xlim,[22 22],'r');

figure
plot(FY_Total/10,'*')
xlim([0 lastday+1])
ylim([16 24])
xlabel('Días')
ylabel('Tamaño de campo (cm)')
title('Análisis inplane')
hold on
plot(xlim,[20 20],'--k');
plot(xlim,[18 18],'r');
plot(xlim,[22 22],'r');