[file, path] = uigetfile('*.dcm','Seleccione los DICOM','MultiSelect','on');
for i=1:length(file)
FS.(['img_',num2str(i)]).infodicom = dicominfo([path, file{i}]);
FS.(['img_',num2str(i)]).imageraw = double(dicomread([path, file{i}]));
end

NumFiles=length(file);
FieldSizes=ones(NumFiles,1);
CentralValue=ones(NumFiles,1);
for i=1:NumFiles
FieldSizes(i,1)=FS.(['img_',num2str(i)]).infodicom.ExposureSequence.Item_1.BeamLimitingDeviceSequence.Item_1.LeafJawPositions(2);
FS.(['img_',num2str(i)]).image = (FS.(['img_',num2str(i)]).imageraw)*(FS.(['img_',num2str(i)]).infodicom.RescaleSlope) + FS.(['img_',num2str(i)]).infodicom.RescaleIntercept;
img=FS.(['img_',num2str(i)]).image;
Xm=length(img(1,:))/2;
Ym=length(img(:,1))/2;
CentralValue(i,1)=mean(mean(img((Ym-10):(Ym+10),(Xm-10):(Xm+10))));
end

