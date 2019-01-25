%Cuña orientada en el eje de la camilla, con el talon hacia el gantry
%cuña 45(6) out. Placas con el eje y paralelo a la camilla:  2 4 8 y 16 UM,
%Acrílico para eliminar contaminación electrónica(10mm), SSD placa=100, con 3cm de acrilico arriba (z=3) FS=15x15.
%Corresponderia a SSD=97 en acrilico. Colocar acrilico debajo por backscatter.

img1=double(dicomread('2UM.dcm'));
img2=double(dicomread('4UM.dcm'));
img3=double(dicomread('8UM.dcm'));

%Aplico correccion de ganancias obtener G2 primero desde
%CorreccionGanancia_DosimetroExt.m
%img1=img1.*G2;
%img2=img2.*G2;
%img3=img3.*G2;



%Región central para tomar perfiles de cuña, elijo los 100 mm centrales. Variable zona central ZC 
ZC=100;

%Necesito factor escala pix/mm, pix_mm_placa.
pix_mm_placa=5;
Ylength=length(img2(:,1));
Xlength=length(img2(1,:));
Xi=round(Xlength/2)-ZC*pix_mm_placa;
Xf=round(Xlength/2)+ZC*pix_mm_placa;
curva_placa_1=mean(img1(:,Xi:Xf),2);
curva_placa_2=mean(img2(:,Xi:Xf),2);
curva_placa_3=mean(img3(:,Xi:Xf),2);
SSDz_placa=112;

%Perfil inplane de TPS 15x15, SSD100, cuña 45 out, profundidad 1,4cm.
%CENTRADO EN EL EJE CENTRAL DEL CAMPO
fid = fopen('PerfilCuna45(6)z_1cm.txt');
curva_TPS = textscan(fid,'%f');
curva_TPS=curva_TPS{1};
SSDz_TPS=110;

%Necesito factor escala pix/mm, pix_mm_TPS.
pix_mm_TPS=1;
puntos_TPSi=length(curva_TPS);
orig_X = linspace(1, puntos_TPSi, puntos_TPSi);
Scale=(pix_mm_placa/pix_mm_TPS)*(SSDz_placa/SSDz_TPS);
new_X = linspace(1, puntos_TPSi, puntos_TPSi*Scale);
curva_TPS_exp= interp1(orig_X, curva_TPS, new_X);
puntos_TPSf=length(curva_TPS_exp);
punto_central_TPS=round(puntos_TPSf/2);
curva_TPS_rel=curva_TPS_exp/curva_TPS_exp(1,punto_central_TPS);%relativo a la dosis central

%Esto va porque estos puntos no los medi en la placa (puse campo grande)
curva_TPS_rel(1:700)=NaN;
curva_TPS_rel(1300:2078)=NaN;

%Alineación espacial de los perfiles. Hacer coincidir los centros
pix_central_placa=ceil(Ylength/2);
shift=pix_central_placa-punto_central_TPS;



%Si length(placa)< length(TPS)
curva_placa_1=curva_placa_1(shift:end);
curva_placa_2=curva_placa_2(shift:end);
curva_placa_3=curva_placa_3(shift:end);

curva_placa_1=curva_placa_1(1:puntos_TPSf);
curva_placa_2=curva_placa_2(1:puntos_TPSf);
curva_placa_3=curva_placa_3(1:puntos_TPSf);

%Si No
%curva_TPS_rel=curva_TPS_rel(-shift:puntos_TPSf+shift);

%Esto es porque saco las penumbras que tienen mucha incerteza
curva_placa_1(1:700)=NaN;
curva_placa_1(1300:2078)=NaN;
curva_placa_2(1:700)=NaN;
curva_placa_2(1300:2078)=NaN;
curva_placa_3(1:700)=NaN;
curva_placa_3(1300:2078)=NaN;

%Dosis relativa a dosis en eje central, FS15x15, SSD110, z=1cm, cuña 45(6),
%2UM
dosis_relativa=[curva_TPS_rel curva_TPS_rel*2 curva_TPS_rel*4];%Esto podría variar según las UM con las que saqué las placas
intensidad_pixel=[curva_placa_1' curva_placa_2' curva_placa_3'];

plot(dosis_relativa,intensidad_pixel,'*')
hold on

