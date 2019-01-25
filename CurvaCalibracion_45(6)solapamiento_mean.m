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
SSDz_placa=100;

%Perfil inplane de TPS 15x15, SSD100, cuña 45 out, profundidad 1,4cm.
%CENTRADO EN EL EJE CENTRAL DEL CAMPO
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



%Si length(placa)< length(TPS)
curva_placa_1=curva_placa_1(shift:end);
curva_placa_2=curva_placa_2(shift:end);
curva_placa_3=curva_placa_3(shift:end);
curva_placa_4=curva_placa_4(shift:end);

curva_placa_1=curva_placa_1(1:puntos_TPSf);
curva_placa_2=curva_placa_2(1:puntos_TPSf);
curva_placa_3=curva_placa_3(1:puntos_TPSf);
curva_placa_4=curva_placa_4(1:puntos_TPSf);

%Si No
%curva_TPS_rel=curva_TPS_rel(-shift:puntos_TPSf+shift);

%Esto es porque saco las penumbras que tienen mucha incerteza
curva_placa_1(1:100)=NaN;
curva_placa_1(1100:end)=NaN;
curva_placa_2(1:100)=NaN;
curva_placa_2(1100:end)=NaN;
curva_placa_3(1:100)=NaN;
curva_placa_3(1100:end)=NaN;
curva_placa_4(1:100)=NaN;
curva_placa_4(1100:end)=NaN;


%Dosis relativa a dosis en eje central, FS15x15, SSD110, z=3cm, cuña 45(6),
%2UM
dosis_relativa=[curva_TPS_rel curva_TPS_rel*2 curva_TPS_rel*4 curva_TPS_rel*6];%Esto podría variar según las UM con las que saqué las placas
intensidad_pixel=[curva_placa_1' curva_placa_2' curva_placa_3' curva_placa_4'];

plot(intensidad_pixel,dosis_relativa)

%Hago mean en el solapamiento
[waste1 FirstValuePosition]=nanmin(curva_TPS_rel);
[waste2 LastValuePosition]=nanmax(curva_TPS_rel);
overlapINI_value=curva_placa_4(FirstValuePosition);
overlapEND_value=curva_placa_3(LastValuePosition);
[waste3 overlapINI_position]=nanmin(abs(curva_placa_3-overlapINI_value));
[waste4 overlapEND_position]=nanmin(abs(curva_placa_4-overlapEND_value));
L1=length(curva_placa_3(overlapINI_position:LastValuePosition));
L2=length(curva_placa_4(FirstValuePosition:overlapEND_position));

% if L1>L2
%     overlapPOINTS=L1;
%     orig_X2 = linspace(1, L2, L2);
%     new_X2 = linspace(1, L2, overlapPOINTS);
%     curva_placa_4_exp= interp1(orig_X2, curva_placa_4(FirstValuePosition:overlapEND_position), new_X2);
%     curva_placa_4_exp=curva_placa_4_exp';
%     curva_placa_3_exp= curva_placa_3(overlapINI_position:LastValuePosition);
%     
%     curva_TPS_rel_exp4=curva_TPS_rel(FirstValuePosition:overlapEND_position)*6;
%     orig_X22 = linspace(1, length(curva_TPS_rel(FirstValuePosition:overlapEND_position)), length(curva_TPS_rel(FirstValuePosition:overlapEND_position)));
%     new_X22 = linspace(1, length(curva_TPS_rel(FirstValuePosition:overlapEND_position)), overlapPOINTS);
%     curva_TPS_rel_exp4= interp1(orig_X22, curva_TPS_rel_exp4, new_X22);
%     
%     curva_TPS_rel_exp3= curva_TPS_rel(overlapINI_position:LastValuePosition)*4;
% 
% else
%     overlapPOINTS=L2;
%     orig_X1 = linspace(1, L1, L1);
%     new_X1 = linspace(1, L1, overlapPOINTS);
%     curva_placa_3_exp= interp1(orig_X1, curva_placa_3(overlapINI_position:LastValuePosition), new_X1);
%     curva_placa_3_exp=curva_placa_3_exp';
%     curva_placa_4_exp= curva_placa_4(FirstValuePosition:overlapEND_position);
%     
%     curva_TPS_rel_exp3= curva_TPS_rel(overlapINI_position:LastValuePosition)*4;
%     orig_X12 = linspace(1, length(curva_TPS_rel(overlapINI_position:LastValuePosition)), length(curva_TPS_rel(overlapINI_position:LastValuePosition)));
%     new_X12 = linspace(1, length(curva_TPS_rel(overlapINI_position:LastValuePosition)), overlapPOINTS);
%     curva_TPS_rel_exp3= interp1(orig_X12, curva_TPS_rel_exp3, new_X12);
%     
%     curva_TPS_rel_exp4= curva_TPS_rel(FirstValuePosition:overlapEND_position)*6;
% end
% 
% curva_TPS_rel_3_4=mean([curva_TPS_rel_exp3; curva_TPS_rel_exp4],1);
% 
% curva_placas_3_4=mean([curva_placa_3_exp curva_placa_4_exp],2);
% 
% 
% dosis_relativa=[curva_TPS_rel curva_TPS_rel*2 curva_TPS_rel(1:overlapINI_position)*4 curva_TPS_rel_3_4 curva_TPS_rel(overlapEND_position:end)*6];%Esto podría variar según las UM con las que saqué las placas
% intensidad_pixel=[curva_placa_1' curva_placa_2' curva_placa_3(1:overlapINI_position)' curva_placas_3_4' curva_placa_4(overlapEND_position:end)'];

FKGnan=isnan(intensidad_pixel);
intensidad_pixel(FKGnan)=[];
dosis_relativa(FKGnan)=[];
FKGnan=isnan(dosis_relativa);
dosis_relativa(FKGnan)=[];
intensidad_pixel(FKGnan)=[];

figure(3)
plot(intensidad_pixel,dosis_relativa)




