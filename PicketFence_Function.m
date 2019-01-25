function PicketFence_Function
global myhandles4 ResultStruct R S T OutputIMG PicketFenceResult PlotNumber callindex2 Variables OrigenCoord

try
if callindex2==1 %Abre desde TablaResultados
    Data1=Variables.Functions.PicketFence.PicketFenceResult.Data1;
    Data2=Variables.Functions.PicketFence.PicketFenceResult.Data2;
    callindex2=0;
else
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    PicketFenceResult.Data1=Data1;
    PicketFenceResult.Data2=Data2;
end
catch
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    PicketFenceResult.Data1=Data1;
    PicketFenceResult.Data2=Data2;
end

try
YPnum=0;
fn=fieldnames(ResultStruct.perfiles);
for i=1:length(Data2(:,1))
      for j=2:length(fn)
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{i,1})
             Perfiles_Y(YPnum+1)=ResultStruct.perfiles.(char(fn(j))); 
             YPnum=YPnum+1;
          end
      end
end



for i=1:YPnum
    Perfil_PicketFenceY_pix(1,:,i)=Perfiles_Y(i).posicion(1,:);
    Perfil_PicketFenceY_pix(2,:,i)=Perfiles_Y(i).posicion(2,:);
    pos=Perfil_PicketFenceY_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_PicketFenceY_datos(i).Nombre=Data2{i,1};
    Perfil_PicketFenceY_datos(i).datos=[];
    Perfil_PicketFenceY_datos(i).coordx=[];
    Perfil_PicketFenceY_datos(i).coordy=[];
    Perfil_PicketFenceY_datos(i).pks=[];
    Perfil_PicketFenceY_datos(i).w=[];
    Perfil_PicketFenceY_datos(i).p=[];
    Perfil_PicketFenceY_datos(i).w=[];
    Perfil_PicketFenceY_datos(i).mm_w_pos=[];
    Perfil_PicketFenceY_datos(i).mm_w_pix=[];
    Perfil_PicketFenceY_datos(i).mm_w=[];
    Perfil_PicketFenceY_datos(i).pos_locs=[];
    Perfil_PicketFenceY_datos(i).pos_w=[];
    Perfil_PicketFenceY_datos(i).pix_locs=[];
    Perfil_PicketFenceY_datos(i).pix_w=[];
    Perfil_PicketFenceY_datos(i).mm_w_max=[];
    Perfil_PicketFenceY_datos(i).w_max_pix=[];
    Perfil_PicketFenceY_datos(i).w_max_pos=[];
    Perfil_PicketFenceY_datos(i).mm_w_min=[];
    Perfil_PicketFenceY_datos(i).w_min_pix=[];
    Perfil_PicketFenceY_datos(i).w_min_pos=[];
    Perfil_PicketFenceY_datos(i).deltaSGap=[];
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_PicketFenceY_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_PicketFenceY_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end
        iteraciones=0;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_PicketFenceY_datos(i).datos=perfil;
cotainf=0.75*max(perfil);
perfil(perfil<cotainf)=0;
[pks,locs,w,p] = findpeaks(perfil,'MinPeakHeight',4,'WidthReference','halfprom');%pks=values, locs=indexs, w=widths, p=prominences;
nonPeaks1=w<4;
nonPeaks2=p<0.04;
nonPeaks=or(nonPeaks1,nonPeaks2);
pks(nonPeaks)=[];
locs(nonPeaks)=[];
w(nonPeaks)=[];
p(nonPeaks)=[];
Perfil_PicketFenceY_datos(i).pix_locs=locs;
Perfil_PicketFenceY_datos(i).pos_locs=[Perfil_PicketFenceY_datos(i).coordx(locs); Perfil_PicketFenceY_datos(i).coordy(locs)];
Perfil_PicketFenceY_datos(i).pks=pks;
Perfil_PicketFenceY_datos(i).pix_w=w;
Perfil_PicketFenceY_datos(i).mm_w=S*w;%si esta rotado no funciona, pero el EPID no rota en z axis.
Perfil_PicketFenceY_datos(i).p=p;
[w_max,idwmax]=max(w);
Perfil_PicketFenceY_datos(i).mm_w_max=w_max*S;%Ingresar desde afura
Perfil_PicketFenceY_datos(i).w_max_idx=idwmax;
Perfil_PicketFenceY_datos(i).w_max_pos=[Perfil_PicketFenceY_datos(i).coordx(locs(idwmax)) Perfil_PicketFenceY_datos(i).coordy(locs(idwmax))];
[w_min,idwmin]=min(w);
Perfil_PicketFenceY_datos(i).mm_w_min=w_min*S;%Ingresar desde afura
Perfil_PicketFenceY_datos(i).w_min_idx=idwmin;
Perfil_PicketFenceY_datos(i).w_min_pos=[Perfil_PicketFenceY_datos(i).coordx(locs(idwmin)) Perfil_PicketFenceY_datos(i).coordy(locs(idwmin))];
locs1=locs(1:end-1);
locs2=locs(2:end);
Perfil_PicketFenceY_datos(i).deltaSGap=(locs2-locs1)*S;%Distancia entre gaps
end

