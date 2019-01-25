%F(i, j) is the fluence delivered to the pixel (i, j) area
%C(i, j) are the counts proportional to the collected charge on the pixel(i, j)
%G(i, j) is the calibration coefficient (or factor), unknown. Sensitivity, gain, or response  of the pixel(i, j).
%F(i, j) = C(i, j) x G(i, j) 
%A cada imagen le cambio el tamaño del pixel a 5mm. Compromiso error de
%propagacion  y shift, y sensibilidad de la medida.

%Bajo la resolucion de la imagen 0.2mm/pix a 2mm/pix (10*10pix-->1pix)
[filenameCA, pathnameCA] = uigetfile('*.dcm');
infodicomCA = dicominfo([pathnameCA, filenameCA]);
CAini=dicomread([pathnameCA, filenameCA]);
 ylength=length(CAini(:,1));
 xlength=length(CAini(1,:));
 CA=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CA(i,j)=mean(mean(CAini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
CA=double(CA);
%CA=double(imresize(CAini,[(length(CAini(:,1))/10) (length(CAini(1,:))/10)]));



[filenameCB, pathnameCB] = uigetfile('*.dcm');
CBini=dicomread([pathnameCB, filenameCB]);
infodicomCB = dicominfo([pathnameCB, filenameCB]);
 ylength=length(CBini(:,1));
 xlength=length(CBini(1,:));
 CB=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CB(i,j)=mean(mean(CBini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
 CB=double(CB);
%CB=double(imresize(CBini,[(length(CBini(:,1))/10) (length(CBini(1,:))/10)]));


[filenameCC, pathnameCC] = uigetfile('*.dcm');
CCini=dicomread([pathnameCC, filenameCC]);
infodicomCC = dicominfo([pathnameCC, filenameCC]);
 ylength=length(CCini(:,1));
 xlength=length(CCini(1,:));
 CC=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CC(i,j)=mean(mean(CCini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
 CC=double(CC);
%CC=double(imresize(CCini,[(length(CCini(:,1))/10) (length(CCini(1,:))/10)]));
 

[filenameCD, pathnameCD] = uigetfile('*.dcm');
CDini=dicomread([pathnameCD, filenameCD]);
infodicomCD = dicominfo([pathnameCD, filenameCD]);
 ylength=length(CDini(:,1));
 xlength=length(CDini(1,:));
 CD=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CD(i,j)=mean(mean(CDini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
CD=double(CD);
%CD=double(imresize(CDini,[(length(CDini(:,1))/10) (length(CDini(1,:))/10)]));



[filenameCE, pathnameCE] = uigetfile('*.dcm');
CEini=dicomread([pathnameCE, filenameCE]);
infodicomCE = dicominfo([pathnameCE, filenameCE]);
ylength=length(CEini(:,1));
xlength=length(CEini(1,:));
 CE=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CE(i,j)=mean(mean(CEini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
CE=double(CE);
%CE=double(imresize(CEini,[(length(CEini(:,1))/10) (length(CEini(1,:))/10)]));


%CA= FF en el centro.
%CB= FF con shift de 2mm a la derecha.
%CC= FF con shift de 2mm hacia izquierda.
%CD= FF con shift de 2mm hacia arriba.
%CE= FF con shift de 2mm hacia abajo.




Ncol=length(CA(1,:));
Nrow=length(CA(:,1));
L1=ceil(Ncol/2);
L2=floor(Ncol/2);
L3=ceil(Nrow/2);
L4=floor(Nrow/2);

GDB=ones(Nrow,Ncol);
GBD=ones(Nrow,Ncol);

GDC=ones(Nrow,Ncol);
GCD=ones(Nrow,Ncol);

GEB=ones(Nrow,Ncol);
GBE=ones(Nrow,Ncol);

GCE=ones(Nrow,Ncol);
GEC=ones(Nrow,Ncol);


%GDB y GBD
for i=1:(L1-1)
    GDB(L3,i)=prod(CA(L3,(i+1):L1)./CB(L3,i:(L1-1)));
end
for i=(L1+1):(L1+L2)
    GDB(L3,i)=prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i));
end
for j=1:(L3-1)
    GDB(j,L1)=prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1));
end
for j=(L3+1):(L3+L4)
    GDB(j,L1)=prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1));
end
GBD=GDB;


%GDB
for i=1:(L1-1)
    for j=1:(L3-1)
        GDB(j,i)=(prod(CD((j+1):L3,i)./CA(j:(L3-1),i)))*(prod(CA(L3,(i+1):L1)./CB(L3,i:(L1-1))));
    end
    for j=(L3+1):(L3+L4)
        GDB(j,i)=(prod(CA(L3:(j-1),i)./CD((L3+1):j,i)))*(prod(CA(L3,(i+1):L1)./CB(L3,(i:L1-1))));
    end
end
for i=(L1+1):(L1+L2)
    for j=1:(L3-1)
        GDB(j,i)=(prod(CD((j+1):L3,i)./CA(j:(L3-1),i)))*(prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i)));
    end
    for j=(L3+1):(L3+L4)
        GDB(j,i)=(prod(CA(L3:(j-1),i)./CD((L3+1):j,i)))*(prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i)));
    end
