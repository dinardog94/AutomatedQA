%F(i, j) is the fluence delivered to the pixel (i, j) area
%C(i, j) are the counts proportional to the collected charge on the pixel(i, j)
%G(i, j) is the calibration coefficient (or factor), unknown. Sensitivity, gain, or response  of the pixel(i, j).
%F(i, j) = C(i, j) x G(i, j) 
%A cada imagen le cambio el tamaño del pixel a 5mm. Compromiso error de
%propagacion  y shift, y sensibilidad de la medida.

S=[1 1.25 1.5 1.25 1 1.25 1.5 1.25 1;1 1.25 1.5 1.25 1 1.25 1.5 1.25 1; 1 1.25 1.5 1.25 1 1.25 1.5 1.25 1;1 1.25 1.5 1.25 1 1.25 1.5 1.25 1;1 1.25 1.5 1.25 1 1.25 1.5 1.25 1;1 1.25 1.5 1.25 1 1.25 1.5 1.25 1;1 1.25 1.5 1.25 1 1.25 1.5 1.25 1];


F=[7 7 7 7 7 7 7 7 7;7 7 7 7.6 7.5 7.6 7 7 7; 7 7 7.6 7.5 7.4 7.5 7.6 7 7; 7 7.6 7.5 7.4 7.3 7.4 7.5 7.6 7;7 7 7.6 7.5 7.4 7.5 7.6 7 7;7 7 7 7.6 7.5 7.6 7 7 7;7 7 7 7 7 7 7 7 7];

%F=[1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1 1];

%CA= FF en el centro.
%CB= FF con shift de 5cm a la derecha.
%CD= FF con shift de 5cm hacia arriba.

CA=(F./S);
Ncol=length(CA(1,:));
Nrow=length(CA(:,1));
CB=F(:,(2:Ncol))./S(:,1:(Ncol-1));
CB(:,Ncol)=zeros(Nrow,1);
CC=F(:,(1:(Ncol-1)))./S(:,2:Ncol);
CC(:,2:Ncol)=CC;
CC(:,1)=zeros(Nrow,1);
CD=F(1:(Nrow-1),:)./S(2:Nrow,:);
CD(2:Nrow,:)=CD;
CD(1,:)=zeros(1,Ncol);
CE=F(2:Nrow,:)./S(1:(Nrow-1),:);
CE(Nrow,:)=zeros(1,Ncol);


%CD=CB;

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
  figure(12)
surf(F), shading interp


