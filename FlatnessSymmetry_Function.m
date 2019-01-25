function FlatnessSymmetry_Function
global myhandles4 ResultStruct  OutputIMG FlatnessSymmetryResult PlotNumber callindex2 Variables OrigenCoord

try
if callindex2==1 %Abre desde TablaResultados
    Data1=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.Data1;
    Data2=Variables.Functions.FlatnessSymmetry.FlatnessSymmetryResult.Data2;
    
    callindex2=0;
else %Abre desde ProgramaQA2
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    FlatnessSymmetryResult.Data1=Data1;
    FlatnessSymmetryResult.Data2=Data2;
end
catch %Abre desde ProgramaQA2
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    FlatnessSymmetryResult.Data1=Data1;
    FlatnessSymmetryResult.Data2=Data2;
end

XPnum=0;
YPnum=0;
Anum=0;
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
      end
end
fn=fieldnames(ResultStruct.poligonos);
for i=1:length(Data2(:,1))
      for j=2:length(fn)
          if ((strcmp(ResultStruct.poligonos.(char(fn(j))).nombre{1},Data2{i,3}))&&(length(ResultStruct.poligonos.(char(fn(j))).posicion(:,1)==4)))
             Areas(Anum+1)=ResultStruct.poligonos.(char(fn(j))); 
             Anum=Anum+1;
          end
      end
end


X_percentage_FS=Data1{1,1}/100;
X_percentage_CA=Data1{2,1}/100;


for i=1:XPnum
    Perfil_FlatnessSymmetryX_datos(i).X_percentage_FS=X_percentage_FS;
    Perfil_FlatnessSymmetryX_datos(i).X_percentage_CA=X_percentage_CA;
    Perfil_FlatnessSymmetryX_pix(1,:,i)=Perfiles_X(i).posicion(1,:);
    Perfil_FlatnessSymmetryX_pix(2,:,i)=Perfiles_X(i).posicion(2,:);
    pos=Perfil_FlatnessSymmetryX_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_FlatnessSymmetryX_datos(i).Nombre=Data2{i,1};
    Perfil_FlatnessSymmetryX_datos(i).datos=[];
    Perfil_FlatnessSymmetryX_datos(i).coordx=[];
    Perfil_FlatnessSymmetryX_datos(i).coordy=[];
    Perfil_FlatnessSymmetryX_datos(i).pix_central=[];
    Perfil_FlatnessSymmetryX_datos(i).pos50_1=[];
    Perfil_FlatnessSymmetryX_datos(i).pos50_2=[];
    Perfil_FlatnessSymmetryX_datos(i).pix50_1=[];
    Perfil_FlatnessSymmetryX_datos(i).pix50_2=[];
    Perfil_FlatnessSymmetryX_datos(i).pix80_1=[];
    Perfil_FlatnessSymmetryX_datos(i).pix80_2=[];
    Perfil_FlatnessSymmetryX_datos(i).min_value=[];
    Perfil_FlatnessSymmetryX_datos(i).max_value=[];
    Perfil_FlatnessSymmetryX_datos(i).min_pix=[];
    Perfil_FlatnessSymmetryX_datos(i).max_pix=[];
    Perfil_FlatnessSymmetryX_datos(i).Flatness=[];
    Perfil_FlatnessSymmetryX_datos(i).Areas=[];
    Perfil_FlatnessSymmetryX_datos(i).Symmetry=[];
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_FlatnessSymmetryX_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_FlatnessSymmetryX_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end

    iteraciones=20;
for it=1:iteraciones
    perfil=smooth(perfil);
end

Perfil_FlatnessSymmetryX_datos(i).datos=perfil;
    
vx2=(Perfil_FlatnessSymmetryX_datos(i).coordx-OrigenCoord.posicion(1)).^2;
vy2=(Perfil_FlatnessSymmetryX_datos(i).coordy-OrigenCoord.posicion(2)).^2;
[valormin,pix_central]=min(vx2+vy2);
CentralAxis_Value=perfil(pix_central);
Perfil_FlatnessSymmetryX_datos(i).pix_central=pix_central;
CentralAxis_pix=pix_central;

