function CenterShift_Function
global myhandles4 ResultStruct R S T OutputIMG CenterShiftResult PlotNumber callindex2 Variables OrigenCoord

try
if callindex2==1 %Abre desde TablaResultados
    %Data1=Variables.Functions.CenterShift.CenterShiftResult.Data1;
    %Data2=Variables.Functions.CenterShift.CenterShiftResult.Data2;
    callindex2=0;
else
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    CenterShiftResult.Data1=Data1;
    CenterShiftResult.Data2=Data2;
end
catch
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    CenterShiftResult.Data1=Data1;
    CenterShiftResult.Data2=Data2;
end

CenterShiftResult.Xshift.Nombre='X shift s/R';
CenterShiftResult.Xshift.ValorObtenido=[];
CenterShiftResult.Yshift.Nombre='Y shift s/R';
CenterShiftResult.Yshift.ValorObtenido=[];
CenterShiftResult.R.Nombre='Angulo de rotacion (°)';
CenterShiftResult.R.ValorObtenido=[];
CenterShiftResult.S.Nombre='Factor Escala';
CenterShiftResult.S.ValorObtenido=[];
CenterShiftResult.Tx.Nombre='Traslación X';
CenterShiftResult.Tx.ValorObtenido=[];
CenterShiftResult.Ty.Nombre='Traslación Y';
CenterShiftResult.Ty.ValorObtenido=[];

if isfield(ResultStruct.info,'ImagerPixelSpacing')
    mm_pix=ResultStruct.info.ImagerPixelSpacing(1);
elseif isfield(ResultStruct.info,'ImagePlanePixelSpacing')
    mm_pix=ResultStruct.info.ImagePlanePixelSpacing(1);
end

Xcenter_img=round(length(OutputIMG(1,:))/2);
Ycenter_img=round(length(OutputIMG(:,1))/2);
OrigenCoord_img.posicion=[Xcenter_img Ycenter_img];

CenterShiftResult.Xshift.ValorObtenido=(OrigenCoord.posicion(1)-OrigenCoord_img.posicion(1))*S;
CenterShiftResult.Yshift.ValorObtenido=(OrigenCoord.posicion(2)-OrigenCoord_img.posicion(2))*S;
CenterShiftResult.R.ValorObtenido=(180*acos(R(1)))/pi;


PlotNumber=[1; 1; 1];
end