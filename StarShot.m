%global OrigenCoord S OutputIMG

S=0.2;
%OutputIMG=double(dicomread('C:\Users\glo_d\Documents\Tesina\Tesina\Placas\Placas calibracion anual\1.2.392.200036.9125.2.23617721569243120.64884412906.444456\1.2.392.200036.9125.3.23617721569243120.64884412906.444458\1.2.392.200036.9125.9.0.1058738786.50901484.1171749107.dcm'));
OutputIMG=double(dicomread('C:\Users\glo_d\Documents\Tesina\Tesina\Placas\Placas calibracion anual\1.2.392.200036.9125.2.23617721569243120.64884413614.444472\1.2.392.200036.9125.3.23617721569243120.64884413614.444474\1.2.392.200036.9125.9.0.1058790244.67678700.1171749107.dcm'));
imagesc(OutputIMG)%ubicar el OrigenCoord aprox
impixelinfo
OrigenCoord.posicion=[866 1046];%VER ESTO PUEDE Q ESTE INVERTIDO, es [X Y]=[col fil]
Radio_mm=50;%5mm
Radio=Radio_mm/S;
teta=linspace(0,2*pi,800);
for i=1:length(teta)
    x(i)=round(Radio*cos(teta(i)));
    y(i)=round(Radio*sin(teta(i)));
end
X=x+OrigenCoord.posicion(1);
Y=OrigenCoord.posicion(2)-y;
perfil=zeros(length(X),1);
for i=1:length(X)
perfil(i)=OutputIMG(Y(i),X(i));
end
%figure
%plot(perfil)
iteraciones=6;
for i=1:iteraciones
    perfil=smooth(perfil);
end   
[pks,locs,w,p] = findpeaks(perfil,'MinPeakWidth',3/S,'WidthReference','halfprom');
locs=sort(locs);
distancia=length(locs)/2;
for i=1:distancia
ParesAO(:,i)=[locs(i) locs(i+distancia)];
end




for k = 1:length(ParesAO(1,:))
xy = [X(ParesAO(1,k)) Y(ParesAO(1,k)); X(ParesAO(2,k)) Y(ParesAO(2,k))];
hold on
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
lines(k).xy=xy;
if X(ParesAO(2,k))>X(ParesAO(1,k))
lines(k).m=(Y(ParesAO(2,k))-Y(ParesAO(1,k)))/(X(ParesAO(2,k))-X(ParesAO(1,k)));
lines(k).n=Y(ParesAO(2,k))-X(ParesAO(2,k))*lines(k).m;
else
lines(k).m=(Y(ParesAO(1,k))-Y(ParesAO(2,k)))/(X(ParesAO(1,k))-X(ParesAO(2,k)));
lines(k).n=Y(ParesAO(1,k))-X(ParesAO(1,k))*lines(k).m;
end
end

a=1;%combinacion de rectas
for i = 1:length(lines)-2
for j=(i+1):length(lines)-1
for k=(j+1):length(lines)
xy_intA(a,1)=(lines(i).n-lines(j).n)/(lines(j).m-lines(i).m);
xy_intA(a,2)=lines(i).m*((lines(i).n-lines(j).n)/(lines(j).m-lines(i).m))+lines(i).n;
xy_intB(a,1)=(lines(i).n-lines(k).n)/(lines(k).m-lines(i).m);
xy_intB(a,2)=lines(i).m*((lines(i).n-lines(k).n)/(lines(k).m-lines(i).m))+lines(i).n;
xy_intC(a,1)=(lines(j).n-lines(k).n)/(lines(k).m-lines(j).m);
xy_intC(a,2)=lines(j).m*((lines(j).n-lines(k).n)/(lines(k).m-lines(j).m))+lines(j).n;
AB(a)=sqrt((xy_intA(a,1)-xy_intB(a,1))^2+(xy_intA(a,2)-xy_intB(a,2))^2);
BC(a)=sqrt((xy_intB(a,1)-xy_intC(a,1))^2+(xy_intB(a,2)-xy_intC(a,2))^2);
CA(a)=sqrt((xy_intC(a,1)-xy_intA(a,1))^2+(xy_intC(a,2)-xy_intA(a,2))^2);
r_xy(a,1)=(AB(a)*xy_intC(a,1)+BC(a)*xy_intA(a,1)+CA(a)*xy_intB(a,1))/(AB(a)+BC(a)+CA(a));
r_xy(a,2)=(AB(a)*xy_intC(a,2)+BC(a)*xy_intA(a,2)+CA(a)*xy_intB(a,2))/(AB(a)+BC(a)+CA(a));
sp=(AB(a)+BC(a)+CA(a))/2;
r_value(a)=sqrt(((sp-AB(a))*(sp-BC(a))*(sp-CA(a)))/sp);
a=a+1;
end
end
end
for i=1:(a-1)
h=imellipse(gca,[(r_xy(i,1)-r_value(i)) (r_xy(i,2)-r_value(i)) 2*r_value(i) 2*r_value(i)]);
end
[trash idx_r]=max(r_value);
h=imellipse(gca,[(r_xy(idx_r,1)-r_value(idx_r)) (r_xy(idx_r,2)-r_value(idx_r)) 2*r_value(idx_r) 2*r_value(idx_r)]);
setColor(h,'red');

%Distancias rectas a OrigenCoord
for i=1:distancia
lines(i).dist2org=abs(lines(i).m*OrigenCoord.posicion(1)-OrigenCoord.posicion(2)+lines(i).n)/sqrt(1+(lines(i).m)^2);
end




        