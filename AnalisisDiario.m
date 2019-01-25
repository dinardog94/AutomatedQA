%Comparaciopn diario

%Soft
FXC=[0.83 0.73 1.39 0.72 0.68 0.74 0.97 0.98 1.99 0.98];
FYC=[1.38 1.02 1.33 0.98 0.93 1.04 1.09 1.9 1.23 1.25];
SXC=[-0.02 -0.12 -0.4 -0.04 0.01 -0.1 -0.19 -0.14 -0.86 -0.17];
SYC=[0.58 0.06 -0.1 0.24 0.27 0.3 0.07 -0.55 0.6 0.23];
EC=[653 643 638 646 654 657 644 637 660 649];
%Tracker
FXT=[0.3 0.35 0.7 0.2 0.1 0.23 0.28 0.28 0.36 0.28];
FYT=[0.2 0.25 0.15 0.28 0.23 0.23 0.23 0.23 0.23 0.38];
SXT=[0.4 0.3 0.2 0.1 0.2 0.3 0.25 0.5 0.71 0.36];
SYT=[0.1 0.2 0.1 0.15 0.1 0.3 0.15 0.2 0 0.35];
ET=[99.06 99.04 99.14 99.27 99.37 99.16 99.07 98.63 98.29 99.09];
%dias= 2 8 9 16 17 22 23 24 29 30.

lastday=10;

figure
plot(FXC,'*')
xlim([0 lastday+1])
ylim([-5 5])
xlabel('Días')
title('Planicidad X')
hold on
plot(FXT,'*')
plot(xlim,[0 0],'--k');
plot(xlim,[3 3],'r');

figure
plot(FYC,'*')
xlim([0 lastday+1])
ylim([-5 5])
xlabel('Días')
title('Planicidad Y')
hold on
plot(FYT,'*')
plot(xlim,[0 0],'--k');
plot(xlim,[3 3],'r');

figure
plot(SXC,'*')
xlim([0 lastday+1])
ylim([-5 5])
xlabel('Días')
title('Simetría X')
hold on
plot(SXT,'*')
plot(xlim,[0 0],'--k');
plot(xlim,[3 3],'r');
plot(xlim,[-3 -3],'r');

figure
plot(SYC,'*')
xlim([0 lastday+1])
ylim([-5 5])
xlabel('Días')
title('Simetría Y')
hold on
plot(SYT,'*')
plot(xlim,[0 0],'--k');
plot(xlim,[3 3],'r');
plot(xlim,[-3 -3],'r');


figure
plot(EC/EC(1),'*')
xlim([0 lastday+1])
ylim([0.9 1.1])
xlabel('Días')
title('Estabilidad')
hold on
plot(ET/ET(1),'*')
plot(xlim,[1 1],'--k');
plot(xlim,[0.97 0.97],'r');
plot(xlim,[1.03 1.03],'r');