end



%GBD
for j=1:(L3-1)
    for i=1:(L1-1)
        GBD(j,i)=(prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1)))*(prod(CA(j,(i+1):L1)./CB(j,i:(L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GBD(j,i)=(prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1)))*(prod(CB(j,L1:(i-1))./CA(j,(L1+1):i)));
    end
end
for j=(L3+1):(L3+L4)
    for i=1:(L1-1)
        GBD(j,i)=(prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1)))*(prod(CA(j,(i+1):L1)./CB(j,(i:L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GBD(j,i)=(prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1)))*(prod(CB(j,L1:(i-1))./CA(j,(L1+1):i)));
    end
end


%GEC y GCE
for i=1:(L1-1)
    GEC(L3,i)=prod(CC(L3,(i+1):L1)./CA(L3,i:(L1-1)));
end
for i=(L1+1):(L1+L2)
    GEC(L3,i)=prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i));
end
for j=1:(L3-1)
    GEC(j,L1)=prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1));
end
for j=(L3+1):(L3+L4)
    GEC(j,L1)=prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1));
end
GCE=GEC;


%GEC
for i=1:(L1-1)
    for j=1:(L3-1)
        GEC(j,i)=(prod(CA((j+1):L3,i)./CE(j:(L3-1),i)))*(prod(CC(L3,(i+1):L1)./CA(L3,i:(L1-1))));
    end
    for j=(L3+1):(L3+L4)
        GEC(j,i)=(prod(CE(L3:(j-1),i)./CA((L3+1):j,i)))*(prod(CC(L3,(i+1):L1)./CA(L3,(i:L1-1))));
    end
end
for i=(L1+1):(L1+L2)
    for j=1:(L3-1)
        GEC(j,i)=(prod(CA((j+1):L3,i)./CE(j:(L3-1),i)))*(prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i)));
    end
    for j=(L3+1):(L3+L4)
        GEC(j,i)=(prod(CE(L3:(j-1),i)./CA((L3+1):j,i)))*(prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i)));
    end
end



%GCE
for j=1:(L3-1)
    for i=1:(L1-1)
        GCE(j,i)=(prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1)))*(prod(CC(j,(i+1):L1)./CA(j,i:(L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GCE(j,i)=(prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1)))*(prod(CA(j,L1:(i-1))./CC(j,(L1+1):i)));
    end
end
for j=(L3+1):(L3+L4)
    for i=1:(L1-1)
        GCE(j,i)=(prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1)))*(prod(CC(j,(i+1):L1)./CA(j,(i:L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GCE(j,i)=(prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1)))*(prod(CA(j,L1:(i-1))./CC(j,(L1+1):i)));
    end
end




%GEB y GBE
for i=1:(L1-1)
    GEB(L3,i)=prod(CA(L3,(i+1):L1)./CB(L3,i:(L1-1)));
end
for i=(L1+1):(L1+L2)
    GEB(L3,i)=prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i));
end
for j=1:(L3-1)
    GEB(j,L1)=prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1));
end
for j=(L3+1):(L3+L4)
    GEB(j,L1)=prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1));
end
GBE=GEB;


%GEB
for i=1:(L1-1)
    for j=1:(L3-1)
        GEB(j,i)=(prod(CA((j+1):L3,i)./CE(j:(L3-1),i)))*(prod(CA(L3,(i+1):L1)./CB(L3,i:(L1-1))));
    end
    for j=(L3+1):(L3+L4)
        GEB(j,i)=(prod(CE(L3:(j-1),i)./CA((L3+1):j,i)))*(prod(CA(L3,(i+1):L1)./CB(L3,(i:L1-1))));
    end
