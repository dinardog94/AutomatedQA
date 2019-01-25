function FieldSize_Function
global myhandles4 ResultStruct S OutputIMG FieldSizeResult PlotNumber callindex2 Variables OrigenCoord

try
if callindex2==1 %Abre desde TablaResultados
    Data1=Variables.Functions.FieldSize.FieldSizeResult.Data1;
    Data2=Variables.Functions.FieldSize.FieldSizeResult.Data2;
    callindex2=0;
else
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    FieldSizeResult.Data1=Data1;
    FieldSizeResult.Data2=Data2;
end
catch
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    FieldSizeResult.Data1=Data1;
    FieldSizeResult.Data2=Data2;
end

XPnum=0;
YPnum=0;
OPnum=0;
fn=fieldnames(ResultStruct.perfiles);
for i=1:length(Data2(:,1))
      for j=2:length(fn)
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{i,1})
             Perfiles_X(XPnum+1)=ResultStruct.perfiles.(char(fn(j))); 
             XPnum=XPnum+1;
          end
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{i,2})
             Perfiles_Y(YPnum+1)=ResultStruct.perfiles.(char(fn(j)));        
             YPnum=YPnum+1;
          end
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{i,3})
             Perfiles_O(OPnum+1)=ResultStruct.perfiles.(char(fn(j)));        
             OPnum=OPnum+1;
          end
      end
end


X_percentage=Data1{1,1}/100;
for i=1:XPnum
    Perfil_FieldSizeX_pix(1,:,i)=Perfiles_X(i).posicion(1,:);
    Perfil_FieldSizeX_pix(2,:,i)=Perfiles_X(i).posicion(2,:);
    pos=Perfil_FieldSizeX_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_FieldSizeX_datos(i).Nombre=Data2{i,1};
    Perfil_FieldSizeX_datos(i).datos=[];
    Perfil_FieldSizeX_datos(i).coordx=[];
    Perfil_FieldSizeX_datos(i).coordy=[];
    Perfil_FieldSizeX_datos(i).pos_central=[];
    Perfil_FieldSizeX_datos(i).pix_central=[];
    Perfil_FieldSizeX_datos(i).pos50_1=[];
    Perfil_FieldSizeX_datos(i).pos50_2=[];
    Perfil_FieldSizeX_datos(i).pix50_1=[];
    Perfil_FieldSizeX_datos(i).pix50_2=[];
    Perfil_FieldSizeX_datos(i).FieldSize_Izq_pix=[];
    Perfil_FieldSizeX_datos(i).FieldSize_Izq_mm=[];
    Perfil_FieldSizeX_datos(i).FieldSize_Der_pix=[];
    Perfil_FieldSizeX_datos(i).FieldSize_Der_mm=[];
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_FieldSizeX_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_FieldSizeX_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end
        iteraciones=10;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_FieldSizeX_datos(i).datos=perfil;
vx2=(Perfil_FieldSizeX_datos(i).coordx-OrigenCoord.posicion(1)).^2;
vy2=(Perfil_FieldSizeX_datos(i).coordy-OrigenCoord.posicion(2)).^2;
[valormin,pix_central]=min(vx2+vy2);
CentralAxisValue=perfil(pix_central);
pos_central=[Perfil_FieldSizeX_datos(i).coordx(pix_central) Perfil_FieldSizeX_datos(i).coordy(pix_central)];
Perfil_FieldSizeX_datos(i).pix_central=pix_central;
Perfil_FieldSizeX_datos(i).pos_central=pos_central;

[limite_50_1,pix_limite_50_1]=min(abs((perfil(1:floor(length(perfil)/2))-CentralAxisValue*X_percentage)));
pos_limite_50_1=[Perfil_FieldSizeX_datos(i).coordx(pix_limite_50_1) Perfil_FieldSizeX_datos(i).coordy(pix_limite_50_1)];
Perfil_FieldSizeX_datos(i).pos50_1=pos_limite_50_1;
Perfil_FieldSizeX_datos(i).pix50_1=pix_limite_50_1;

[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxisValue*X_percentage));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_2=[Perfil_FieldSizeX_datos(i).coordx(pix_limite_50_2) Perfil_FieldSizeX_datos(i).coordy(pix_limite_50_2)];
Perfil_FieldSizeX_datos(i).pos50_2=pos_limite_50_2;
Perfil_FieldSizeX_datos(i).pix50_2=pix_limite_50_2;


FieldSize_pix=sqrt((pos_limite_50_2(1)-pos_limite_50_1(1))^2+(pos_limite_50_2(2)-pos_limite_50_1(2))^2);
Perfil_FieldSizeX_datos(i).FieldSize_pix=FieldSize_pix;
FieldSize_mm=FieldSize_pix*S;
Perfil_FieldSizeX_datos(i).FieldSize_mm=FieldSize_mm;%Incerteza de +- 1 pixel

