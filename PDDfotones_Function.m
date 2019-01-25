function PDDfotones_Function
global myhandles4 ResultStruct S OutputIMG PDDfotonesResult PlotNumber callindex2 Variables

try
if callindex2==1 %Abre desde TablaResultados
    Data1=Variables.Functions.PDDfotones.PDDfotonesResult.Data1;
    Data2=Variables.Functions.PDDfotones.PDDfotonesResult.Data2;
    callindex2=0;
else %Abre desde ProgramaQA2
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    PDDfotonesResult.Data1=Data1;
    PDDfotonesResult.Data2=Data2;
end
catch%Abre desde ProgramaQA2
    Data1=myhandles4.uitable1.Data;
    Data2=myhandles4.uitable2.Data;
    PDDfotonesResult.Data1=Data1;
    PDDfotonesResult.Data2=Data2;
end


fn=fieldnames(ResultStruct.perfiles);
for j=2:length(fn)
          if strcmp(ResultStruct.perfiles.(char(fn(j))).nombre{1},Data2{1,1})
             Perfil_PDD=ResultStruct.perfiles.(char(fn(j))); 
          end
end



Perfil_PDD_pix(1,:)=Perfil_PDD.posicion(1,:);
Perfil_PDD_pix(2,:)=Perfil_PDD.posicion(2,:);
pos=Perfil_PDD_pix(:,:);
dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
dist_mm=dist*S;
dx=(pos(2,1)-pos(1,1));
dy=(pos(2,2)-pos(1,2));
u=[dx dy]/dist;
perfil=zeros(1,round(dist));
Perfil_PDD_datos.Nombre=Data2{1,1};
Perfil_PDD_datos.datos=[];
Perfil_PDD_datos.coordx=[];
Perfil_PDD_datos.coordy=[];
Perfil_PDD_datos.pos_max=[];
Perfil_PDD_datos.pix_max=[];
Perfil_PDD_datos.Perc_asked=[];
Perfil_PDD_datos.pix_Perc_asked=[];
Perfil_PDD_datos.pos_Perc_asked=[];
Perfil_PDD_datos.valor_Perc_asked=[];
Perfil_PDD_datos.Z_asked=[];
Perfil_PDD_datos.valor_Z_asked=[];
Perfil_PDD_datos.pix_Z_asked=[];
Perfil_PDD_datos.new_S=[];
Perfil_PDD_datos.N_asked=[];
Perfil_PDD_datos.D_asked=[];
Perfil_PDD_datos.valor_R_asked=[];
    
for dr=0:round(dist);
        coord=round(pos(1,:)+(u*dr));
        perfil(dr+1)=OutputIMG(coord(2),coord(1));
        Perfil_PDD_datos.coordx(dr+1)=coord(1);%Coordenadas x
        Perfil_PDD_datos.coordy(dr+1)=coord(2);%Coordenadas y
end
    iteraciones=20;
for it=1:iteraciones
    perfil=smooth(perfil);
end
Perfil_PDD_datos.datos=perfil;
new_S=length(perfil)/dist_mm;
Perfil_PDD_datos.new_S=new_S;

Perc_asked=Data1(:,1);
Perc_asked=cell2mat(Perc_asked)/100;
for i=1:length(Perc_asked)
Perfil_PDD_datos.Perc_asked(i).value=Perc_asked(i);
end

Z_asked=Data1(:,2);
Z_asked=cell2mat(Z_asked);
for i=1:length(Z_asked)
Perfil_PDD_datos.Z_asked(i).value=Z_asked(i);
end

N_asked1=Data1(:,3);
D_asked1=Data1(:,4);
if isempty(N_asked1{1})
   N_asked1={};
end
if isempty(D_asked1{1})
   D_asked1={};
end
N_asked=0;
D_asked=0;
Perfil_PDD_datos.N_asked=N_asked1;
Perfil_PDD_datos.D_asked=D_asked1;
Razones={' ';'%D1';'%D2';'%D3';'%D4';'%D5';'%D6';'Z1';'Z2';'Z3';'Z4';'Z5';'Z6'};
for i=1:length(N_asked1)
    for j=2:length(Razones)
    if strcmp(N_asked1{i},Razones{j})
    N_asked(i)=j-1; 
    end
    if strcmp(D_asked1{i},Razones{j})
    D_asked(i)=j-1; 
    end
    
    end          
end


[valor_max,pix_max]=max(perfil);
Perfil_PDD_datos.pix_max=pix_max;
%Perfil_PDD_datos.datos(Perfil_PDD_datos.pix_max) es el valor del maximo.
%valor_Perc_asked
pos_max=[Perfil_PDD_datos.coordx(pix_max) Perfil_PDD_datos.coordy(pix_max)];
Perfil_PDD_datos.pos_max=pos_max;

Pnum=length(Perc_asked);
for i=1:Pnum
[valor_Perc_asked(i),pix_Perc_asked(i)]=min(abs((perfil(pix_max:end))-valor_max*Perc_asked(i)));
pos_Perc_asked(:,:,i)=[Perfil_PDD_datos.coordx(pix_Perc_asked(i)) Perfil_PDD_datos.coordy(pix_Perc_asked(i))];
end
Perfil_PDD_datos.valor_Perc_asked=pix_Perc_asked/new_S;
Perfil_PDD_datos.pix_Perc_asked=pix_Perc_asked;
Perfil_PDD_datos.pos_Perc_asked=pos_Perc_asked;

Znum=length(Z_asked);
for i=1:Znum
pix_Z_asked(i)=round(Z_asked(i)*new_S);
Perfil_PDD_datos.valor_Z_asked(i)=(perfil(pix_Z_asked(i))/valor_max)*100;
end
Perfil_PDD_datos.pix_Z_asked=pix_Z_asked;

Rnum=length(N_asked);
if N_asked==0
    Rnum=0;
end
for i=1:Rnum
    if  N_asked(i)<=Pnum
        N_asked(i)=Perfil_PDD_datos.valor_Perc_asked(N_asked(i));
    elseif (N_asked(i)>6)&&(N_asked(i)<=6+Znum)
        N_asked(i)=Perfil_PDD_datos.valor_Z_asked(N_asked(i)-6);
    end
        if  D_asked(i)<=Pnum
        D_asked(i)=Perfil_PDD_datos.valor_Perc_asked(D_asked(i));
    elseif (D_asked(i)>6)&&(D_asked(i)<=6+Znum)
        D_asked(i)=Perfil_PDD_datos.valor_Z_asked(D_asked(i)-6);
        end
    R_asked(i).value=N_asked(i)/D_asked(i);
end

if Rnum~=0
  Perfil_PDD_datos.R_asked=R_asked;
end



PDDfotonesResult.Perfil_PDD_datos=Perfil_PDD_datos;


PlotNumber=[1;Pnum;Znum;Rnum];
end