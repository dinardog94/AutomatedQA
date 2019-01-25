function varargout = CaliBrandon(varargin)
% CALIBRANDON MATLAB code for CaliBrandon.fig
%      CALIBRANDON, by itself, creates a new CALIBRANDON or raises the existing
%      singleton*.
%
%      H = CALIBRANDON returns the handle to a new CALIBRANDON or the handle to
%      the existing singleton*.
%
%      CALIBRANDON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRANDON.M with the given input arguments.
%
%      CALIBRANDON('Property','Value',...) creates a new CALIBRANDON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CaliBrandon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CaliBrandon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CaliBrandon

% Last Modified by GUIDE v2.5 26-Sep-2018 13:12:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CaliBrandon_OpeningFcn, ...
                   'gui_OutputFcn',  @CaliBrandon_OutputFcn, ...
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


% --- Executes just before CaliBrandon is made visible.
function CaliBrandon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CaliBrandon (see VARARGIN)

% Choose default command line output for CaliBrandon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CaliBrandon wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CaliBrandon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global DetailsCC
Inum=handles.popupmenu1.Value;
handles.edit1.String=num2str(DetailsCC.shift(Inum));
handles.edit7.String=num2str(DetailsCC.UM(Inum));
if DetailsCC.UM(Inum)==0
set(handles.edit7,'BackgroundColor','red');
end





% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
set(hObject,'BackgroundColor','white');


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global DetailsCC curvas_placa curvas_placaF curva_TPS_rel curva_TPS_relF Calibracion
check=prod(DetailsCC.UM);
if check~=0
    UM=DetailsCC.UM;
    curvas_placaF=curvas_placa;
for i=1:length(curvas_placa(1,:))
    shift2=DetailsCC.shift(i);
    curvaPLOT=curvas_placa(:,i);
    
if shift2<0
shift2=round(-shift2);
curvaPLOT(shift2+1:end+shift2)=curvaPLOT;
curvaPLOT(1:shift2)=[];
elseif shift2>0
shift2=round(shift2);
curvaPLOT=curvaPLOT(shift2+1:end);
curvaPLOT(end+1:end+shift2)=zeros(shift2,1);
end
curvas_placaF(:,i)=curvaPLOT;
end
curva_TPS_relF=curva_TPS_rel;
if handles.checkbox1.Value==1
    curva_TPS_relF(1:str2double(handles.edit12.String))=NaN;
    curva_TPS_relF(str2double(handles.edit13.String):end)=NaN;
    curvas_placaF(1:str2double(handles.edit12.String),:)=NaN;
    curvas_placaF(str2double(handles.edit13.String):end,:)=NaN;
end

