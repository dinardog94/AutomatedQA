[file, path] = uigetfile('*.dcm','Seleccione los CA','MultiSelect','on');
for i=1:length(file)
infodicom.(['img_CA',num2str(i)]) = dicominfo([path, file{i}]);
img_UMCA(:,:,i)=dicomread([path, file{i}]);
end
CAini=mean(img_UMCA,3);

for i=1:5
    glor(1,:,i)=double(img_UMCA(1070,:,i));
    glor=double(glor);
    for j=1:20
glor(1,:,i)=smooth(glor(1,:,i));
    end
plot(glor(1,:,i))
hold on
end
CAini=mean(img_UMCA,3);

[file, path] = uigetfile('*.dcm','Seleccione los CB','MultiSelect','on');
for i=1:length(file)
infodicom.(['img_CB',num2str(i)]) = dicominfo([path, file{i}]);
img_UMCB(:,:,i)=dicomread([path, file{i}]);
end
CBini=mean(img_UMCB,3);

[file, path] = uigetfile('*.dcm','Seleccione los CD','MultiSelect','on');
for i=1:length(file)
infodicom.(['img_CD',num2str(i)]) = dicominfo([path, file{i}]);
img_UMCD(:,:,i)=dicomread([path, file{i}]);
end
CDini=mean(img_UMCD,3);

 ylength=length(CAini(:,1));
 xlength=length(CAini(1,:));
 CA=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CA(i,j)=mean(mean(CAini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
CA=double(CA);


 ylength=length(CBini(:,1));
 xlength=length(CBini(1,:));
 CB=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CB(i,j)=mean(mean(CBini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
 CB=double(CB);
 
  ylength=length(CDini(:,1));
 xlength=length(CDini(1,:));
 CD=zeros(ylength/20,xlength/20);
 for i=1:(ylength/20)
     for j=1:(xlength/20)
         CD(i,j)=mean(mean(CDini((20*i-19):(20*i),(20*j-19):(20*j))));
     end
 end
CD=double(CD);
 
 
Ncol=length(CA(1,:));
Nrow=length(CA(:,1));
L1=ceil(Ncol/2);
L2=floor(Ncol/2);
L3=ceil(Nrow/2);
L4=floor(Nrow/2);

GDB=ones(Nrow,Ncol);
GBD=ones(Nrow,Ncol);

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

figure(1)
plot(CA(:,L1))
hold on
plot(CA(:,L1).*GDB(:,L1))
hold off

G=(GDB+GBD)/2;
figure(2)
surf(CA.*G), shading interp