end
for i=(L1+1):(L1+L2)
    for j=1:(L3-1)
        GEB(j,i)=(prod(CA((j+1):L3,i)./CE(j:(L3-1),i)))*(prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i)));
    end
    for j=(L3+1):(L3+L4)
        GEB(j,i)=(prod(CE(L3:(j-1),i)./CA((L3+1):j,i)))*(prod(CB(L3,L1:(i-1))./CA(L3,(L1+1):i)));
    end
end



%GBE
for j=1:(L3-1)
    for i=1:(L1-1)
        GBE(j,i)=(prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1)))*(prod(CA(j,(i+1):L1)./CB(j,i:(L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GBE(j,i)=(prod(CA((j+1):L3,L1)./CE(j:(L3-1),L1)))*(prod(CB(j,L1:(i-1))./CA(j,(L1+1):i)));
    end
end
for j=(L3+1):(L3+L4)
    for i=1:(L1-1)
        GBE(j,i)=(prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1)))*(prod(CA(j,(i+1):L1)./CB(j,(i:L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GBE(j,i)=(prod(CE(L3:(j-1),L1)./CA((L3+1):j,L1)))*(prod(CB(j,L1:(i-1))./CA(j,(L1+1):i)));
    end
end


%GDC y GCD
for i=1:(L1-1)
    GDC(L3,i)=prod(CC(L3,(i+1):L1)./CA(L3,i:(L1-1)));
end
for i=(L1+1):(L1+L2)
    GDC(L3,i)=prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i));
end
for j=1:(L3-1)
    GDC(j,L1)=prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1));
end
for j=(L3+1):(L3+L4)
    GDC(j,L1)=prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1));
end
GCD=GDC;


%GDC
for i=1:(L1-1)
    for j=1:(L3-1)
        GDC(j,i)=(prod(CD((j+1):L3,i)./CA(j:(L3-1),i)))*(prod(CC(L3,(i+1):L1)./CA(L3,i:(L1-1))));
    end
    for j=(L3+1):(L3+L4)
        GDC(j,i)=(prod(CA(L3:(j-1),i)./CD((L3+1):j,i)))*(prod(CC(L3,(i+1):L1)./CA(L3,(i:L1-1))));
    end
end
for i=(L1+1):(L1+L2)
    for j=1:(L3-1)
        GDC(j,i)=(prod(CD((j+1):L3,i)./CA(j:(L3-1),i)))*(prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i)));
    end
    for j=(L3+1):(L3+L4)
        GDC(j,i)=(prod(CA(L3:(j-1),i)./CD((L3+1):j,i)))*(prod(CA(L3,L1:(i-1))./CC(L3,(L1+1):i)));
    end
end



%GCD
for j=1:(L3-1)
    for i=1:(L1-1)
        GCD(j,i)=(prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1)))*(prod(CC(j,(i+1):L1)./CA(j,i:(L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GCD(j,i)=(prod(CD((j+1):L3,L1)./CA(j:(L3-1),L1)))*(prod(CA(j,L1:(i-1))./CC(j,(L1+1):i)));
    end
end
for j=(L3+1):(L3+L4)
    for i=1:(L1-1)
        GCD(j,i)=(prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1)))*(prod(CC(j,(i+1):L1)./CA(j,(i:L1-1))));
    end
    for i=(L1+1):(L1+L2)
        GCD(j,i)=(prod(CA(L3:(j-1),L1)./CD((L3+1):j,L1)))*(prod(CA(j,L1:(i-1))./CC(j,(L1+1):i)));
    end
end



G=(GDB+GBD+GCE+GEC+GEB+GBE+GDC+GCD)/8;

figure(1)
surf(CA), shading interp
 figure(2)
surf(GDB), shading interp
 figure(3)
 surf(GBD), shading interp
 figure(4)
surf(GCE), shading interp
 figure(5)
 surf(GEC), shading interp
 figure(6)
surf(GDC), shading interp
 figure(7)
 surf(GCD), shading interp
 figure(8)
surf(GBE), shading interp
 figure(9)
 surf(GEB), shading interp
 figure(10)
 surf(G), shading interp
  figure(11)
 surf(CA.*G), shading interp


