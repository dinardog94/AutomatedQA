%Cuña orientada en el eje de la camilla, con el talon hacia el gantry
%cuña 45(6) out. Placas con el eje y paralelo a la camilla:  2 4 8 y 16 UM,
%Acrílico para eliminar contaminación electrónica(10mm), SSD placa=100, con 3cm de acrilico arriba (z=3) FS=15x15.
%Corresponderia a SSD=97 en acrilico. Colocar acrilico debajo por backscatter.

img1=double(dicomread('2UM.dcm'));
img2=double(dicomread('4UM.dcm'));
img3=double(dicomread('8UM.dcm'));
img4=double(dicomread('12UM.dcm'));

%Aplico correccion de ganancias obtener G2 primero desde
%CorreccionGanancia_DosimetroExt.m
img1=img1.*G2;
img2=img2.*G2;
img3=img3.*G2;
img4=img4.*G2;

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
curva_placa_4=mean(img4(:,Xi:Xf),2);
iteraciones=20;
for it=1:iteraciones
curva_placa_1=smooth(curva_placa_1);
curva_placa_2=smooth(curva_placa_2);
curva_placa_3=smooth(curva_placa_3);
curva_placa_4=smooth(curva_placa_4);
end
SSDz_placa=113.25;

%Perfil inplane de TPS 15x15, SSD100, cuña 45 out, profundidad 1,4cm.
%CENTRADO EN EL EJE CENTRAL DEL CAMPO
%fid = fopen('Perfil_45(6)z3cm_15x15_SSD110.txt');
fid = fopen('150x150_45_50_05-04-2016 MEDIDO.txt');
curva_TPS = textscan(fid,'%f');
curva_TPS=curva_TPS{1};
SSDz_TPS=105;

%Necesito factor escala pix/mm, pix_mm_TPS.
pix_mm_TPS=4;
puntos_TPSi=length(curva_TPS);
orig_X = linspace(1, puntos_TPSi, puntos_TPSi);
Scale=(pix_mm_placa/pix_mm_TPS)*(SSDz_placa/SSDz_TPS);
new_X = linspace(1, puntos_TPSi, puntos_TPSi*Scale);
curva_TPS_exp= interp1(orig_X, curva_TPS, new_X);
puntos_TPSf=length(curva_TPS_exp);
punto_central_TPS=round(puntos_TPSf/2);
curva_TPS_rel=curva_TPS_exp/curva_TPS_exp(punto_central_TPS);%relativo a la dosis central

%Esto es porque saco las penumbras que tienen mucha incerteza
curva_TPS_rel(1:300)=NaN;
curva_TPS_rel(900:end)=NaN;

%Alineación espacial de los perfiles. Hacer coincidir los centros
pix_central_placa=ceil(Ylength/2);
shift=pix_central_placa-punto_central_TPS;


if shift>0
%Si length(placa)< length(TPS)
curva_placa_1=curva_placa_1(shift:end);
curva_placa_2=curva_placa_2(shift:end);
curva_placa_3=curva_placa_3(shift:end);
curva_placa_4=curva_placa_4(shift:end);

curva_placa_1=curva_placa_1(1:puntos_TPSf);
curva_placa_2=curva_placa_2(1:puntos_TPSf);
curva_placa_3=curva_placa_3(1:puntos_TPSf);
curva_placa_4=curva_placa_4(1:puntos_TPSf);
else
%Si No
curva_TPS_rel=curva_TPS_rel(-shift:puntos_TPSf+shift-1);
end

%Ver alineacion

shift1=0;
shift2=10;
shift3=10;
shift4=60;
curva_placa_1=curva_placa_1(shift1+1:end);
curva_placa_2=curva_placa_2(shift2+1:end);
curva_placa_3=curva_placa_3(shift3+1:end);
curva_placa_4=curva_placa_4(shift4+1:end);

curva_placa_1(end:end+shift1)=zeros(shift1+1,1);
curva_placa_2(end:end+shift2)=zeros(shift2+1,1);
curva_placa_3(end:end+shift3)=zeros(shift3+1,1);
curva_placa_4(end:end+shift4)=zeros(shift4+1,1);

figure
plot(curva_TPS_rel)
hold on
plot(curva_placa_3/curva_placa_3(round(length(curva_placa_3)/2)))

%Esto es porque saco las penumbras que tienen mucha incerteza
curva_placa_1(1:350)=NaN;
curva_placa_1(1000:end)=NaN;
curva_placa_2(1:350)=NaN;
curva_placa_2(1000:end)=NaN;
curva_placa_3(1:350)=NaN;
curva_placa_3(1000:end)=NaN;
curva_placa_4(1:350)=NaN;
curva_placa_4(1000:end)=NaN;


%Dosis relativa a dosis en eje central, FS15x15, SSD110, z=3cm, cuña 45(6),
%2UM
dosis_relativa=[curva_TPS_rel curva_TPS_rel*2 curva_TPS_rel*4 curva_TPS_rel*6];%Esto podría variar según las UM con las que saqué las placas
intensidad_pixel=[curva_placa_1' curva_placa_2' curva_placa_3' curva_placa_4'];

plot(intensidad_pixel,dosis_relativa)

%Corrijo el solapamiento
[waste1 FirstValuePosition]=nanmin(curva_TPS_rel);
[topDval LastValuePosition]=nanmax(curva_TPS_rel*4);
overlapINI_value=curva_placa_4(FirstValuePosition);
overlapEND_value=curva_placa_3(LastValuePosition);


i=FirstValuePosition;
testTPScurv=curva_TPS_rel*6;
while (testTPScurv(i)<topDval) || isnan(curva_placa_4(i))
    i=i+1;
end
overlapEND_position=i;
curva_placa_4(1:overlapEND_position)=NaN;


dosis_relativa=[curva_TPS_rel curva_TPS_rel*2 curva_TPS_rel*4 curva_TPS_rel*6];%Esto podría variar según las UM con las que saqué las placas
intensidad_pixel=[curva_placa_1' curva_placa_2' curva_placa_3' curva_placa_4'];

%Quito los NAN que no me dejan interpolar
FKGnan=isnan(intensidad_pixel);
intensidad_pixel(FKGnan)=[];
dosis_relativa(FKGnan)=[];
FKGnan=isnan(dosis_relativa);
dosis_relativa(FKGnan)=[];
intensidad_pixel(FKGnan)=[];

%Hago la curva monotonica creciente para interpolar
intensidad_pixel=sort(intensidad_pixel);
dosis_relativa=sort(dosis_relativa);
[intensidad_pixel,ia,ic] = unique(intensidad_pixel);
dosis_relativa=dosis_relativa(ia);
vectorimg=G2.*img_UMCG(:,:,1);
vectorimg=vectorimg(:);
%Interpolacion
q1 = interp1(intensidad_pixel,dosis_relativa,vectorimg,'linear',max(dosis_relativa));
FinalIMG=vec2mat(q1,2140)';
IniIMG=G2.*img_UMCG(:,:,1);

figure
plot(intensidad_pixel,dosis_relativa)

figure
surf(IniIMG(100:2000,50:1700,1)), shading interp

figure
surf(FinalIMG(100:2000,50:1700)), shading interp

figure
imagesc(IniIMG(100:2000,50:1700,1))

figure
imagesc(FinalIMG(100:2000,50:1700))