FieldSize_Izq_pix=sqrt((pos_central(1)-pos_limite_50_1(1))^2+(pos_central(2)-pos_limite_50_1(2))^2);
Perfil_FieldSizeX_datos(i).FieldSize_Izq_pix=FieldSize_Izq_pix;
FieldSize_Izq_mm=FieldSize_Izq_pix*S;
Perfil_FieldSizeX_datos(i).FieldSize_Izq_mm=FieldSize_Izq_mm;%Incerteza de +- 1 pixel

FieldSize_Der_pix=sqrt((pos_limite_50_2(1)-pos_central(1))^2+(pos_limite_50_2(2)-pos_central(2))^2);
Perfil_FieldSizeX_datos(i).FieldSize_Der_pix=FieldSize_Der_pix;
FieldSize_Der_mm=FieldSize_Der_pix*S;
Perfil_FieldSizeX_datos(i).FieldSize_Der_mm=FieldSize_Der_mm;%Incerteza de +- 1 pixel


end

if XPnum>0
FieldSizeResult.Perfil_FieldSizeX_datos=Perfil_FieldSizeX_datos;
end
if XPnum>1
FieldSize_X_mean.Nombre='X mean';
FieldSize_X_mean.ValorObtenido=mean([Perfil_FieldSizeX_datos(:).FieldSize_mm]);
FieldSizeResult.FieldSize_X_mean=FieldSize_X_mean;
end


Y_percentage=Data1{1,2}/100;
for i=1:YPnum
Perfil_FieldSizeY_pix(1,:,i)=Perfiles_Y(i).posicion(1,:);
Perfil_FieldSizeY_pix(2,:,i)=Perfiles_Y(i).posicion(2,:);
pos=Perfil_FieldSizeY_pix(:,:,i);
dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
dx=(pos(2,1)-pos(1,1));
dy=(pos(2,2)-pos(1,2));
u=[dx dy]/dist;
perfil=zeros(1,round(dist));
Perfil_FieldSizeY_datos(i).Nombre=Data2{i,2};
Perfil_FieldSizeY_datos(i).datos=[];
Perfil_FieldSizeY_datos(i).coordx=[];
Perfil_FieldSizeY_datos(i).coordy=[];
Perfil_FieldSizeY_datos(i).pos_central=[];
Perfil_FieldSizeY_datos(i).pix_central=[];
Perfil_FieldSizeY_datos(i).pos50_1=[];
Perfil_FieldSizeY_datos(i).pos50_2=[];
Perfil_FieldSizeY_datos(i).pix50_1=[];
Perfil_FieldSizeY_datos(i).pix50_2=[];
Perfil_FieldSizeY_datos(i).FieldSize_pix=[];
Perfil_FieldSizeY_datos(i).FieldSize_mm=[];
Perfil_FieldSizeY_datos(i).FieldSize_Izq_pix=[];
Perfil_FieldSizeY_datos(i).FieldSize_Izq_mm=[];
Perfil_FieldSizeY_datos(i).FieldSize_Der_pix=[];
Perfil_FieldSizeY_datos(i).FieldSize_Der_mm=[];

for dr=0:round(dist);
    coord=round(pos(1,:)+(u*dr));
    perfil(dr+1)=OutputIMG(coord(2),coord(1));
    Perfil_FieldSizeY_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
    Perfil_FieldSizeY_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
end

iteraciones=20;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_FieldSizeY_datos(i).datos=perfil;

vx2=(Perfil_FieldSizeY_datos(i).coordx-OrigenCoord.posicion(1)).^2;
vy2=(Perfil_FieldSizeY_datos(i).coordy-OrigenCoord.posicion(2)).^2;
[valormin,pix_central]=min(vx2+vy2);
CentralAxisValue=perfil(pix_central);
pos_central=[Perfil_FieldSizeY_datos(i).coordx(pix_central) Perfil_FieldSizeY_datos(i).coordy(pix_central)];
Perfil_FieldSizeY_datos(i).pos_central=pos_central;
Perfil_FieldSizeY_datos(i).pix_central=pix_central;

[limite_50_1,pix_limite_50_1]=min(abs((perfil(1:floor(length(perfil)/2))-CentralAxisValue*Y_percentage)));
pos_limite_50_1=[Perfil_FieldSizeY_datos(i).coordx(pix_limite_50_1) Perfil_FieldSizeY_datos(i).coordy(pix_limite_50_1)];
Perfil_FieldSizeY_datos(i).pos50_1=pos_limite_50_1;
Perfil_FieldSizeY_datos(i).pix50_1=pix_limite_50_1;

[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxisValue*Y_percentage));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_2=[Perfil_FieldSizeY_datos(i).coordx(pix_limite_50_2) Perfil_FieldSizeY_datos(i).coordy(pix_limite_50_2)];
Perfil_FieldSizeY_datos(i).pos50_2=pos_limite_50_2;
Perfil_FieldSizeY_datos(i).pix50_2=pix_limite_50_2;

FieldSize_pix=sqrt((pos_limite_50_2(1)-pos_limite_50_1(1))^2+(pos_limite_50_2(2)-pos_limite_50_1(2))^2);
Perfil_FieldSizeY_datos(i).FieldSize_pix=FieldSize_pix;
FieldSize_mm=FieldSize_pix*S;
Perfil_FieldSizeY_datos(i).FieldSize_mm=FieldSize_mm;%Incerteza de +- 1 pixel

