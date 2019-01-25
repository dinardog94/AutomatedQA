
function varargout = QANews(varargin)
% QANEWS MATLAB code for QANews.fig
%      QANEWS, by itself, creates a new QANEWS or raises the existing
%      singleton*.
%
%      H = QANEWS returns the handle to a new QANEWS or the handle to
%      the existing singleton*.
%
%      QANEWS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QANEWS.M with the given input arguments.
%
%      QANEWS('Property','Value',...) creates a new QANEWS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QANews_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QANews_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% % Edit the above text to modify the response o help QANews

% Last Modified by GUIDE v2.5 02-Nov-2018 15:01:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QANews_OpeningFcn, ...
                   'gui_OutputFcn',  @QANews_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before QANews is made visible.
function QANews_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QANews (see VARARGIN)
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('myicon.PNG'));

% Choose default command line output for QANews
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global imgpath imgDBpath controlpath esqpath ObjDir ObjEDir myhandles3 callindex flag DelayT

myhandles3=handles;
callindex=0;
try
fid=fopen('DelayT.txt');
DelayT3=textscan(fid,'%s','delimiter','\n');
fclose(fid);
DelayT2=DelayT3{1};
DelayT=str2double(DelayT2);
catch
    DelayT=10;
    fid=fopen('DelayT.txt','w');
    fprintf(fid,DelayT);
    fclose(fid);
end