if YPnum>0
PicketFenceResult.Perfil_PicketFenceY_datos=Perfil_PicketFenceY_datos;
end

PicketFence_Y_mean.Nombre='mean (w)';
ValorGapMean=mean(mean([Perfil_PicketFenceY_datos(:).pks]));
PicketFence_Y_mean.ValorGapMean=ValorGapMean;
PicketFence_Y_mean.ValorObtenido=mean(mean([Perfil_PicketFenceY_datos(:).mm_w]));
PicketFenceResult.PicketFence_Y_mean=PicketFence_Y_mean;
PicketFence_Y_max.Nombre='max(w)';
[maxval, posmax]=max([Perfil_PicketFenceY_datos(:).mm_w_max]);
PicketFence_Y_max.Index=posmax;
PicketFence_Y_max.ValorObtenido=maxval;
PicketFence_Y_max.Posicion=((S*(R*(Perfil_PicketFenceY_datos(posmax).w_max_pos)'))+T)';
PicketFence_Y_max.Pixel=Perfil_PicketFenceY_datos(posmax).pix_locs(Perfil_PicketFenceY_datos(posmax).w_max_idx);
PicketFenceResult.PicketFence_Y_max=PicketFence_Y_max;
PicketFence_Y_min.Nombre='min(w)';
[minval, posmin]=min([Perfil_PicketFenceY_datos(:).mm_w_min]);
PicketFence_Y_min.Index=posmin;
PicketFence_Y_min.ValorObtenido=minval;
PicketFence_Y_min.Posicion=((S*(R*(Perfil_PicketFenceY_datos(posmin).w_min_pos)'))+T)';
PicketFence_Y_min.Pixel=Perfil_PicketFenceY_datos(posmin).pix_locs(Perfil_PicketFenceY_datos(posmin).w_min_idx);
PicketFenceResult.PicketFence_Y_min=PicketFence_Y_min;

if YPnum>0
    
XPnum=0;
fn=fieldnames(ResultStruct.perfiles);
for i=1:length(Data2(:,2))
      for j=2:length(fn)
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{i,2})
             Perfiles_X(XPnum+1)=ResultStruct.perfiles.(char(fn(j))); 
             XPnum=XPnum+1;
          end
      end
end



for i=1:XPnum
    Perfil_PicketFenceX_pix(1,:,i)=Perfiles_X(i).posicion(1,:);
    Perfil_PicketFenceX_pix(2,:,i)=Perfiles_X(i).posicion(2,:);
    pos=Perfil_PicketFenceX_pix(:,:,i);
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
    Perfil_PicketFenceX_datos(i).Nombre=Data2{i,2};
    Perfil_PicketFenceX_datos(i).datos=[];
    Perfil_PicketFenceX_datos(i).coordx=[];
    Perfil_PicketFenceX_datos(i).coordy=[];
    Perfil_PicketFenceX_datos(i).cota=[];
    Perfil_PicketFenceX_datos(i).datos_inf=[];
    Perfil_PicketFenceX_datos(i).datos_sup=[];
    Perfil_PicketFenceX_datos(i).ValorObtenido=[];
    
    
    for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_PicketFenceX_datos(i).coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_PicketFenceX_datos(i).coordy(dr+1)=coord(2);%Coordenadas y
    end
        iteraciones=0;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_PicketFenceX_datos(i).datos=perfil;
ValorGapMean=mean(mean([Perfil_PicketFenceY_datos(:).pks]));
cota=Data1{1,1}/100;
datos_inf=(perfil<(ValorGapMean-(ValorGapMean*cota)));
datos_sup=(perfil>(ValorGapMean+(ValorGapMean*cota)));
datos_infsup=datos_inf+datos_sup;
Pass=sum(datos_infsup);
Perfil_PicketFenceX_datos(i).cota=cota;
Perfil_PicketFenceX_datos(i).datos_inf=datos_inf;
Perfil_PicketFenceX_datos(i).datos_sup=datos_sup;
Perfil_PicketFenceX_datos(i).ValorObtenido=Pass;
end

if XPnum>0
PicketFenceResult.Perfil_PicketFenceX_datos=Perfil_PicketFenceX_datos;
end


else
    uiwait(warndlg('Indique al menos un perfil Y como input.'))
end


PlotNumber=[1; 1; 1; 2; XPnum];
catch
    uiwait(warndlg('Complete datos de input.'))
end