FieldSize_Izq_pix=sqrt((pos_central(1)-pos_limite_50_1(1))^2+(pos_central(2)-pos_limite_50_1(2))^2);
Perfil_FieldSizeY_datos(i).FieldSize_Izq_pix=FieldSize_Izq_pix;
FieldSize_Izq_mm=FieldSize_Izq_pix*S;
Perfil_FieldSizeY_datos(i).FieldSize_Izq_mm=FieldSize_Izq_mm;%Incerteza de +- 1 pixel

FieldSize_Der_pix=sqrt((pos_limite_50_2(1)-pos_central(1))^2+(pos_limite_50_2(2)-pos_central(2))^2);
Perfil_FieldSizeY_datos(i).FieldSize_Der_pix=FieldSize_Der_pix;
FieldSize_Der_mm=FieldSize_Der_pix*S;
Perfil_FieldSizeY_datos(i).FieldSize_Der_mm=FieldSize_Der_mm;%Incerteza de +- 1 pixel
end

if YPnum>0
FieldSizeResult.Perfil_FieldSizeY_datos=Perfil_FieldSizeY_datos;
end
if YPnum>1
FieldSize_Y_mean.ValorObtenido=mean([Perfil_FieldSizeY_datos(:).FieldSize_mm]);
FieldSize_Y_mean.Nombre='Y mean';
FieldSizeResult.FieldSize_Y_mean=FieldSize_Y_mean;
end



O_percentage=Data1{1,3}/100;
for i=1:OPnum
    Perfil_FieldSizeO_pix(1,:,i)=Perfiles_O(i).posicion(1,:);
    Perfil_FieldSizeO_pix(2,:,i)=Perfiles_O(i).posicion(2,:);
    pos=Perfil_FieldSizeO_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_FieldSizeO_datos(i).Nombre=Data2{i,3};
    Perfil_FieldSizeO_datos(i).datos=[];
    Perfil_FieldSizeO_datos(i).coordx=[];
    Perfil_FieldSizeO_datos(i).coordy=[];
    Perfil_FieldSizeO_datos(i).pos_central=[];
    Perfil_FieldSizeO_datos(i).pix_central=[];
    Perfil_FieldSizeO_datos(i).pos50_1=[];
    Perfil_FieldSizeO_datos(i).pos50_2=[];
    Perfil_FieldSizeO_datos(i).pix50_1=[];
    Perfil_FieldSizeO_datos(i).pix50_2=[];
    Perfil_FieldSizeO_datos(i).FieldSize_pix=[];
    Perfil_FieldSizeO_datos(i).FieldSize_mm=[];
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_FieldSizeO_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_FieldSizeO_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end
        iteraciones=20;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_FieldSizeO_datos(i).datos=perfil;
vx2=(Perfil_FieldSizeO_datos(i).coordx-OrigenCoord.posicion(1)).^2;
vy2=(Perfil_FieldSizeO_datos(i).coordy-OrigenCoord.posicion(2)).^2;
[valormin,pix_central]=min(vx2+vy2);
CentralAxisValue=perfil(pix_central);
pos_central=[Perfil_FieldSizeO_datos(i).coordx(pix_central) Perfil_FieldSizeO_datos(i).coordy(pix_central)];
Perfil_FieldSizeO_datos(i).pos_central=pos_central;
Perfil_FieldSizeO_datos(i).pix_central=pix_central;

[limite_50_1,pix_limite_50_1]=min(abs((perfil(1:floor(length(perfil)/2))-CentralAxisValue*O_percentage)));
pos_limite_50_1=[Perfil_FieldSizeO_datos(i).coordx(pix_limite_50_1) Perfil_FieldSizeO_datos(i).coordy(pix_limite_50_1)];
Perfil_FieldSizeO_datos(i).pos50_1=pos_limite_50_1;
Perfil_FieldSizeO_datos(i).pix50_1=pix_limite_50_1;

[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxisValue*O_percentage));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_2=[Perfil_FieldSizeO_datos(i).coordx(pix_limite_50_2) Perfil_FieldSizeO_datos(i).coordy(pix_limite_50_2)];
Perfil_FieldSizeO_datos(i).pos50_2=pos_limite_50_2;
Perfil_FieldSizeO_datos(i).pix50_2=pix_limite_50_2;

FieldSize_pix=sqrt((pos_limite_50_2(1)-pos_limite_50_1(1))^2+(pos_limite_50_2(2)-pos_limite_50_1(2))^2);
Perfil_FieldSizeO_datos(i).FieldSize_pix=FieldSize_pix;
FieldSize_mm=FieldSize_pix*S;
Perfil_FieldSizeO_datos(i).FieldSize_mm=FieldSize_mm;%Incerteza de +- 1 pixel
end


if OPnum>0
FieldSizeResult.Perfil_FieldSizeO_datos=Perfil_FieldSizeO_datos;
end

PlotNumber=[1; XPnum; YPnum; OPnum];
end