[file, path] = uigetfile('*.dcm','Seleccione los dicom de background','MultiSelect','on');

for i=1:length(file)
BG(i).infodicom = dicominfo([path, file{i}]);
Chasis{i}=BG(i).infodicom.DetectorID;
BG(i).img=dicomread([path, file{i}]);
end
%figure(1)
%surf(img1), shading interp
if isequal(Chasis{1:end})

z = cat(3,BG.img);
M = mean(z,3);
CV = (std(z,[],3))./M; %Coeficiente de Variación

UMBRAL=0.2;%Qué crierio uso...?Experimental?

Fondo_Sist=CV<UMBRAL;
M(~Fondo_Sist)=0;

Background.M=M;
Background.CV=CV;
Background.info=BG;

f1=figure(1);
surf(M), shading interp
answer = questdlg('Desea guardar el background?','','Sí','No','Sí');

switch answer
    case 'Sí'
prompt = {'Nombre del Background:'};
title = 'Ingrese nombre del background';
answer = inputdlg(prompt,title);
file=answer{1};
path=strcat(pwd,'\','Background','\');
a=[path,file];
save (a, 'Background');
close(f1)
    case 'No'
        close(f1)
end
else
   uiwait(errordlg('Los fondos corresponden a diferentes chasis.')); 
end



