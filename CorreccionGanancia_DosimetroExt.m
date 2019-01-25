function Ganancia=CorreccionGanancia_DosimetroExt
try
[filename, pathname] = uigetfile('*.txt','Seleccione el mapa de referencia, que sólo contenga numeros separados por coma');%Que solo contenga numeros separados x coma, 'Plano40x40SSD110z3.8_400UM.txt'
fid = fopen([pathname, filename]);
mapaTPS = textscan(fid,'%f','Delimiter',',');
%necesito el numero de columnas de la matriz, numcol

prompt = {'Ingrese el número de columnas del mapa:'};
dlg_title = 'Número de columnas';
num_lines = 1;
def = {'401'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if ~isempty(answer)
    numcol=str2double(answer{1});
end
MapaTPS=vec2mat(mapaTPS{1},numcol);
%mapa2D del mayor campo posible, a profundidad 14mm.

%Placa con el eje y paralelo a la camilla, 3cm acrílico para eliminar contaminación electrónica y alto gradiente (3 U),SSD acrilico sperior 110, SSD placa: 112, campo de
%40x40. Corresponderia a SSD113, z=4 por el 1mm de plomo de la
%placa?.Colocar acrilico debajo por backscatter.
[file, path] = uigetfile('*.dcm','Seleccione las imagenes de corrección de ganancias','MultiSelect','on');

prompt = {'Valor pix/mm del mapa de referencia:','Valor pix/mm de las imágenes:','Valor SSD + Z del mapa de referencia:','Valor SSD + Z de las imágenes:'};
dlg_title = 'Factores de escala';
num_lines = 1;
def = {'1','5','113.8','113.25'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if ~isempty(answer)
    pix_mm_TPS=str2double(answer{1});
    pix_mm_placa=str2double(answer{2});
    SSDz_TPS=str2double(answer{3});
    SSDz_placa=str2double(answer{4});    
end

info.numcol=numcol;
info.pix_mm_TPS=pix_mm_TPS;
info.pix_mm_placa=pix_mm_placa;
info.SSDz_TPS=SSDz_TPS;
info.SSDz_placa=SSDz_placa;

for i=1:length(file)
infodicom.(['img_CG',num2str(i)]) = dicominfo([path, file{i}]);
img_UMCG(:,:,i)=double(dicomread([path, file{i}]));

if isfield(infodicom.(['img_CG',num2str(i)]),'RescaleSlope')
    img_UMCG(:,:,i)=img_UMCG(:,:,i).*infodicom.(['img_CG',num2str(i)]).RescaleSlope+infodicom.(['img_CG',num2str(i)]).RescaleIntercept;   
end

MapaPlaca=img_UMCG(:,:,i);
%Necesito factor escala pix/mm, pix_mm_placa.

Ylength=length(MapaPlaca(:,1));
Xlength=length(MapaPlaca(1,:));

%Necesito factor escala pix/mm, pix_mm_TPS.

puntos_TPSi_X=length(MapaTPS(1,:));
puntos_TPSi_Y=length(MapaTPS(:,1));


Scale=(pix_mm_placa/pix_mm_TPS)*(SSDz_placa/SSDz_TPS);
MapaTPS_exp=imresize(MapaTPS,[puntos_TPSi_Y*Scale puntos_TPSi_X*Scale]);
puntos_TPSf_X=length(MapaTPS_exp(1,:));
puntos_TPSf_Y=length(MapaTPS_exp(:,1));
punto_central_TPS=[round(puntos_TPSf_Y/2) round(puntos_TPSf_X/2)];
MapaTPS_rel=MapaTPS_exp/MapaTPS_exp(punto_central_TPS(1),punto_central_TPS(2));%relativo a la dosis central


%Alineación espacial de los perfiles. Hacer coincidir los centros
pix_central_placa=[round(Ylength/2) round(Xlength/2)];
MapaPlaca_rel=MapaPlaca/MapaPlaca(pix_central_placa(1),pix_central_placa(2));%relativo a la dosis central
shift_X=pix_central_placa(2)-punto_central_TPS(2);
shift_Y=pix_central_placa(1)-punto_central_TPS(1);
Mapa_Drel=zeros(Ylength,Xlength);

if length(MapaTPS_rel(:,1))<length(Mapa_Drel(:,1))
    if length(MapaTPS_rel(1,:))<length(Mapa_Drel(1,:))
Mapa_Drel(shift_Y:(shift_Y+puntos_TPSf_Y-1),shift_X:(shift_X+puntos_TPSf_X-1))=MapaTPS_rel;%Ver si -1 al final o +1 al ppio
    else 
Mapa_Drel(shift_Y:(shift_Y+puntos_TPSf_Y-1),:)=MapaTPS_rel(:,-shift_X:(shift_X+puntos_TPSf_X));
    end
else
        if length(MapaTPS_rel(1,:))<length(Mapa_Drel(1,:))
Mapa_Drel(-shift_Y:(shift_Y+puntos_TPSf_Y-1),shift_X:(shift_X+puntos_TPSf_X-1))=MapaTPS_rel;%Ver si -1 al final o +1 al ppio
    else
Mapa_Drel(-shift_Y:(shift_Y+puntos_TPSf_Y-1),:)=MapaTPS_rel(:,-shift_X:(shift_X+puntos_TPSf_X-1));
        end
end

Gi(:,:,i)=Mapa_Drel./MapaPlaca_rel;


end

G=mean(Gi,3);
G(G<0.8)=1;
G(G>1.2)=1;

%figure
%surf(G), shading interp

%for i=1:length(file)
 %figure
%surf(G.*img_UMCG(:,:,i)), shading interp
 %figure
%surf(G.*img_UMCG(:,:,i)), shading interp
 %figure
%surf(img_UMCG(:,:,i)), shading interp
%end


Ganancia.G=G;
Ganancia.img=img_UMCG;
Ganancia.info=info;

f1=figure;
surf(G), shading interp
title('Matriz de corrección de ganacias obtenida')
answer = questdlg('Desea guardar la matriz de corrección de ganancias?','','Sí','No','Sí');

switch answer
    case 'Sí'
close(f1)
    case 'No'
Ganancia=[];
close(f1)
end



catch
    Ganancia=[];
end