try
fid=fopen('imgPath.txt');
imgpath3=textscan(fid,'%s','delimiter','\n');
fclose(fid);
imgpath2=imgpath3{1};
imgpath = strrep(imgpath2,'/','\');
imgpath=strcat(imgpath,'\');
flag=1;

ObjDir=System.IO.FileSystemWatcher(imgpath{1});
addlistener(ObjDir,'Created',@CrearDir);
ObjDir.EnableRaisingEvents = true; 
ObjDir.IncludeSubdirectories  = true;

try
    load('LastDir.mat')
catch
LastDir=dir(imgpath{1});
[~,idxLAST] = sort([LastDir(:).datenum],'descend');
LastDir=LastDir(idxLAST(1));
LastDir.datenum=0;
save('LastDir.mat','LastDir')     
end


 %Gets or sets a value indicating whether subdirectories within the specified path should be monitored

ObjEDir= timer('ExecutionMode','fixedSpacing','BusyMode','queue');
ObjEDir.StartDelay = 3;
ObjEDir.Period = 3;
ObjEDir.TimerFcn = @ExisDir;
start(ObjEDir)


if 0==exist(imgpath{1})
uiwait(errordlg('No existe carpeta de acceso de imágenes.'));
flag=0;
end



catch
uiwait(errordlg('No existe ruta de acceso de imágenes.'));
flag=0;
end



try
fid2=fopen('imgDBPath.txt');
imgDBpath3=textscan(fid2,'%s','delimiter','\n');
fclose(fid2);
imgDBpath2=imgDBpath3{1};
imgDBpath = strrep(imgDBpath2,'/','\');
imgDBpath=strcat(imgDBpath,'\');
if 0==exist(imgDBpath{1})
uiwait(errordlg('No existe carpeta de guardado de imágenes.'));
end

catch
uiwait(errordlg('No existe ruta de guardado de imágenes.'));
end

try
fid3=fopen('ControlPath.txt');
controlpath3=textscan(fid3,'%s','delimiter','\n');
fclose(fid3);
controlpath2=controlpath3{1};
controlpath = strrep(controlpath2,'/','\');
controlpath=strcat(controlpath,'\');

if 0==exist(controlpath{1})
uiwait(errordlg('No existe carpeta de guardado de controles.'));
end
catch
uiwait(errordlg('No existe ruta de guardado de controles.'));
end


try
fid4=fopen('esqPath.txt');
esqpath3=textscan(fid4,'%s','delimiter','\n');
fclose(fid4);
esqpath2=esqpath3{1};
esqpath = strrep(esqpath2,'/','\');
esqpath=strcat(esqpath,'\');

if 0==exist(esqpath{1})
uiwait(errordlg('No existe carpeta de acceso a templates de control.'));
end
catch
uiwait(errordlg('No existe carpeta de acceso a templates de control.'));
end

if exist('ControlsDetails.mat','file') == 2
    ControlsDetails=cell(0,10);
    load('ControlsDetails.mat')
    SiZe=size(ControlsDetails);
    if SiZe(1)<5
        Ltab=SiZe(1);
    else
        Ltab=14;
    end
    handles.uitable1.Data=ControlsDetails(1:Ltab,1:7);
    handles.uitable2.Data=ControlsDetails(1:Ltab,8:10);
else
    ControlsDetails=cell(0,10);
    save('ControlsDetails.mat','ControlsDetails')
end







% --- Outputs from this function are returned to the command line.
function varargout = QANews_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global row_col callindex controlpath ResultStruct Fiduciales r R S T Variables OOBalarm
callindex=1;
DataTablaInvisible=handles.uitable2.Data;
SelectedControl_Table=DataTablaInvisible{row_col(1),1};
fid3=fopen('ControlPath.txt');
controlpath3=textscan(fid3,'%s','delimiter','\n');
fclose(fid3);
controlpath2=controlpath3{1};
controlpath = strrep(controlpath2,'/','\');
controlpath=strcat(controlpath,'\');
ControlList=dir(controlpath{1});
SelectedControl=[];
for i=3:length(ControlList)%empiezo en 3 porque hay 2 nombres . y ..
        if strcmp([SelectedControl_Table,'.mat'],ControlList(i).name)
            SelectedControl=ControlList(i).name;
        end
end
if isempty(SelectedControl)
 uiwait(warndlg('No se encuentra el control seleccionado.'))   
else
load([controlpath{1},SelectedControl])
ResultStruct=Variables.ResultStruct;
Fiduciales=Variables.Fiduciales;
r=Variables.r;
 try
        R=Variables.R;
        S=Variables.S;
        T=Variables.T;
 catch
 end
PosicionROIs
if OOBalarm>0
     uiwait(warndlg(['Revise los ROIs del control, hubo ',num2str(OOBalarm),' punto(s) límite(s) fuera de la imagen']))
     OOBalarm=0;
end
Transf_Pix2mm
QADesign
callindex=0;
end

function Transf_Pix2mm
global ResultStruct R S T

fn=fieldnames(ResultStruct.perfiles);
for i=2:numel(fn);
posi=ResultStruct.perfiles.(char(fn(i))).posicion;
ResultStruct.perfiles.(char(fn(i))).posicion_mm(1,:)=((S*(R*posi(1,:)'))+T)';
ResultStruct.perfiles.(char(fn(i))).posicion_mm(2,:)=((S*(R*posi(2,:)'))+T)';
end

fn=fieldnames(ResultStruct.puntos);
for i=2:numel(fn);
posi=ResultStruct.puntos.(char(fn(i))).posicion;
ResultStruct.puntos.(char(fn(i))).posicion_mm=((S*(R*posi'))+T)';
end

fn=fieldnames(ResultStruct.poligonos);
for i=2:numel(fn);
posi=ResultStruct.poligonos.(char(fn(i))).posicion;
for j=1:length(posi(:,1))
ResultStruct.poligonos.(char(fn(i))).posicion_mm(j,:)=((S*(R*posi(j,:)'))+T);
end
end

fn=fieldnames(ResultStruct.circulos);
for i=2:numel(fn);
posi=ResultStruct.circulos.(char(fn(i))).posicion;
radius=posi(3)/2;
xCenter = posi(1)+ radius;
yCenter = posi(2) + radius;
ResultStruct.circulos.(char(fn(i))).posicion_mm(1:2)=((S*(R*[xCenter,yCenter]'))+T);
ResultStruct.circulos.(char(fn(i))).posicion_mm(3)=(S*radius);
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
global imgpath ObjDir ObjEDir
imgpath = uigetdir(path,'Seleccione la ruta de acceso de las imágenes');
imgp=fopen('imgPath.txt','w');
imgpath2 = strrep(imgpath,'\','/');
fprintf(imgp,imgpath2);
fclose(imgp);
imgpath={strcat(imgpath,'\')};

delete(ObjDir);
try
    stop(ObjEDir);
    delete(ObjEDir);
catch
end

%Objeto que acusa cambios del sistema de archivos, genera eventos cuando cambia un directorio o un archivo de un directorio
ObjDir=System.IO.FileSystemWatcher(imgpath{1});

%NotifyFilter establece el tipo de cambios (evento) que se van a inspeccionar (evento->callback).
%El evento predeterminado es la combinación OR bit a bit de LastWrite, FileName y DirectoryName.

ObjDir.EnableRaisingEvents = true;


addlistener(ObjDir,'Created',@CrearDir);%Se ejecuta 1 vez. Pero chequear que ejecute comandos dsp de que se haya terminadod de copiar el archivo, esto lleva tiempo.


try
    delete(ObjEDir);
catch
end

ObjEDir= timer('ExecutionMode','fixedSpacing','BusyMode','queue');
ObjEDir.StartDelay = 3;
ObjEDir.Period = 3;
ObjEDir.TimerFcn = @ExisDir;
start(ObjEDir)




function ExisDir(~,~)
global imgpath flag myhandles3
if System.IO.Directory.Exists(imgpath{1})
    if flag==0;
        myhandles3.text2.BackgroundColor=[0 1 0];
        flag=1;
    end
else
    myhandles3.text2.BackgroundColor=[1 0 0];
    flag=0;
end


function CrearDir(~,~)
global myhandles3 ObjDir imgpath
ObjDir.EnableRaisingEvents = false;
myhandles3.text2.String='Analizando';
NewDir=dir(imgpath{1});
AnalizarDir(NewDir)
OldDir=NewDir;
NewDir=dir(imgpath{1});
NewDirOrder=sort([NewDir(3:end).datenum],'descend');
OldDirOrder=sort([OldDir(3:end).datenum],'descend');
while NewDirOrder(1)>OldDirOrder(1)
   OldDir=NewDir;
AnalizarDir(NewDir)
NewDir=dir(imgpath{1}); 
NewDirOrder=sort([NewDir(3:end).datenum],'descend');
OldDirOrder=sort([OldDir(3:end).datenum],'descend');
end
myhandles3.text2.String='';


function AnalizarDir(NewDir)
global imgpath DelayT ObjDir        
        
load('LastDir.mat');
if length(NewDir)>2
NEWFILESidx=[NewDir(3:end).datenum]>LastDir.datenum;
NEWFILESnumber=sum(NEWFILESidx);
if NEWFILESnumber>5
answer = questdlg(['Hay ',num2str(NEWFILESnumber),' nuevos archivos. Desea analizarlos?'],'','Sí','No','Sí');
switch answer
    case 'Sí'
        Dir2Analize=NewDir([false false NEWFILESidx]);
        for i=1:NEWFILESnumber
            archivo=strcat(imgpath{1},Dir2Analize(i).name);
            pause(DelayT)
            AnalizarSubfolder(archivo);
        end
        [~,idxLAST] = sort([Dir2Analize(:).datenum],'descend');
        LastDir=Dir2Analize(idxLAST(1));
        save('LastDir.mat','LastDir')
        ObjDir.EnableRaisingEvents = true;        
    case 'No'
        [~,idxLAST] = sort([NewDir(3:end).datenum],'descend');
        LastDir=NewDir(idxLAST(1)+2);
        save('LastDir.mat','LastDir')
        ObjDir.EnableRaisingEvents = true; 
end    
elseif (NEWFILESnumber<=5) && (NEWFILESnumber>0)
         Dir2Analize=NewDir([false false NEWFILESidx]);
        for i=1:NEWFILESnumber
            archivo=strcat(imgpath{1},Dir2Analize(i).name);
            pause(DelayT)
            AnalizarSubfolder(archivo);
        end
        [~,idxLAST] = sort([Dir2Analize(:).datenum],'descend');
        LastDir=Dir2Analize(idxLAST(1));
        save('LastDir.mat','LastDir')
        ObjDir.EnableRaisingEvents = true;  
elseif NEWFILESnumber==0
    ObjDir.EnableRaisingEvents = true;
end
end

function AnalizarSubfolder(arch)   
DIR=dir(arch);
if DIR(1).isdir
    for i=3:length(DIR)
    arch1=[arch,'\',DIR(i).name];
    DIR2=dir(arch1);
    if DIR2(1).isdir
    for i=3:length(DIR2)
       arch2=[arch1,'\',DIR2(i).name];
        DIR3=dir(arch2);
        if DIR3(1).isdir
            for j=3:length(DIR3)
                arch3=[arch2,'\',DIR3(j).name];
                try
                    if(isdicom(arch3))
                  AnalizarImagen(arch3)
                    end
                catch
                end
            end
       else
           try
               if isdicom(arch2)
          AnalizarImagen(arch2)  
               end
           catch
           end
        end 
    end
    else
           try
               if isdicom(arch1)
          AnalizarImagen(arch1)  
               end
           catch
           end
        end 
    end
else
    try
    if(isdicom(arch))
  AnalizarImagen(arch)
    end
    catch
    end
end
        

function AnalizarImagen(arch)
global ResultStruct Fiduciales r Variables esqpath myhandles3 Functions imgpath OOBalarm

img=double(dicomread(arch));
informacion=dicominfo(arch);
codigo1=informacion.PatientName.FamilyName;
codigo2=informacion.PatientID;
%BORRAR ESTO DSP
codigo2='TPF';
%BORRAR ESTO DSP
Fecha_Placa=datestr(datetime([informacion.ContentDate,informacion.ContentTime(1:6)],'InputFormat','yyyyMMddHHmmSS', 'Format' ,'dd-MMMM-yyyy HH:mm:ss'));
if isfield(informacion,'StudyComments')
Estudio=informacion.StudyComments;%Podria escribir algo
else
    Estudio=informacion.StudyID;
end
try
load('ListaEsquemas.m','-mat');
catch
    esqlist='';
end
template='';
for i=1:length(esqlist(:,2))
    if strcmp(esqlist{i,1},codigo2)
        template=esqlist{i,3};
        i_esq=i;
    end
end

if isempty(template)
    uiwait(errordlg('Imagen con código de template incompatible'));
else
     Variables=[];
     load([esqpath{1},template]);
     ResultStruct=Variables.ResultStruct;
     ResultStruct.InputIMG=img;
     ResultStruct.info=informacion;
     if isfield(ResultStruct.info,'RescaleSlope')
     ResultStruct.InputIMG=ResultStruct.InputIMG.*ResultStruct.info.RescaleSlope+ResultStruct.info.RescaleIntercept;   
     end
     r=Variables.r;
     Functions=fieldnames(Variables.Functions);
     Fiduciales=Variables.Fiduciales;
     Variables.Control.Tipo=codigo2;
     c=clock;
     Nombre=strcat(codigo2,'-',num2str(c(3)),'-',num2str(c(2)),'-',num2str(c(1)),'-',num2str(c(4)),'.',num2str(c(5)),'.',num2str(c(6)));
     Variables.Control.Nombre=Nombre;
     AplicarCorrecciones
     Fiduciales_SistCoord
     PosicionROIs
     Transf_Pix2mm
     InfoROIs
     RealizarCalculos
     RealizarFunctions
     CheckTolerancias
     ControlsDetails=cell(0,10);
     load('ControlsDetails.mat');
     SiZe=size(ControlsDetails);
     if SiZe(1)<5
      Ltab=SiZe(1);   
     else
     Ltab=14;
     end
     report1=ControlsDetails(1:Ltab,1:7);
     report1{1,1}=Fecha_Placa;
     report1{1,2}=datestr(datetime('now','Format','dd/MM/yyyy HH:mm'));%Fecha Control
     report1{1,3}=Estudio;
     report1{1,4}=esqlist{i_esq,2};%era 3
     myhandles3.uitable1.Data=report1;
     ControlsDetails{1,1}=report1{1,1};
     ControlsDetails{1,2}=report1{1,2};
     ControlsDetails{1,3}=report1{1,3};
     ControlsDetails{1,4}=report1{1,4};
     ControlsDetails{1,5}=report1{1,5};
     ControlsDetails{1,6}=report1{1,6};
     ControlsDetails{1,7}=report1{1,7};
     ControlsDetails{1,8}=Nombre;
     ControlsDetails{1,10}=SiZe(1);
     save('ControlsDetails.mat','ControlsDetails');
     myhandles3.uitable2.Data=ControlsDetails(1:Ltab,8:10);
     GuardarControl
     if OOBalarm>0
         uiwait(warndlg(['Revise los ROIs del control, hubo ',num2str(OOBalarm),' punto(s) límite(s) fuera de la imagen']))
         OOBalarm=0;
     end
end

function MoveraDB(arch)
global imgDBpath
if 7==exist(imgDBpath{1})
movefile(arch,imgDBpath{1})
else
    movefile arch
    uiwait(errordlg(strcat({'No existe directorio de controles realizados. Se guardó el último control en'},{' '},{pwd})));
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
end


function Fiduciales_SistCoord
global Fiduciales R S T OrigenCoord ResultStruct

try
 Rmin=Fiduciales.Parameters.Rmin;
Rmax=Fiduciales.Parameters.Rmax;
Sensibilidad=Fiduciales.Parameters.Sensibilidad;
Umbral=Fiduciales.Parameters.Umbral;
 [centers,radii] = imfindcircles(ResultStruct.InputIMG,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',Sensibilidad,'EdgeThreshold',Umbral);   
catch
[centers,radii] = imfindcircles(ResultStruct.InputIMG,[4 12],'ObjectPolarity','dark','Sensitivity',0.90,'EdgeThreshold',0.02);
end

try
Am=[Fiduciales.Am.posicion(1); Fiduciales.Am.posicion(2)];
Bm=[Fiduciales.Bm.posicion(1); Fiduciales.Bm.posicion(2)];
Cm=[Fiduciales.Cm.posicion(1); Fiduciales.Cm.posicion(2)];


dx_ABm=Bm(1)-Am(1);
dy_ABm=Bm(2)-Am(2);
dx_BCm=Cm(1)-Bm(1);
dy_BCm=Cm(2)-Bm(2);
dx_CAm=Am(1)-Cm(1);
dy_CAm=Am(2)-Cm(2);
ABm=sqrt(dx_ABm^2+dy_ABm^2);
BCm=sqrt(dx_BCm^2+dy_BCm^2);
CAm=sqrt(dx_CAm^2+dy_CAm^2);

dss=1;

for i=1:length(centers(:,1));
    Ap=centers(i,:);
    centersleft1=centers;
    centersleft1(i,:) = [];
    for j=1:length(centersleft1(:,1));
        Bp=centersleft1(j,:);
        centersleft2=centersleft1;
        centersleft2(j,:) = [];
        for k=1:length(centersleft2(:,1));
            Cp=centersleft2(k,:);
            dx_AB=Bp(1)-Ap(1);
            dy_AB=Bp(2)-Ap(2);
            dx_BC=Cp(1)-Bp(1);
            dy_BC=Cp(2)-Bp(2);
            dx_CA=Ap(1)-Cp(1);
            dy_CA=Ap(2)-Cp(2);
            AB=sqrt(dx_AB^2+dy_AB^2);
            BC=sqrt(dx_BC^2+dy_BC^2);
            CA=sqrt(dx_CA^2+dy_CA^2);
            s1=AB/ABm;
            s2=BC/BCm;
            s3=CA/CAm;
            s=[s1 s2 s3];
            s=s(~any(isnan(s)|isinf(s),1));
            smin=min(s);
            smax=max(s);
            s=mean(s);
            ds=smax-smin;
            if (ds/s<=0.02)&&(ds/s<dss);%O elijo solo los mejores 3, sin condicion <0.02?
                A=Ap;
                B=Bp;
                C=Cp;
                S=1/s;
            end
        end
    end
end


Fiduciales.A.posicion=A;
Fiduciales.B.posicion=B;
Fiduciales.C.posicion=C;

A=A';
B=B';
C=C';

dx_AB=B(1)-A(1);
dy_AB=B(2)-A(2);
dx_BC=C(1)-B(1);
dy_BC=C(2)-B(2);
dx_CA=A(1)-C(1);
dy_CA=A(2)-C(2);
AB=sqrt(dx_AB^2+dy_AB^2);
BC=sqrt(dx_BC^2+dy_BC^2);
CA=sqrt(dx_CA^2+dy_CA^2);

RyAB=dx_AB/dx_ABm;
RyBC=dx_BC/dx_BCm;
RyCA=dx_CA/dx_CAm;

%Rotacion en eje y
if (((sign(RyAB)==-1)&& (~isinf(RyAB))) || ((sign(RyBC)==-1)&& (~isinf(RyBC))) || ((sign(RyCA)==-1)&& (~isinf(RyCA))))
    dx_AB=-dx_AB;
    dx_BC=-dx_BC;
    dx_CA=-dx_CA;
    Ry=[-1 0;0 1];
else
    Ry=[1 0;0 1];
end

RxAB=dy_AB/dy_ABm;
RxBC=dy_BC/dy_BCm;
RxCA=dy_CA/dy_CAm;
%Rotacion en eje x
if (((sign(RxAB)==-1)&& (~isinf(RxAB))) || ((sign(RxBC)==-1)&& (~isinf(RxBC))) || ((sign(RxCA)==-1)&& (~isinf(RxCA))))
    dy_AB=-dy_AB;
    dy_BC=-dy_BC;
    dy_CA=-dy_CA;
    Rx=[1 0;0 -1];
else
    Rx=[1 0;0 1];
end

%Rotacion en eje z
ai=atan2(dy_AB,dx_AB);
bi=atan2(dy_BC,dx_BC);
ci=atan2(dy_CA,dx_CA);

ar=atan2(dy_ABm,dx_ABm);
br=atan2(dy_BCm,dx_BCm);
cr=atan2(dy_CAm,dx_CAm);
ri=mean([(ai-ar) (bi-br) (ci-cr)]);
Rz=[cos(ri) -sin(ri);sin(ri) cos(ri)];
R=Ry*Rx*Rz;

Ta=Am-(S*(R*A));
Tb=Bm-(S*(R*B));
Tc=Cm-(S*(R*C));
T=[mean([Ta(1) Tb(1) Tc(1)]); mean([Ta(2) Tb(2) Tc(2)])];
OrigenCoord.posicion=(inv(R)*(-T/S)).';
Fiduciales.FactorEscala=S;
catch
    R=[1 0;0 -1];
    if isfield(ResultStruct.info,'ImagerPixelSpacing')
    Fiduciales.FactorEscala=ResultStruct.info.ImagerPixelSpacing(1);
    elseif isfield(ResultStruct.info,'ImagePlanePixelSpacing')
    Fiduciales.FactorEscala=ResultStruct.info.ImagePlanePixelSpacing(1);
    end
    S=Fiduciales.FactorEscala;
    T=[-round(length(ResultStruct.InputIMG(1,:))/2);round(length(ResultStruct.InputIMG(:,1))/2)]*S;
    OrigenCoord.posicion=(inv(R)*(-T/S)).';
end



function PosicionROIs
global ResultStruct R S T OutputIMG OOBalarm OrigenCoord

Limits1=fliplr(size(OutputIMG));
Limits2=[1 1];
OOBalarm=0;

fn=fieldnames(ResultStruct.perfiles);
for i=2:numel(fn);
posi=ResultStruct.perfiles.(char(fn(i))).posicion_mm;

ResultStruct.perfiles.(char(fn(i))).posicion(1,:)=(inv(R)*((posi(1,:)'-T)/S)).';
outofboundary1=ResultStruct.perfiles.(char(fn(i))).posicion(1,:)>Limits1;
outofboundary2=ResultStruct.perfiles.(char(fn(i))).posicion(1,:)<Limits2;
ResultStruct.perfiles.(char(fn(i))).posicion(1,outofboundary1)=Limits1(outofboundary1);
ResultStruct.perfiles.(char(fn(i))).posicion(1,outofboundary2)=Limits2(outofboundary2);
OOBalarm=OOBalarm+sum([outofboundary1 outofboundary2]);

ResultStruct.perfiles.(char(fn(i))).posicion(2,:)=(inv(R)*((posi(2,:)'-T)/S)).';
outofboundary1=ResultStruct.perfiles.(char(fn(i))).posicion(2,:)>Limits1;
outofboundary2=ResultStruct.perfiles.(char(fn(i))).posicion(2,:)<Limits2;
ResultStruct.perfiles.(char(fn(i))).posicion(2,outofboundary1)=Limits1(outofboundary1);
ResultStruct.perfiles.(char(fn(i))).posicion(2,outofboundary2)=Limits2(outofboundary2);
OOBalarm=OOBalarm+sum([outofboundary1 outofboundary2]);
end

fn=fieldnames(ResultStruct.puntos);
for i=2:numel(fn);
posi=ResultStruct.puntos.(char(fn(i))).posicion_mm;
ResultStruct.puntos.(char(fn(i))).posicion=(inv(R)*((posi'-T)/S)).';
outofboundary1=ResultStruct.puntos.(char(fn(i))).posicion>Limits1;
outofboundary2=ResultStruct.puntos.(char(fn(i))).posicion<Limits2;
ResultStruct.puntos.(char(fn(i))).posicion(outofboundary1)=Limits1(outofboundary1);
ResultStruct.puntos.(char(fn(i))).posicion(outofboundary2)=Limits2(outofboundary2);
OOBalarm=OOBalarm+sum([outofboundary1 outofboundary2]);
end

fn=fieldnames(ResultStruct.poligonos);
for i=2:numel(fn);
posi=ResultStruct.poligonos.(char(fn(i))).posicion_mm;
for j=1:length(posi(:,1))
ResultStruct.poligonos.(char(fn(i))).posicion(j,:)=(inv(R)*((posi(j,:)'-T)/S)).';
outofboundary1=ResultStruct.poligonos.(char(fn(i))).posicion(j,:)>Limits1;
outofboundary2=ResultStruct.poligonos.(char(fn(i))).posicion(j,:)<Limits2;
ResultStruct.poligonos.(char(fn(i))).posicion(j,outofboundary1)=Limits1(outofboundary1);
ResultStruct.poligonos.(char(fn(i))).posicion(j,outofboundary2)=Limits2(outofboundary2);
OOBalarm=OOBalarm+sum([outofboundary1 outofboundary2]);
end
end

fn=fieldnames(ResultStruct.circulos);
for i=2:numel(fn);
posi=ResultStruct.circulos.(char(fn(i))).posicion_mm;
xCenter = posi(1);
yCenter = posi(2);
radius=posi(3);
ResultStruct.circulos.(char(fn(i))).posicion(3:4)=([2*radius, 2*radius]/S);
Rpix=radius/S;
ResultStruct.circulos.(char(fn(i))).posicion(1:2)=(inv(R)*(([xCenter,yCenter]'-T)/S)).';
ResultStruct.circulos.(char(fn(i))).posicion(1:2)=ResultStruct.circulos.(char(fn(i))).posicion(1:2)-[Rpix Rpix];
outofboundary1=ResultStruct.circulos.(char(fn(i))).posicion(1:2)>Limits1;
outofboundary2=ResultStruct.circulos.(char(fn(i))).posicion(1:2)<Limits2;
ResultStruct.circulos.(char(fn(i))).posicion(outofboundary1)=Limits1(outofboundary1);
ResultStruct.circulos.(char(fn(i))).posicion(outofboundary2)=Limits2(outofboundary2);
OOBalarm=OOBalarm+sum([outofboundary1 outofboundary2]);
end
OrigenCoord.posicion=round((inv(R)*(-T/S))).';



function InfoROIs
global ResultStruct OutputIMG
try

fn=fieldnames(ResultStruct.perfiles);
for i=2:numel(fn);
    pos=ResultStruct.perfiles.(char(fn(i))).posicion;
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
for dr=0:round(dist);
    coord=round(pos(1,:)+(u*dr));
    perfil(dr+1)=OutputIMG(coord(2),coord(1));
end
ResultStruct.perfiles.(char(fn(i))).datos=perfil;
end


fn=fieldnames(ResultStruct.puntos);
for i=2:numel(fn);
    pos=ResultStruct.puntos.(char(fn(i))).posicion;
    valor_p=OutputIMG(round(pos(2)),round(pos(1)));
    ResultStruct.puntos.(char(fn(i))).datos=valor_p;
end



fn=fieldnames(ResultStruct.poligonos);
for i=2:numel(fn);
    pos=ResultStruct.poligonos.(char(fn(i))).posicion;
    [x2,y2,BW,xi2,yi2] = roipoly(OutputIMG,pos(:,1),pos(:,2));
    valor_r=OutputIMG(y2(1):y2(2),x2(1):x2(2));
    valor_r(BW==0)=NaN;
    ResultStruct.poligonos.(char(fn(i))).datos=valor_r;
    area_r=round(pos(3))*round(pos(4));
    ResultStruct.poligonos.(char(fn(i))).area=area_r;
end



fn=fieldnames(ResultStruct.circulos);
for i=2:numel(fn);
    pos=ResultStruct.circulos.(char(fn(i))).posicion;
    pix=1;
    for x=round(pos(1)):round((pos(1)+pos(3)))
        for y=round(pos(2)):round((pos(2)+pos(4)))
    if (((x-(pos(1)+(pos(3)/2)))^2)/((pos(3)/2)^2) + ((y-(pos(2)+(pos(4)/2)))^2)/((pos(4)/2)^2))<=1
        valor_e(pix)=OutputIMG(round(y),round(x));
        pix=pix+1;
    end
        end
    end
    ResultStruct.circulos.(char(fn(i))).datos=valor_e;
    area_e=pi*round((pos(3)/2)*(pos(4)/2));
    ResultStruct.circulos.(char(fn(i))).area=area_e;
end


catch
end

function RealizarCalculos
global r ResultStruct R S T

try
    
load_r

fn=fieldnames(ResultStruct.expresiones);
for i=1:numel(fn)
    evaluar=ResultStruct.expresiones.(char(fn(i)));
    index1=strfind(evaluar,'=');
    if ~isempty(index1)
      if evaluar(index1(1)+1)~='=';
      eval(ResultStruct.expresiones.(char(fn(i))))
      else
      r.(char(fn(i)))=eval(ResultStruct.expresiones.(char(fn(i))));
      end
    else
    r.(char(fn(i)))=eval(ResultStruct.expresiones.(char(fn(i))));
    end
end
catch
end

function RealizarFunctions
global callindex2 Functions
for j=1:length(Functions)
    callindex2=1;
    feval([Functions{j},'_Function'])
    callindex2=1;
    feval([Functions{j},'_SaveFunction'])
end
        

function CheckTolerancias
global r Variables myhandles3 callindex2 Functions fdt_F warning_F ok_F

ok=0;
warning=0;
fuera=0;
report2=cell(1,2);
a=1;
report2{1,1}='Warnings: ';
report2{1,2}='Fuera de tolerancia: ';
aF=2;
aW=2;

if isfield(Variables,'Tolerancias')
    if isempty(Variables.Tolerancias)
    else
fn=fieldnames(Variables.Tolerancias);
fin=length(fn);

%%%Calculos%%%
for i=1:fin    
    if Variables.Tolerancias.(char(fn(i))).SiNo{1}==1
        Variables.Tolerancias.(char(fn(i))).VObt={r.(char(fn(i)))};
        if ((Variables.Tolerancias.(char(fn(i))).DifAbs{1}==1)&&(~isempty(Variables.Tolerancias.(char(fn(i))).DifAbsT1))&&(~isempty(Variables.Tolerancias.(char(fn(i))).DifAbsT2)))%Dif Absoluta 
           Variables.Tolerancias.(char(fn(i))).VDifAbs={r.(char(fn(i)))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difAbs=abs(Variables.Tolerancias.(char(fn(i))).VDifAbs{1});
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT2{1});
           if ((difAbs>lim2) || (isnan(difAbs)))
               fuera=fuera+1;
               report2{aF,2}=[fn{i},' - Diferencia Absoluta'];
               aF=aF+1;
           else
               if difAbs>lim1
                   warning=warning+1;
                   report2{aW,1}=[fn{i},' - Diferencia Absoluta'];
                   aW=aW+1;
               else
                   ok=ok+1;
               end
           end
        end
        if ((Variables.Tolerancias.(char(fn(i))).DifPorc{1}==1)&&(~isempty(Variables.Tolerancias.(char(fn(i))).DifPorcT1))&&(~isempty(Variables.Tolerancias.(char(fn(i))).DifPorcT2)))%Dif Relativa Porcentual
           Variables.Tolerancias.(char(fn(i))).VDifPorc={((r.(char(fn(i))))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1}))*100/str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difPorc=abs(Variables.Tolerancias.(char(fn(i))).VDifPorc{1});
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT2{1});
           if ((difPorc>lim2) || (isnan(difPorc)))
               fuera=fuera+1;
               report2{aF,2}=[fn{i},' - Diferencia Relativa'];
               aF=aF+1;
           else
               if difPorc>lim1
                   warning=warning+1;
                   report2{aW,1}=[fn{i},' - Diferencia Relativa'];
                   aW=aW+1;
               else
                   ok=ok+1;
               end
           end
        end
        a=a+1;
    end
end
    end
else
end


%%%Functions%%%

fdt_F=0;
warning_F=0;
ok_F=0;
for j=1:length(Functions)
    FDT_i=fdt_F;
    WAR_i=warning_F;
    callindex2=1;
    feval([Functions{j},'_CloseCB'])
    feval([Functions{j},'_Completar_TablaTolerancias'])
    feval([Functions{j},'_CloseCB'])
    FDT_i=fdt_F-FDT_i;
    WAR_i=warning_F-WAR_i;
    if FDT_i~=0
       report2{aF,2}=[num2str(FDT_i),' - ',Functions{j}];
       aF=aF+1;
    end
    if WAR_i~=0
        report2{aW,1}=[num2str(WAR_i),' - ',Functions{j}];
        aW=aW+1;
    end
               
end

ok=ok+ok_F;
warning=warning+warning_F;
fuera=fuera+fdt_F;

colergen = @(color,text) ['<html><table border=0 width=800 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
ControlsDetails=cell(0,10);
load('ControlsDetails.mat');
SiZe=size(ControlsDetails);
if SiZe(1)<5
    Ltab=SiZe(1);
else
    Ltab=14;
end
report1=ControlsDetails(1:Ltab,1:7);
ControlsDetails(2:end+1,:)=ControlsDetails(1:end,:);
report1=[{''},{''},{''},{''},{''},{''},{''};report1];
if fuera>0
report1(1,5:7)=[{colergen('#FF0000 ',num2str(ok))},{colergen('#FF0000 ',num2str(warning))},{colergen('#FF0000 ',num2str(fuera))}];
ControlsDetails(1,5:7)=[{colergen('#FF0000 ',num2str(ok))},{colergen('#FF0000 ',num2str(warning))},{colergen('#FF0000 ',num2str(fuera))}];
ControlsDetails(1,9)={'F'};
elseif warning>0
    report1(1,5:7)=[{colergen('#FFA500 ',num2str(ok))},{colergen('#FFA500 ',num2str(warning))},{colergen('#FFA500 ',num2str(fuera))}];
    ControlsDetails(1,5:7)=[{colergen('#FFA500 ',num2str(ok))},{colergen('#FFA500 ',num2str(warning))},{colergen('#FFA500 ',num2str(fuera))}];
    ControlsDetails(1,9)={'W'};
else
    report1(1,5:7)=[{colergen('#00FF00 ',num2str(ok))},{colergen('#00FF00 ',num2str(warning))},{colergen('#00FF00 ',num2str(fuera))}];
    ControlsDetails(1,5:7)=[{colergen('#00FF00 ',num2str(ok))},{colergen('#00FF00 ',num2str(warning))},{colergen('#00FF00 ',num2str(fuera))}];
    ControlsDetails(1,9)={'O'};
end
save('ControlsDetails.mat','ControlsDetails');

myhandles3.uitable1.Data=report1(1:Ltab,1:end);
BriefReports={};
try
load('BriefReports.mat');
catch
end
BriefReports{end+1}=report2;
save('BriefReports.mat','BriefReports');



function load_r
global ResultStruct r
fn1=fieldnames(ResultStruct);
fn1=fn1(8:11);
for j=1:4;
    fn2=fieldnames(ResultStruct.(char(fn1(j))));
for i=2:numel(fn2);
                r.(char(ResultStruct.(char(fn1(j))).(char(fn2(i))).nombre))=ResultStruct.(char(fn1(j))).(char(fn2(i))).datos;
                posi=strcat(char(ResultStruct.(char(fn1(j))).(char(fn2(i))).nombre),'_p');
                r.([posi])=ResultStruct.(char(fn1(j))).(char(fn2(i))).posicion;
                try
                area=strcat(char(ResultStruct.(char(fn1(j))).(char(fn2(i))).nombre),'_a');
                r.([area])=ResultStruct.(char(fn1(j))).(char(fn2(i))).area;
                catch
                end 
            end
end


function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
global esqpath 
esqpath = uigetdir(path,'Seleccione la ruta de acceso de los templates');
esqp=fopen('esqPath.txt','w');
esqpath2 = strrep(esqpath,'\','/');
fprintf(esqp,esqpath2);
fclose(esqp);
esqpath={strcat(esqpath,'\')};


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global ObjEDir ObjDir
try
stop(ObjEDir);
delete(ObjEDir);
stop(ObjDir);
delete(ObjDir);
catch
end
delete(hObject);


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
global imgDBpath
imgDBpath = uigetdir(path,'Seleccione la ruta de guardado de imágenes');
DBp=fopen('imgDBPath.txt','w');
imgDBpath2 = strrep(imgDBpath,'\','/');
fprintf(DBp,imgDBpath2);
fclose(DBp);
imgDBpath={strcat(imgDBpath,'\')};


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
global row_col
 row_col = eventdata.Indices;
 
 function GuardarControl
global ResultStruct Fiduciales r controlpath Variables R S T
Variables.Fiduciales=Fiduciales;
Variables.R=R;
Variables.S=S;
Variables.T=T;
Variables.r=r;
Variables.ResultStruct=ResultStruct;

try
file=Variables.Control.Nombre;
a=[controlpath,file];
save (a, 'Variables');
catch
[file,path] = uiputfile('*.mat','Se ha realizado un nuevo control. Elija la ruta de guardado.',strcat(Variables.Control.Nombre,'.mat'));
a=[path,file];
try
save (a, 'Variables');
Variables.Control.Nombre=file;
catch
save ([pwd,'\',file], 'Variables');    
uiwait(errordlg(strcat({'Se guardó el último control en'},{' '},{pwd})));
Variables.Control.Nombre=file;
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
end
end
        
 

% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
global controlpath
controlpath = uigetdir(path,'Seleccione la ruta de guardado de controles');
controlp=fopen('ControlPath.txt','w');
controlpath2 = strrep(controlpath,'\','/');
fprintf(controlp,controlpath2);
fclose(controlp);
controlpath={strcat(controlpath,'\')};


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('*.dcm','Seleccione los dicom de background','MultiSelect','on');

for i=1:length(file)
BG(i).infodicom = dicominfo([path, file{i}]);
BG(i).img=im2double(dicomread([path, file{i}]));

if isfield(BG(i).infodicom,'RescaleSlope')
    BG(i).img=BG(i).img.*BG(i).infodicom.RescaleSlope + BG(i).infodicom.RescaleIntercept;   
end

end

z = cat(3,BG.img);
M = mean(z,3);
CV = (std(z,[],3))./M; %Coeficiente de Variación

UMBRAL=0.2;%Qué crierio uso...?Experimental?

Fondo_Sist=CV<UMBRAL;
M(~Fondo_Sist)=0;

Background.M=M;
Background.CV=CV;
Background.info=BG;


f1=figure(1);
surf(M), shading interp
answer = questdlg('Desea guardar el background?','','Sí','No','Sí');

switch answer
    case 'Sí'
prompt = {'Nombre del Background:'};
title = 'Ingrese nombre del background';
answer = inputdlg(prompt,title);
file=answer{1};
path=strcat(pwd,'\','Background','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
a=[path,file];
save (a, 'Background');
close(f1)
    case 'No'
        close(f1)
end


function AplicarCorrecciones
global ResultStruct OutputIMG

if strcmp(ResultStruct.Correcciones.Background,'Ninguno')==0
path=strcat(pwd,'\','Background','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
file=ResultStruct.Correcciones.Background;
load([path, file]);
else
Background.M=zeros(size(ResultStruct.InputIMG));
end

if strcmp(ResultStruct.Correcciones.Ganancia,'Ninguna')==0
path=strcat(pwd,'\','Ganancia','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
file=ResultStruct.Correcciones.Ganancia;
load([path, file]);
else
Ganancia.G=ones(size(ResultStruct.InputIMG));
end

if strcmp(ResultStruct.Correcciones.Calibracion,'Ninguna')==0
path=strcat(pwd,'\','Calibracion','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
file=ResultStruct.Correcciones.Calibracion;
load([path, file]);
Calibracion.I(2:end+1)=Calibracion.I;
Calibracion.I(1)=0;
Calibracion.D(2:end+1)=Calibracion.D;
Calibracion.D(1)=0;
else
Calibracion.I=linspace(0,10000,10001);
Calibracion.D=linspace(0,10000,10001);
end

if strcmp(ResultStruct.Correcciones.FactorCampo,'Ninguno')==0
path=strcat(pwd,'\','FactorCampo','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
file=ResultStruct.Correcciones.FactorCampo;
load([path, file]);
else
FactorCampo=ones(size(ResultStruct.InputIMG));
end


OutputIMG=(ResultStruct.InputIMG-Background.M).*Ganancia.G;
OutputIMG(OutputIMG<0)=0;
v_OutputIMG=OutputIMG(:);
v_OutputIMG=interp1(Calibracion.I, Calibracion.D,v_OutputIMG, 'linear',max(Calibracion.D));
OutputIMG=vec2mat(v_OutputIMG,length(OutputIMG(:,1)))';
OutputIMG=imcrop(OutputIMG, ResultStruct.Crop);
OutputIMG=imrotate(OutputIMG,ResultStruct.angle,'bilinear','crop');



% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
VerTemplates


% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)
global callindex
callindex=0;
QADesign


% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
global callindex
callindex=0;
QADesign


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global row_col ObjDir
DataTablaInvisible=handles.uitable2.Data;
BriefReports={};
load('BriefReports.mat');
if isempty(row_col)
    uiwait(errordlg('Ningún control seleccionado'))
else
helpdlg(BriefReports{DataTablaInvisible{row_col(1),3}},'Sumario');
end


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
global myhandles3
uiwait(FilterResults)
handles.uitable1.Data=myhandles3.uitable1.Data;
handles.uitable2.Data=myhandles3.uitable2.Data;
myhandles3=handles;




% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
global DelayT
prompt = {['El tiempo de espera actual para la transferencia completa de archivos entrantes es de ',num2str(DelayT),'s. Ingrese el valor deseado en segundos:']};
dlg_title = 'Tiempo de demora';
num_lines = 1;
def = {num2str(DelayT)};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if ~isempty(answer)
    DelayT=str2double(answer{1});
    fid=fopen('DelayT.txt','w');
    fprintf(fid,num2str(DelayT));
    fclose(fid);
end


% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
CaliBrandon


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
[file, path] = uigetfile('*.dcm','Seleccione los dicom de background','MultiSelect','on');
if file~=0
for i=1:length(file)
BG(i).infodicom = dicominfo([path, file{i}]);
BG(i).img=im2double(dicomread([path, file{i}]));
end

z = cat(3,BG.img);
M = mean(z,3);
CV = (std(z,[],3))./M; %Coeficiente de Variación

UMBRAL=0.2;%Qué crierio uso...?Experimental?

Fondo_Sist=CV<UMBRAL;
M(~Fondo_Sist)=0;

Background.M=M;
Background.CV=CV;
Background.info=BG;


f1=figure(1);
surf(M), shading interp
answer = questdlg('Desea guardar el background?','','Sí','No','Sí');

switch answer
    case 'Sí'
prompt = {'Nombre del Background:'};
title = 'Ingrese nombre del background';
answer = inputdlg(prompt,title);
file=answer{1};
path=strcat(pwd,'\','Background','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
a=[path,file];
save (a, 'Background');
uiwait(msgbox(['Background guardado en ',pwd,'\Background' ]))
close(f1)
    case 'No'
        close(f1)
end
end


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, handles)    
Ganancia=CorreccionGanancia_DosimetroExt;
if isempty(Ganancia)
else
    prompt = {'Nombre de la matriz de corrección de ganancias:'};
title = 'Guardado de matriz de corrección de ganancias';
answer = inputdlg(prompt,title);
file=answer{1};
path=strcat(pwd,'\','Ganancia','\');
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
a=[path,file];
save (a, 'Ganancia');
uiwait(msgbox(['Matriz de corrección de ganancias guardada en ',pwd,'\Ganancia' ]))
end
    


% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles whilñenot created until after all CreateFcns called


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global imgpath ObjDir myhandles3
NewDir=dir(imgpath{1});
myhandles3.text2.String='Analizando';
try
    AnalizarDir(NewDir)
    myhandles3.text2.String='';
catch
LastDir=dir(imgpath{1});
[~,idxLAST] = sort([LastDir(:).datenum],'descend');
LastDir=LastDir(idxLAST(1));
LastDir.datenum=0;
save('LastDir.mat','LastDir')
ObjDir=System.IO.FileSystemWatcher(imgpath{1});

%NotifyFilter establece el tipo de cambios que se van a inspeccionar (el evento->callback).
addlistener(ObjDir,'Created',@CrearDir);%Se ejecuta 1 vez. Pero chequear que ejecute comandos dsp de que se haya terminadod de copiar el archivo, esto lleva tiempo.

ObjDir.EnableRaisingEvents = true; 
ObjDir.IncludeSubdirectories  = true;   
myhandles3.text2.String='';   
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global row_col callindex controlpath
callindex=1;
DataTablaInvisible=handles.uitable2.Data;
SelectedControl_Table=DataTablaInvisible{row_col(1),1};
fid3=fopen('ControlPath.txt');
controlpath3=textscan(fid3,'%s','delimiter','\n');
fclose(fid3);
controlpath2=controlpath3{1};
controlpath = strrep(controlpath2,'/','\');
controlpath=strcat(controlpath,'\');
ControlList=dir(controlpath{1});
SelectedControl=[];
for i=3:length(ControlList)%empiezo en 3 porque hay 2 nombres . y ..
        if strcmp([SelectedControl_Table,'.mat'],ControlList(i).name)
            SelectedControl=ControlList(i).name;
        end
end
if ~isempty(SelectedControl)
quest=['Desea eliminar el control: ',SelectedControl,'?'];
answer = questdlg(quest);
if ~isempty(answer)
switch answer
    case 'Yes'
delete([controlpath{1},SelectedControl])
load('ControlsDetails.mat')
load('BriefReports.mat')

num=ControlsDetails{row_col(1),10};
tot=length(ControlsDetails(:,1));
cols2mod=tot-num;
ControlsDetails(row_col(1),:)=[];
for k=0:(cols2mod-1)
ControlsDetails{k+1,10}=tot-1-k;    
end   
BriefReports(num)=[];

save('ControlsDetails.mat','ControlsDetails')
save('BriefReports.mat','BriefReports')

    SiZe=size(ControlsDetails);
    if SiZe(1)<5
        Ltab=SiZe(1);
    else
        Ltab=14;
    end
handles.uitable1.Data=ControlsDetails(1:Ltab,1:7);
handles.uitable2.Data=ControlsDetails(1:Ltab,8:10);

    case 'No'
    case 'Cancel'
    end
end


else

    quest='El control seleccionado ha sido eliminado o movido. Desea quitarlo de la lista?';
answer = questdlg(quest);
if ~isempty(answer)
switch answer
    case 'Yes'
load('ControlsDetails.mat')
load('BriefReports.mat')
num=ControlsDetails{row_col(1),10};
tot=length(ControlsDetails(:,1));
cols2mod=tot-num;
ControlsDetails(row_col(1),:)=[];
for k=0:(cols2mod-1)
ControlsDetails{k+1,10}=tot-1-k;    
end   
BriefReports(num)=[];
save('ControlsDetails.mat','ControlsDetails')
save('BriefReports.mat','BriefReports')

    SiZe=size(ControlsDetails);
    if SiZe(1)<5
        Ltab=SiZe(1);
    else
        Ltab=14;
    end
handles.uitable1.Data=ControlsDetails(1:Ltab,1:7);
handles.uitable2.Data=ControlsDetails(1:Ltab,8:10);
    case 'No'
    case 'Cancel'
    end
end
    
end