[limite_50_1,pix_limite_50_1]=min(abs((perfil(1:floor(length(perfil)/2))-CentralAxis_Value*X_percentage_FS)));
[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxis_Value*X_percentage_FS));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_1=[Perfil_FlatnessSymmetryX_datos(i).coordx(pix_limite_50_1) Perfil_FlatnessSymmetryX_datos(i).coordy(pix_limite_50_1)];
pix_limite_80_1=round((pix_limite_50_2-pix_limite_50_1)*(1-X_percentage_CA)/2)+pix_limite_50_1;
pix_limite_80_2=round((pix_limite_50_2-pix_limite_50_1)*(1+X_percentage_CA)/2)+pix_limite_50_1;
Perfil_FlatnessSymmetryX_datos(i).pos50_1=pos_limite_50_1;
Perfil_FlatnessSymmetryX_datos(i).pix50_1=pix_limite_50_1;
Perfil_FlatnessSymmetryX_datos(i).pix80_1=pix_limite_80_1;
Perfil_FlatnessSymmetryX_datos(i).pix80_2=pix_limite_80_2;

[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxis_Value*X_percentage_FS));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_2=[Perfil_FlatnessSymmetryX_datos(i).coordx(pix_limite_50_2) Perfil_FlatnessSymmetryX_datos(i).coordy(pix_limite_50_2)];
Perfil_FlatnessSymmetryX_datos(i).pos50_2=pos_limite_50_2;
Perfil_FlatnessSymmetryX_datos(i).pix50_2=pix_limite_50_2;


[Perfil_FlatnessSymmetryX_datos(i).min_value,pix_min]=min(perfil(pix_limite_80_1:pix_limite_80_2));
pix_min=round(pix_min+pix_limite_80_1);
Perfil_FlatnessSymmetryX_datos(i).min_pix=pix_min;
[Perfil_FlatnessSymmetryX_datos(i).max_value,pix_max]=max(perfil(pix_limite_80_1:pix_limite_80_2));
pix_max=round(pix_max+pix_limite_80_1);
Perfil_FlatnessSymmetryX_datos(i).max_pix=pix_max;
Perfil_FlatnessSymmetryX_datos(i).Flatness=((Perfil_FlatnessSymmetryX_datos(i).max_value-Perfil_FlatnessSymmetryX_datos(i).min_value)/(Perfil_FlatnessSymmetryX_datos(i).max_value+Perfil_FlatnessSymmetryX_datos(i).min_value))*100;

Perfil_FlatnessSymmetryX_datos(i).Areas=[sum(perfil(pix_limite_50_1:CentralAxis_pix)) sum(perfil(CentralAxis_pix:pix_limite_50_2))];
Perfil_FlatnessSymmetryX_datos(i).Symmetry=100*(Perfil_FlatnessSymmetryX_datos(i).Areas(1)-Perfil_FlatnessSymmetryX_datos(i).Areas(2))/(Perfil_FlatnessSymmetryX_datos(i).Areas(1)+Perfil_FlatnessSymmetryX_datos(i).Areas(2));


end


if XPnum>0
    FlatnessSymmetryResult.Perfil_FlatnessSymmetryX_datos=Perfil_FlatnessSymmetryX_datos;
end
if XPnum>1
Flatness_X_mean.Nombre='X Flatness mean';
Flatness_X_mean.ValorObtenido=mean([Perfil_FlatnessSymmetryX_datos(:).Flatness]);
FlatnessSymmetryResult.Flatness_X_mean=Flatness_X_mean;
Symmetry_X_mean.Nombre='X Symmetry mean';
Symmetry_X_mean.ValorObtenido=mean([Perfil_FlatnessSymmetryX_datos(:).Symmetry]);
FlatnessSymmetryResult.Symmetry_X_mean=Symmetry_X_mean;
end


Y_percentage_FS=Data1{1,2}/100;
Y_percentage_CA=Data1{2,2}/100;
for i=1:YPnum
    Perfil_FlatnessSymmetryY_datos(i).Y_percentage_FS=Y_percentage_FS;
    Perfil_FlatnessSymmetryY_datos(i).Y_percentage_CA=Y_percentage_CA;
    Perfil_FlatnessSymmetryY_pix(1,:,i)=Perfiles_Y(i).posicion(1,:);
    Perfil_FlatnessSymmetryY_pix(2,:,i)=Perfiles_Y(i).posicion(2,:);
    pos=Perfil_FlatnessSymmetryY_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_FlatnessSymmetryY_datos(i).Nombre=Data2{i,2};
    Perfil_FlatnessSymmetryY_datos(i).datos=[];
    Perfil_FlatnessSymmetryY_datos(i).coordx=[];
    Perfil_FlatnessSymmetryY_datos(i).coordy=[];
    Perfil_FlatnessSymmetryY_datos(i).pix_central=[];
    Perfil_FlatnessSymmetryY_datos(i).pos50_1=[];
    Perfil_FlatnessSymmetryY_datos(i).pos50_2=[];
    Perfil_FlatnessSymmetryY_datos(i).pix50_1=[];
    Perfil_FlatnessSymmetryY_datos(i).pix50_2=[];
    Perfil_FlatnessSymmetryY_datos(i).pix80_1=[];
    Perfil_FlatnessSymmetryY_datos(i).pix80_2=[];
    Perfil_FlatnessSymmetryY_datos(i).min_value=[];
    Perfil_FlatnessSymmetryY_datos(i).max_value=[];
    Perfil_FlatnessSymmetryY_datos(i).min_pix=[];
    Perfil_FlatnessSymmetryY_datos(i).max_pix=[];
    Perfil_FlatnessSymmetryY_datos(i).Flatness=[];
    Perfil_FlatnessSymmetryY_datos(i).Areas=[];
    Perfil_FlatnessSymmetryY_datos(i).Symmetry=[];
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_FlatnessSymmetryY_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_FlatnessSymmetryY_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end

    iteraciones=20;
