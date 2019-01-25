
%S10
[file, path] = uigetfile('*.dcm','Seleccione los dicom de calibracion','MultiSelect','on');
for i=1:length(file)
infodicom.(['img_',num2str(i)]) = dicominfo([path, file{i}]);
img_UM(:,:,i)=dicomread([path, file{i}]);
mean_I(i)=mean(mean(img_UM(:,:,i)));
end
x=[0 1 2 3 4 5 6];
plot(x,mean_I)
xlabel('UM')
ylabel('Intensidad media de píxel')
hold on


%S4
[file2, path2] = uigetfile('*.dcm','Seleccione los dicom de calibracion','MultiSelect','on');
mean_I2(1)=NaN;
for i=1:length(file2)
infodicom2.(['img_',num2str(i)]) = dicominfo([path2, file2{i}]);
img_UM2(:,:,i)=dicomread([path2, file2{i}]);
mean_I2(i+1)=mean(mean(img_UM2(:,:,i)));
end
x=[0 1 2 3 4 5 6 7 8 9 10];
plot(x,mean_I2)