dosis_relativa=[];
intensidad_pixel=[];
for um=1:length(UM)
dosis_relativa=[dosis_relativa curva_TPS_relF*(UM(um)/UM(1))];
intensidad_pixel=[intensidad_pixel curvas_placaF(:,um)'];
end

%dosis_relativa=[curva_TPS_relF curva_TPS_relF*(UM(2)/UM(1)) curva_TPS_relF*(UM(3)/UM(1)) curva_TPS_relF*(UM(4)/UM(1))];
%intensidad_pixel=[curvas_placaF(:,1)' curvas_placaF(:,2)' curvas_placaF(:,3)' curvas_placaF(:,4)'];

CentralDose=str2double(handles.edit14.String);
dosis_relativa=dosis_relativa*CentralDose;

axes(handles.axes1);
plot(intensidad_pixel,dosis_relativa)
title(handles.edit8.String)

Calibracion.I=intensidad_pixel;
Calibracion.D=dosis_relativa;
else
    uiwait(errordlg('Falta configurar imágenes'))
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
global Calibracion
if isempty(Calibracion)
    pushbutton3_Callback(hObject, eventdata, handles)
end
file=handles.edit8.String;
path=strcat(pwd,'\','Calibracion','\');
%ctfroot returns the string of the folder's name where the deployable
%archive for the application is expanded. EN LUGAR DE PWD
listaCC=dir(path);
WTD=0;
for i=1:length(listaCC)
    WTD=WTD+sum(strcmp(listaCC(i).name,strcat(file,'.mat')));
end
if WTD>0
   uiwait(errordlg('Nombre de curva de calibración ya existente'))
else
    a=[path,file];
    save (a, 'Calibracion')
    uiwait(msgbox(['Curva de calibración guardada en ',pwd,'\Calibracion' ]))
end

    




function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global curva_TPS
[file2, path2] = uigetfile('*.txt','Seleccione el perfil de referencia');
try
fid = fopen([path2, file2]);
curva_TPS = textscan(fid,'%f');
curva_TPS=curva_TPS{1};
handles.text16.String=file2;
catch
    uiwait(errordlg('Archivo incompatible'));
end




function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global img_CC_ORIGINAL DetailsCC
[file, path] = uigetfile('*.dcm','Seleccione las imagenes de calibración ordenadas alfabéticamente acorde a sus UM','MultiSelect','on');
try
    handles.popupmenu1.String=file;
    handles.text17.String=path;
    for i=1:length(file)
infodicom.(['img_CG',num2str(i)]) = dicominfo([path, file{i}]);
img_CC_ORIGINAL(:,:,i)=double(dicomread([path, file{i}]));
if isfield(infodicom.(['img_CG',num2str(i)]),'RescaleSlope')
    img_CC_ORIGINAL(:,:,i)=img_CC_ORIGINAL(:,:,i).*infodicom.(['img_CG',num2str(i)]).RescaleSlope+infodicom.(['img_CG',num2str(i)]).RescaleIntercept;   
end
    end
    DetailsCC.shift=zeros(i,1);
    DetailsCC.UM=zeros(i,1);
catch
    uiwait(errordlg('Archivo incompatible'));
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
global GANANCIA
[filename, pathname] = uigetfile('*.mat','Seleccione la matriz de correccion de ganancias.');%
try
    load([pathname, filename]);
    GANANCIA=Ganancia.G;
    handles.text11.String=filename;
catch
    uiwait(errordlg('Archivo incompatible'));
    GANANCIA=[];
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
global img_CC_ORIGINAL curva_TPS curva_TPS_rel curvas_placa GANANCIA DetailsCC Calibracion
curvas_placa=[];
img_CC=img_CC_ORIGINAL;
pix_mm_TPS=str2num(handles.edit4.String);
SSDz_TPS=str2num(handles.edit5.String);
pix_mm_placa=str2num(handles.edit2.String);
SSDz_placa=str2num(handles.edit6.String);
if isempty(GANANCIA)
    GANANCIA=ones(size(img_CC(:,:,1)));
end
for i=1:length(img_CC(1,1,:))
img_CC(:,:,i)=img_CC_ORIGINAL(:,:,i).*GANANCIA;
end
%Región central para tomar perfiles de cuña, elijo los 100 mm centrales. Variable zona central ZC 
ZC=100;

Ylength=length(img_CC(:,1,1));
Xlength=length(img_CC(1,:,1));
Xi=round(Xlength/2)-round((ZC/2)*pix_mm_placa);
Xf=round(Xlength/2)+round((ZC/2)*pix_mm_placa);
iteraciones=20;
for i=1:length(img_CC(1,1,:))
curvas_placa(:,i)=mean(img_CC(:,Xi:Xf,i),2);
%for it=1:iteraciones
%curvas_placa(:,i)=smooth(curvas_placa(:,i));
%end
end



puntos_TPSi=length(curva_TPS);
orig_X = linspace(1, puntos_TPSi, puntos_TPSi);
Scale=(pix_mm_placa/pix_mm_TPS)*(SSDz_placa/SSDz_TPS);
new_X = linspace(1, puntos_TPSi, puntos_TPSi*Scale);
curva_TPS_exp= interp1(orig_X, curva_TPS, new_X);
puntos_TPSf=length(curva_TPS_exp);
punto_central_TPS=round(puntos_TPSf/2);
curva_TPS_rel=curva_TPS_exp/curva_TPS_exp(punto_central_TPS);%relativo a la dosis central

%Alineación espacial de los perfiles. Hacer coincidir los centros
pix_central_placa=ceil(Ylength/2);
shift=pix_central_placa-punto_central_TPS;


if shift>0
%Si length(placa)< length(TPS)

curvas_placa(1:shift-1,:)=[];
curvas_placa(puntos_TPSf+1:end,:)=[];

else
%Si No
curva_TPS_rel=curva_TPS_rel(-shift:puntos_TPSf+shift-1);
end

Inum=handles.popupmenu1.Value;
Iname=handles.popupmenu1.String(Inum);

DetailsCC.shift(Inum)=str2double(handles.edit1.String);
DetailsCC.UM(Inum)=str2double(handles.edit7.String);

curvaPLOT=curvas_placa(:,Inum);
shift2=DetailsCC.shift(Inum);

if shift2<0
    shift2=round(-shift2);
    curvaPLOT(shift2+1:end+shift2)=curvaPLOT;
    curvaPLOT(1:shift2)=[];
elseif shift2>0
    shift2=round(shift2);
    curvaPLOT=curvaPLOT(shift2+1:end);
    curvaPLOT(end+1:end+shift2)=zeros(shift2,1);
end
axes(handles.axes1);
plot(curva_TPS_rel)
hold on
plot(curvaPLOT/curvaPLOT(round(length(curvaPLOT)/2)));
title(['Alineación imagen',Iname]);
grid on
hold off
Calibracion=[];


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
global curvas_placaF curva_TPS_relF DetailsCC Calibracion

[waste1 FirstValuePosition]=nanmin(curva_TPS_relF);
for i=1:(length(curvas_placaF(1,:))-1)
[topDval LastValuePosition]=nanmax(curva_TPS_relF*(DetailsCC.UM(i)/DetailsCC.UM(1)));

overlapINI_value=curvas_placaF(FirstValuePosition,i+1);
overlapEND_value=curvas_placaF(LastValuePosition,i);

FVP=FirstValuePosition;
testTPScurv=curva_TPS_relF*(DetailsCC.UM(i+1)/DetailsCC.UM(1));
try
while (testTPScurv(FVP)<topDval) || isnan(curvas_placaF(FPV,i+1))
    FVP=FVP+1;
end
overlapEND_position=FPV;
curvas_placaF(1:overlapEND_position,i+1)=NaN;
catch
end
end

UM=DetailsCC.UM;

dosis_relativa=[];
intensidad_pixel=[];
for um=1:length(UM)
dosis_relativa=[dosis_relativa curva_TPS_relF*(UM(um)/UM(1))];
intensidad_pixel=[intensidad_pixel curvas_placaF(:,um)'];
end

%Quito los NAN que no me dejan interpolar
FKGnan=isnan(intensidad_pixel);
intensidad_pixel(FKGnan)=[];
dosis_relativa(FKGnan)=[];
FKGnan=isnan(dosis_relativa);
dosis_relativa(FKGnan)=[];
intensidad_pixel(FKGnan)=[];
%Hago la curva monotonica creciente
intensidad_pixel=sort(intensidad_pixel);
dosis_relativa=sort(dosis_relativa);
[intensidad_pixel,ia,ic] = unique(intensidad_pixel);
dosis_relativa=dosis_relativa(ia);
CentralDose=str2double(handles.edit14.String);
dosis_relativa=dosis_relativa*CentralDose;
Calibracion.D=dosis_relativa;
Calibracion.I=intensidad_pixel;
axes(handles.axes1);
plot(intensidad_pixel,dosis_relativa)
title(handles.edit8.String)



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
global FIDUCIALES  img_CC_ORIGINAL
Inum=handles.popupmenu1.Value;
[centers,radii] = imfindcircles(img_CC_ORIGINAL(:,:,Inum),[4 13],'ObjectPolarity','dark','Sensitivity',0.905,'EdgeThreshold',0.025);

Am=[FIDUCIALES.Am.posicion(1); FIDUCIALES.Am.posicion(2)];
Bm=[FIDUCIALES.Bm.posicion(1); FIDUCIALES.Bm.posicion(2)];
Cm=[FIDUCIALES.Cm.posicion(1); FIDUCIALES.Cm.posicion(2)];


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

try
    
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

FIDUCIALES.A.posicion=A;
FIDUCIALES.B.posicion=B;
FIDUCIALES.C.posicion=C;

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

%Rotacion en eje y
if (sign(dx_AB/dx_ABm)==-1) || (sign(dx_BC/dx_BCm)==-1) || (sign(dx_CA/dx_CAm)==-1)
   dx_AB=-dx_AB;
  dx_BC=-dx_BC;
   dx_CA=-dx_CA;
   Ry=[-1 0;0 1];
else
    Ry=[1 0;0 1];
end

%Rotacion en eje x
if (sign(dy_AB/dy_ABm)==-1) || (sign(dy_BC/dy_BCm)==-1) || (sign(dy_CA/dy_CAm)==-1)
    dy_AB=-dy_AB;
    dy_BC=-dy_BC;
    dy_CA=-dy_CA;
    Rx=[1 0;0 -1];
else
    Rx=[1 0;0 1];
end

%Rotacion en eje z
ai=atan(dy_AB/dx_AB);
bi=atan(dy_BC/dx_BC);
ci=atan(dy_CA/dx_CA);

ar=atan(dy_ABm/dx_ABm);
br=atan(dy_BCm/dx_BCm);
cr=atan(dy_CAm/dx_CAm);
ri=mean([(ai-ar) (bi-br) (ci-cr)]);
Rz=[cos(ri) -sin(ri);sin(ri) cos(ri)];
R=Ry*Rx*Rz;

Ta=Am-(S*(R*A));
Tb=Bm-(S*(R*B));
Tc=Cm-(S*(R*C));
T=[mean([Ta(1) Tb(1) Tc(1)]); mean([Ta(2) Tb(2) Tc(2)])];
OrigenCoord=(inv(R)*(-T/S)).';
handles.edit1.String=num2str(round(OrigenCoord(2)-round(length(img_CC_ORIGINAL(:,1))/2)));
catch
    uiwait(warndlg('No se encontraron fiduciales. Se ubica el OC en el centro de la imagen.'))
    handles.edit1.String='0';
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
global FIDUCIALES
[filename, pathname] = uigetfile('*.mat','Seleccione el fantoma de fiduciales.');%
try
load([pathname, filename]);
handles.text29.String=Coordenadas{1};
FIDUCIALES.Am.posicion(1)=str2double(Coordenadas(2));
FIDUCIALES.Am.posicion(2)=str2double(Coordenadas(3));
FIDUCIALES.Bm.posicion(1)=str2double(Coordenadas(4));
FIDUCIALES.Bm.posicion(2)=str2double(Coordenadas(5));
FIDUCIALES.Cm.posicion(1)=str2double(Coordenadas(6));
FIDUCIALES.Cm.posicion(2)=str2double(Coordenadas(7));
catch
end