for it=1:iteraciones
    perfil=smooth(perfil);
end
    Perfil_FlatnessSymmetryY_datos(i).datos=perfil;


vx2=(Perfil_FlatnessSymmetryY_datos(i).coordx-OrigenCoord.posicion(1)).^2;
vy2=(Perfil_FlatnessSymmetryY_datos(i).coordy-OrigenCoord.posicion(2)).^2;
[valormin,pix_central]=min(vx2+vy2);
CentralAxis_Value=perfil(pix_central);
Perfil_FlatnessSymmetryY_datos(i).pix_central=pix_central;
CentralAxis_pix=pix_central;

[limite_50_1,pix_limite_50_1]=min(abs((perfil(1:floor(length(perfil)/2))-CentralAxis_Value*Y_percentage_FS)));
[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxis_Value*Y_percentage_FS));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_1=[Perfil_FlatnessSymmetryY_datos(i).coordx(pix_limite_50_1) Perfil_FlatnessSymmetryY_datos(i).coordy(pix_limite_50_1)];
pix_limite_80_1=round((pix_limite_50_2-pix_limite_50_1)*(1-Y_percentage_CA)/2)+pix_limite_50_1;
pix_limite_80_2=round((pix_limite_50_2-pix_limite_50_1)*(1+Y_percentage_CA)/2)+pix_limite_50_1;
Perfil_FlatnessSymmetryY_datos(i).pos50_1=pos_limite_50_1;
Perfil_FlatnessSymmetryY_datos(i).pix50_1=pix_limite_50_1;
Perfil_FlatnessSymmetryY_datos(i).pix80_1=pix_limite_80_1;
Perfil_FlatnessSymmetryY_datos(i).pix80_2=pix_limite_80_2;

[limite_50_2,pix_limite_50_2]=min(abs(perfil(floor(length(perfil)/2):length(perfil))-CentralAxis_Value*Y_percentage_FS));
pix_limite_50_2=pix_limite_50_2+floor(length(perfil)/2)-1;
pos_limite_50_2=[Perfil_FlatnessSymmetryY_datos(i).coordx(pix_limite_50_2) Perfil_FlatnessSymmetryY_datos(i).coordy(pix_limite_50_2)];
Perfil_FlatnessSymmetryY_datos(i).pos50_2=pos_limite_50_2;
Perfil_FlatnessSymmetryY_datos(i).pix50_2=pix_limite_50_2;


[Perfil_FlatnessSymmetryY_datos(i).min_value,pix_min]=min(perfil(pix_limite_80_1:pix_limite_80_2));
pix_min=round(pix_min+pix_limite_80_1);
Perfil_FlatnessSymmetryY_datos(i).min_pix=pix_min;
[Perfil_FlatnessSymmetryY_datos(i).max_value,pix_max]=max(perfil(pix_limite_80_1:pix_limite_80_2));
pix_max=round(pix_max+pix_limite_80_1);
Perfil_FlatnessSymmetryY_datos(i).max_pix=pix_max;
Perfil_FlatnessSymmetryY_datos(i).Flatness=((Perfil_FlatnessSymmetryY_datos(i).max_value-Perfil_FlatnessSymmetryY_datos(i).min_value)/(Perfil_FlatnessSymmetryY_datos(i).max_value+Perfil_FlatnessSymmetryY_datos(i).min_value))*100;

Perfil_FlatnessSymmetryY_datos(i).Areas=[sum(perfil(pix_limite_50_1:CentralAxis_pix)) sum(perfil(CentralAxis_pix:pix_limite_50_2))];
Perfil_FlatnessSymmetryY_datos(i).Symmetry=100*(Perfil_FlatnessSymmetryY_datos(i).Areas(1)-Perfil_FlatnessSymmetryY_datos(i).Areas(2))/(Perfil_FlatnessSymmetryY_datos(i).Areas(1)+Perfil_FlatnessSymmetryY_datos(i).Areas(2));


end


if YPnum>0
    FlatnessSymmetryResult.Perfil_FlatnessSymmetryY_datos=Perfil_FlatnessSymmetryY_datos;
end
if YPnum>1
Flatness_Y_mean.Nombre='Y Flatness mean';
Flatness_Y_mean.ValorObtenido=mean([Perfil_FlatnessSymmetryY_datos(:).Flatness]);
FlatnessSymmetryResult.Flatness_Y_mean=Flatness_Y_mean;
Symmetry_Y_mean.Nombre='Y Symmetry mean';
Symmetry_Y_mean.ValorObtenido=mean([Perfil_FlatnessSymmetryY_datos(:).Symmetry]);
FlatnessSymmetryResult.Symmetry_Y_mean=Symmetry_Y_mean;
end


for i=1:Anum
    
    Area_FlatnessSymmetry_datos(i).Posicion=Areas(i).posicion;
    Area_FlatnessSymmetry_datos(i).Nombre=Data2{i,3};
    Area_FlatnessSymmetry_datos(i).datos=[];
    Area_FlatnessSymmetry_datos(i).min_coord_img=[];
    Area_FlatnessSymmetry_datos(i).max_coord_img=[];
    Area_FlatnessSymmetry_datos(i).min_coord_roi=[];
    Area_FlatnessSymmetry_datos(i).max_coord_roi=[];
    Area_FlatnessSymmetry_datos(i).min_value=[];
    Area_FlatnessSymmetry_datos(i).max_value=[];
    Area_FlatnessSymmetry_datos(i).Flatness=[];
    Area_FlatnessSymmetry_datos(i).Areas=[];
    Area_FlatnessSymmetry_datos(i).Symmetry=[];
    
    pos=Areas(i).posicion;
    [x,y,BW,xi,yi] = roipoly(OutputIMG,pos(1:4,1),pos(1:4,2));
    valor_intensidades=OutputIMG(y(1):y(2),x(1):x(2));
    valor_intensidades(BW==0)=NaN;
    [valor_min,pix_min_Y]=min(valor_intensidades);
    [valor_min,pix_min_X]=min(valor_min);
    pix_min_Y=pix_min_Y(pix_min_X);
    [valor_max,pix_max_Y]=max(valor_intensidades);
    [valor_max,pix_max_X]=max(valor_max);
    pix_max_Y=pix_max_Y(pix_max_X);
    Flatness=100*(valor_max-valor_min)/(valor_max+valor_min);
    pix_min_X_img=pix_min_X+x(1);
    pix_min_Y_img=pix_min_Y+y(1);
    pix_max_X_img=pix_max_X+x(1);
    pix_max_Y_img=pix_max_Y+y(1);
    CentroX=floor((x(2)-x(1))/2);
    CentroY=floor((y(2)-y(1))/2);
    Area_izq=sum(sum(OutputIMG(y(1):y(2),x(1):CentroX)));
    Area_der=sum(sum(OutputIMG(y(1):y(2),(CentroX+1):x(2))));
    Area_sup=sum(sum(OutputIMG(y(1):CentroY,x(1):x(2))));
    Area_inf=sum(sum(OutputIMG((CentroY+1):y(2),x(1):x(2))));
    
    SymmetryX=100*(Area_izq-Area_der)/(Area_izq+Area_der);
    SymmetryY=100*(Area_sup-Area_inf)/(Area_sup+Area_inf);
    
    
    
    Area_FlatnessSymmetry_datos(i).datos=valor_intensidades;
    Area_FlatnessSymmetry_datos(i).min_coord_roi=[pix_min_X pix_min_Y];
    Area_FlatnessSymmetry_datos(i).max_coord_roi=[pix_max_X pix_max_Y];
    Area_FlatnessSymmetry_datos(i).min_coord_img=[pix_min_X_img pix_min_Y_img];
    Area_FlatnessSymmetry_datos(i).max_coord_img=[pix_max_X_img pix_max_Y_img];
    Area_FlatnessSymmetry_datos(i).min_value=valor_min;
    Area_FlatnessSymmetry_datos(i).max_value=valor_max;
    Area_FlatnessSymmetry_datos(i).Flatness=Flatness;
    Area_FlatnessSymmetry_datos(i).Areas=[Area_izq Area_der Area_sup Area_inf];
    Area_FlatnessSymmetry_datos(i).Symmetry=[SymmetryX SymmetryY];
    
   

if Anum>0
FlatnessSymmetryResult.Area_FlatnessSymmetry_datos=Area_FlatnessSymmetry_datos;
end

end
PlotNumber=[1; XPnum; YPnum; Anum];