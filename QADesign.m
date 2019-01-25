
function varargout = QADesign(varargin)
% QADESIGN MATLAB code for QADesign.
%      QADESIGN, by itself, creates a new QADESIGN or raises the existing
%      singleton*.
%
%      H = QADESIGN returns the handle to a new QADESIGN or the handle to
%      the existing singleton*.
%
%      QADESIGN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QADESIGN.M with the given input arguments.
%
%      QADESIGN('Property','Value',...) creates a new QADESIGN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QADesign_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QADesign_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QADesign

% Last Modified by GUIDE v2.5 02-Nov-2018 15:03:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QADesign_OpeningFcn, ...
                   'gui_OutputFcn',  @QADesign_OutputFcn, ...
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


% --- Executes just before QADesign is made visible.
function QADesign_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QADesign (see VARARGIN)

javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('myicon.PNG'));

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QADesign wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global ResultStruct R S T OrigenCoord myhandles Fiduciales r gcoOld ColorOld selectedROIaliasOld selectedROItype callindex Variables SelectedFunction esqpath;

myhandles=handles;
gcoOld=matlab.graphics.primitive.Group;
ColorOld=[0 0 0];
selectedROIaliasOld={'Glo'};
selectedROItype='';

BGs(1,:)={'Ninguno'};
listaBG=dir(strcat(pwd,'\','Background'));
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
for i=1:(length(listaBG)-2)
    BGs(i+1,:)={listaBG(i+2).name};
end
set(handles.popupmenu6,'String',BGs);

Gs(1,:)={'Ninguna'};
listaG=dir(strcat(pwd,'\','Ganancia'));
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
for i=1:(length(listaG)-2)
    Gs(i+1,:)={listaG(i+2).name};
end
set(handles.popupmenu13,'String',Gs);


CCs(1,:)={'Ninguna'};
listaCC=dir(strcat(pwd,'\','Calibracion'));
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
for i=1:(length(listaCC)-2)
    CCs(i+1,:)={listaCC(i+2).name};
end
set(handles.popupmenu5,'String',CCs);

FCs(1,:)={'Ninguno'};
listaFC=dir(strcat(pwd,'\','FactorCampo'));
    %ctfroot returns the string of the folder's name where the deployable
    %archive for the application is expanded. EN LUGAR DE PWD
for i=1:(length(listaFC)-2)
    FCs(i+1,:)={listaFC(i+2).name};
end
set(handles.popupmenu16,'String',FCs);

set(handles.sliderB,'min',-10);
set(handles.sliderB,'max',8);
set(handles.sliderC,'max',16);
set(handles.sliderC,'min',0);
set(handles.sliderB,'value',0);
set(handles.sliderC,'value',1);

set(handles.axes3,'XTickLabel',[])
set(handles.axes3,'YTickLabel',[])
set(handles.axes1,'XTickLabel',[])
set(handles.axes1,'YTickLabel',[])

load('Functions_List.mat');
set(handles.popupmenu15,'String',Functions_List);

try
    if callindex==1;%Abre control desde QANews
        callindex=0;
        RedibujarROIs
        AplicarCorrecciones
        mostrarIMG(handles)
        filltables
        filltables2
        SelectedFunction='';
        TablaTolerancias
        SelectedBG=ResultStruct.Correcciones.Background;%String con el nombre del BG
        idxBG=1;
        for i=1:length(BGs)
            if strcmp(BGs{i},SelectedBG)
            idxBG=i;
            end
        end
        set(handles.popupmenu6,'Value',idxBG);

        SelectedG=ResultStruct.Correcciones.Ganancia;
        idxG=1;
        for i=1:length(Gs)
            if strcmp(Gs{i},SelectedG)
            idxG=i;
            end
        end
        set(handles.popupmenu13,'Value',idxG);


        SelectedCC=ResultStruct.Correcciones.Calibracion;
        idxCC=1;
        for i=1:length(CCs)
            if strcmp(CCs{i},SelectedCC)
            idxCC=i;
            end
        end
        set(handles.popupmenu5,'Value',idxCC);

        SelectedFC=ResultStruct.Correcciones.FactorCampo;
        idxFC=1;
        for i=1:length(FCs)
            if strcmp(FCs{i},SelectedFC)
            idxFC=i;
            end
        end
        %set(handles.popupmenu16,'Value',ResultStruct.Correcciones.FactorCampo);
        set(handles.edit6,'String',Variables.Fiduciales.FactorEscala);
        
    else%Abre desde ProgramaQA2 o blank desde QANews
        ResultStruct=struct;
        ResultStruct.InputIMG=[];
        ResultStruct.info=[];
        ResultStruct.angle=0;
        ResultStruct.NombreControl='X';
        ResultStruct.CodigoControl='X';
        ResultStruct.Crop=[];
        ResultStruct.Correcciones.Background='Ninguno';
        ResultStruct.Correcciones.Ganancia='Ninguna';
        ResultStruct.Correcciones.Calibracion='Ninguna';
        ResultStruct.Correcciones.FactorCampo='Ninguno';
        ResultStruct.perfiles.numero=0;
        ResultStruct.puntos.numero=0;
        ResultStruct.poligonos.numero=0;
        ResultStruct.circulos.numero=0;
        ResultStruct.expresiones='';
        Variables=struct;
        Fiduciales=[];
        r=struct;
        OrigenCoord.posicion=[0 0];
        R=[];
        S=[];
        T=[];
        cla %clear axis
        SelectedFunction='';
        
    end
catch
        ResultStruct=struct;%Abre desde ProgramaQA2
        ResultStruct.info=[];
        ResultStruct.angle=0;
        ResultStruct.NombreControl='X';
        ResultStruct.CodigoControl='X';
        ResultStruct.Crop=[];
        ResultStruct.Correcciones.Background='Ninguno';
        ResultStruct.Correcciones.Ganancia='Ninguna';
        ResultStruct.Correcciones.Calibracion='Ninguna';
        ResultStruct.Correcciones.FactorCampo='Ninguno';
        ResultStruct.perfiles.numero=0;
        ResultStruct.puntos.numero=0;
        ResultStruct.poligonos.numero=0;
        ResultStruct.circulos.numero=0;
        ResultStruct.expresiones='';
        Fiduciales=[];
        r=struct;
        OrigenCoord.posicion=[0 0];
        Variables=struct;
        Variables.Tolerancias='';
        R=[];
        S=[];
        T=[];
        cla %clear axis
        SelectedFunction='';
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
        








 
    



% --- Outputs from this function are returned to the command line.
function varargout = QADesign_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cargarImg.
function cargarImg_Callback(hObject, eventdata, handles)
global ResultStruct OutputIMG Fiduciales r OrigenCoord Variables R S T SelectedFunction;

%Reset
ResultStruct=struct;
ResultStruct.info=[];
ResultStruct.angle=0;
ResultStruct.NombreControl='X';
ResultStruct.CodigoControl='X';
ResultStruct.Crop=[];
ResultStruct.Correcciones.Background='Ninguno';
ResultStruct.Correcciones.Ganancia='Ninguna';
ResultStruct.Correcciones.Calibracion='Ninguna';
ResultStruct.Correcciones.FactorCampo='Ninguno';
ResultStruct.perfiles.numero=0;
ResultStruct.puntos.numero=0;
ResultStruct.poligonos.numero=0;
ResultStruct.circulos.numero=0;
ResultStruct.expresiones='';
Fiduciales=[];
r=struct;
Variables=struct;
Variables.Tolerancias='';
R=[];
S=[];
T=[];
cla %clear axis
SelectedFunction='';

[filename, pathname] = uigetfile('*.dcm');

try
infodicom = dicominfo([pathname, filename]);
img=double(dicomread([pathname, filename]));

handles.valorRot.String=num2str(0);
handles.valorRot.Value=0;

ResultStruct.InputIMG=img;
ResultStruct.info=infodicom;
if isfield(ResultStruct.info,'RescaleSlope')
    ResultStruct.InputIMG=ResultStruct.InputIMG.*ResultStruct.info.RescaleSlope+ResultStruct.info.RescaleIntercept;   
end
OutputIMG=ResultStruct.InputIMG;
ResultStruct.angle=0;
ResultStruct.NombreControl='X';
ResultStruct.CodigoControl='X';
x=size(ResultStruct.InputIMG(1,:));
x=x(2);
y=size(ResultStruct.InputIMG(:,1));
y=y(1);
ResultStruct.Crop=[1 1 x y];
ResultStruct.Correcciones.Background='Ninguno';
ResultStruct.Correcciones.Ganancia='Ninguna';
ResultStruct.Correcciones.Calibracion='Ninguna';
ResultStruct.Correcciones.FactorCampo='Ninguno';
ResultStruct.perfiles.numero=0;
ResultStruct.puntos.numero=0;
ResultStruct.poligonos.numero=0;
ResultStruct.circulos.numero=0;
ResultStruct.expresiones='';
if isfield(ResultStruct.info,'ImagerPixelSpacing')
    handles.edit6.String=ResultStruct.info.ImagerPixelSpacing(1);
elseif isfield(ResultStruct.info,'ImagePlanePixelSpacing')
    handles.edit6.String=ResultStruct.info.ImagePlanePixelSpacing(1);
end
R=[1 0;0 -1];
mm_pix=str2double(handles.edit6.String);
S=mm_pix;
T=[-round(length(OutputIMG(1,:))/2);round(length(OutputIMG(:,1))/2)]*S;
OrigenCoord.posicion=(inv(R)*(-T/S)).';
axes(handles.axes1);
IM=imshow(OutputIMG);
axis on;
impixelinfo
IM.ButtonDownFcn=@axes1_ButtonDownFcn;
AplicarCorrecciones
mostrarIMG(handles);
catch
    uiwait(errordlg('Archivo incompatible'));
end





% --- Executes on button press in preProcesado.
function preProcesado_Callback(hObject, eventdata, handles)
% hObject    handle to preProcesado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in definirFidu.
function definirFidu_Callback(hObject, eventdata, handles)

uiwait(Fantomas);
fcn = makeConstrainToRectFcn('impoint', xlim(handles.axes1), ylim(handles.axes1));
answer = questdlg('Indique el método de localización de fiduciales. ','','Automático','Manual','Automático');
if ~isempty(answer)
    switch answer
        case 'Automático'
            listo=0;
            while listo==0
    DeteccionAutoFidu
    DefinirOC
    try
    ActualizarInfoROIs
    actualizarResult
    catch
    end
    answer2 = questdlg('Aceptar fiduciales? ','','Sí','No','Sí');
    switch answer2
        case 'Sí'
            listo=1;
        case 'No'
            listo=0;
        case ''
            listo=1;
    end
            end
    
        case 'Manual'
    DeteccionManualFidu
    DefinirOC
        try
    ActualizarInfoROIs
    actualizarResult
    catch
    end
        case ''
    end
end



function DeteccionAutoFidu
global Fiduciales myhandles ResultStruct
prompt = {'Radio mínimo:','Radio máximo:','Sensibilidad [0-1]:','Umbral de borde [0-1]:'};
title = 'Parámetros búsqueda de círculos';
dims = [1 35];
definput = {'4','12','0.90','0.02'};
answer = inputdlg(prompt,title,dims,definput);
if isempty(answer)
    uiwait(warndlg('No se encontraron fiduciales. Se ubica el OC en el centro de la imagen.'))
    Fiduciales.A=[];
    Fiduciales.B=[];
    Fiduciales.C=[];
else
    Fiduciales.Parameters.Rmin=str2double(answer{1});
    Fiduciales.Parameters.Rmax=str2double(answer{2});
    Fiduciales.Parameters.Sensibilidad=str2double(answer{3});
    Fiduciales.Parameters.Umbral=str2double(answer{4});
[centers,radii] = imfindcircles(ResultStruct.InputIMG,[str2double(answer{1}) str2double(answer{2})],'ObjectPolarity','dark','Sensitivity',str2double(answer{3}),'EdgeThreshold',str2double(answer{4}));
if length(radii)>50
centers=[];
radii=[];
uiwait(warndlg('Se encontraron más de 50 círculos. Modifique los parámetros de detección.'));
end
Fiduciales.A=[];
Fiduciales.B=[];
Fiduciales.C=[];  

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

Fiduciales.A.posicion=A;
Fiduciales.B.posicion=B;
Fiduciales.C.posicion=C;

fcn = makeConstrainToRectFcn('impoint', xlim(myhandles.axes1), ylim(myhandles.axes1));

hA = impoint(myhandles.axes1,Fiduciales.A.posicion,'PositionConstraintFcn',fcn);
addNewPositionCallback(hA,@newposcb4);
setColor(hA,[0 1 0])
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.A.id=id;

hB = impoint(myhandles.axes1,Fiduciales.B.posicion,'PositionConstraintFcn',fcn);
addNewPositionCallback(hB,@newposcb4);
setColor(hB,[0 1 0])
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.B.id=id;

hC = impoint(myhandles.axes1,Fiduciales.C.posicion,'PositionConstraintFcn',fcn);
addNewPositionCallback(hC,@newposcb4);
setColor(hC,[0 1 0])
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.C.id=id;
catch
    uiwait(warndlg('No se encontraron fiduciales. Se ubica el OC en el centro de la imagen.'))
    Fiduciales.A=[];
    Fiduciales.B=[];
    Fiduciales.C=[];
end
end



function DeteccionManualFidu
global Fiduciales myhandles
        
uiwait(msgbox('Ubique los fiduciales en orden A, B y C.' ,'Ubicación de fiduciales')); 

fcn = makeConstrainToRectFcn('impoint', xlim(myhandles.axes1), ylim(myhandles.axes1));

h1 = impoint(myhandles.axes1,'PositionConstraintFcn',fcn);
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.A.id=id;
Fiduciales.A.posicion=getPosition(h1);
setColor(h1,[0 1 0]);
addNewPositionCallback(h1,@newposcb2);


h2 = impoint(myhandles.axes1,'PositionConstraintFcn',fcn);
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.B.id=id;
Fiduciales.B.posicion=getPosition(h2);
setColor(h2,[0 1 0]);
addNewPositionCallback(h2,@newposcb2);


h3 = impoint(myhandles.axes1,'PositionConstraintFcn',fcn);
id=get(myhandles.axes1,'children');
id=id(1);
Fiduciales.C.id=id;
Fiduciales.C.posicion=getPosition(h3);
setColor(h3,[0 1 0]);
addNewPositionCallback(h3,@newposcb2);

uiwait(msgbox('Fijar ubicación de fiduciales'));
addNewPositionCallback(h1,@newposcb3);
addNewPositionCallback(h2,@newposcb3);
addNewPositionCallback(h3,@newposcb3);







% --- Executes on button press in IndicToler.
function IndicToler_Callback(hObject, eventdata, handles)
TablaTolerancias



% --- Executes on button press in recortar.
function recortar_Callback(hObject, eventdata, handles)
global ResultStruct;
if handles.recortar.Value==1
   [I,ResultStruct.Crop]=imcrop(handles.figure1);
   if isempty(I)
       handles.recortar.Value=0;
   else
   handles.recortar.Value=0;    
   end 
end
AplicarCorrecciones
mostrarIMG(handles);
set(handles.recortar,'Visible','off');





function valorRot_Callback(hObject, eventdata, handles)
% hObject    handle to valorRot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valorRot as text
%        str2double(get(hObject,'String')) returns contents of valorRot as a double


% --- Executes during object creation, after setting all properties.
function valorRot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valorRot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotar.
function rotar_Callback(hObject, eventdata, handles)
global ResultStruct
handles.valorRot.Value=str2double(handles.valorRot.String);
ResultStruct.angle = handles.valorRot.Value;
AplicarCorrecciones
mostrarIMG(handles);
set(handles.recortar,'Visible','off');


% --- Executes on slider movement.
function sliderB_Callback(hObject, eventdata, handles)
global ResultStruct;
mostrarIMG(handles);
ResultStruct.Brillo=handles.sliderB.Value;


% --- Executes during object creation, after setting all properties.
function sliderB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderC_Callback(hObject, eventdata, handles)
mostrarIMG(handles);



% --- Executes during object creation, after setting all properties.
function sliderC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in perfil.
function perfil_Callback(hObject, eventdata, handles)
global ResultStruct; 
set(handles.checkbox2,'Value',0);
ResultStruct.perfiles.numero = ResultStruct.perfiles.numero + 1;
fcn = makeConstrainToRectFcn('imline', xlim(handles.axes1), ylim(handles.axes1));
h=imline(handles.axes1,'PositionConstraintFcn',fcn);
addNewPositionCallback(h,@newposcb);
id=get(handles.axes1,'children');
id=id(1);
xy=getPosition(h);
if (xy(1)==xy(2))&&(xy(3)==xy(4))
    delete(h);
else
ResultStruct.perfiles.(['P',num2str(ResultStruct.perfiles.numero)]).id=id;
ResultStruct.perfiles.(['P',num2str(ResultStruct.perfiles.numero)]).nombre={['P',num2str(ResultStruct.perfiles.numero)]};
ResultStruct.perfiles.(['P',num2str(ResultStruct.perfiles.numero)]).posicion=getPosition(h);

infoROIs(('perfiles'),(['P',num2str(ResultStruct.perfiles.numero)]));
actualizarResult

Transf_Pix2mm

filltables
plotPerfil
end



    
% --- Executes on button press in punto.    
function punto_Callback(hObject, eventdata, handles)
global ResultStruct;
set(handles.checkbox2,'Value',0);
ResultStruct.puntos.numero = ResultStruct.puntos.numero + 1;
fcn = makeConstrainToRectFcn('impoint', xlim(handles.axes1), ylim(handles.axes1));
h = impoint(handles.axes1,'PositionConstraintFcn',fcn);
addNewPositionCallback(h,@newposcb);
id=get(handles.axes1,'children');
id=id(1);
ResultStruct.puntos.(['p',num2str(ResultStruct.puntos.numero)]).id=id;
ResultStruct.puntos.(['p',num2str(ResultStruct.puntos.numero)]).nombre={['p',num2str(ResultStruct.puntos.numero)]};
ResultStruct.puntos.(['p',num2str(ResultStruct.puntos.numero)]).posicion=getPosition(h);

infoROIs(('puntos'),(['p',num2str(ResultStruct.puntos.numero)]));
actualizarResult
Transf_Pix2mm
filltables



 

% --- Executes on button press in rectangulo.
function rectangulo_Callback(hObject, eventdata, handles)
global ResultStruct;
set(handles.checkbox2,'Value',0);
ResultStruct.poligonos.numero = ResultStruct.poligonos.numero + 1;
fcn = makeConstrainToRectFcn('impoly', xlim(handles.axes1), ylim(handles.axes1));
h = impoly(handles.axes1,'PositionConstraintFcn',fcn);
addNewPositionCallback(h,@newposcb);
id=get(handles.axes1,'children');
id=id(1);
xy=getPosition(h);

ResultStruct.poligonos.(['R',num2str(ResultStruct.poligonos.numero)]).id=id;
ResultStruct.poligonos.(['R',num2str(ResultStruct.poligonos.numero)]).nombre={['R',num2str(ResultStruct.poligonos.numero)]};
ResultStruct.poligonos.(['R',num2str(ResultStruct.poligonos.numero)]).posicion=getPosition(h);

infoROIs(('poligonos'),(['R',num2str(ResultStruct.poligonos.numero)]));
actualizarResult
Transf_Pix2mm
filltables
plotSurf


% --- Executes on button press in elipse.
function elipse_Callback(hObject, eventdata, handles)
global ResultStruct;
set(handles.checkbox2,'Value',0);
ResultStruct.circulos.numero = ResultStruct.circulos.numero + 1;
fcn = makeConstrainToRectFcn('imellipse', xlim(handles.axes1), ylim(handles.axes1));
h = imellipse(handles.axes1,[500 500 100 100],'PositionConstraintFcn',fcn);
setFixedAspectRatioMode(h,true);
addNewPositionCallback(h,@newposcb);
id=get(handles.axes1,'children');
id=id(1);
xy=getPosition(h);
if (xy(3)==0)||(xy(4)==0)
    delete(h);
else
ResultStruct.circulos.(['C',num2str(ResultStruct.circulos.numero)]).id=id;
ResultStruct.circulos.(['C',num2str(ResultStruct.circulos.numero)]).nombre={['C',num2str(ResultStruct.circulos.numero)]};
ResultStruct.circulos.(['C',num2str(ResultStruct.circulos.numero)]).posicion=getPosition(h);

infoROIs(('circulos'),(['C',num2str(ResultStruct.circulos.numero)]));
actualizarResult
Transf_Pix2mm
filltables
plotSurf

end


% --- Executes when uipanel2 is resized.
function uipanel2_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function newposcb(pos)
global ResultStruct

fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4;
    fn2=fieldnames(ResultStruct.(char(fn1(j))));
for i=2:numel(fn2);
    for k=1:length(ResultStruct.(char(fn1(j))).(char(fn2(i))).id.Children)
            if (ResultStruct.(char(fn1(j))).(char(fn2(i))).id.Children(k)==gco)||(ResultStruct.(char(fn1(j))).(char(fn2(i))).id==gco);
                ResultStruct.(char(fn1(j))).(char(fn2(i))).posicion=pos;
                infoROIs(fn1(j),fn2(i));
            end
    end
end
end

Transf_Pix2mm
filltables
plotPerfil
plotSurf
actualizarResult

function newposcb2(pos)
global Fiduciales

fn=fieldnames(Fiduciales);
for i=4:numel(fn);
    if (Fiduciales.(char(fn(i))).id.Children(1)==gco)||(Fiduciales.(char(fn(i))).id.Children(2)==gco);
        Fiduciales.(char(fn(i))).posicion=pos;
    end
end

function newposcb3(pos)
global Fiduciales
h=gco;
fn=fieldnames(Fiduciales);
for i=4:numel(fn);
    if (Fiduciales.(char(fn(i))).id==gco);
        set(h.Children(1),'XData',Fiduciales.(char(fn(i))).posicion(1));
        set(h.Children(2),'XData',Fiduciales.(char(fn(i))).posicion(1));
        set(h.Children(1),'YData',Fiduciales.(char(fn(i))).posicion(2));
        set(h.Children(2),'YData',Fiduciales.(char(fn(i))).posicion(2));       
    end
end

function newposcb4(pos)
global OrigenCoord
h=gco;
set(h.Children(1),'XData',OrigenCoord.posicion(1));
set(h.Children(2),'XData',OrigenCoord.posicion(1));
set(h.Children(1),'YData',OrigenCoord.posicion(2));
set(h.Children(2),'YData',OrigenCoord.posicion(2));       




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
set(handles.uipanel8,'Visible','off');
set(handles.uipanel18,'Visible','off');
set(handles.uipanel20,'Visible','off');
set(handles.uipanel12,'Visible','on');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.uipanel8,'Visible','off');
set(handles.uipanel18,'Visible','on');
set(handles.uipanel20,'Visible','on');
set(handles.uipanel12,'Visible','off');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.uipanel8,'Visible','on');
set(handles.uipanel18,'Visible','off');
set(handles.uipanel20,'Visible','off');
set(handles.uipanel12,'Visible','off');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

function mostrarIMG(handles)
global zoomIMG OutputIMG ResultStruct

handles.text15.String=[ResultStruct.info.PatientName.FamilyName,'-',ResultStruct.info.PatientID];
handles.text16.String=datestr(datetime([ResultStruct.info.ContentDate,ResultStruct.info.ContentTime(1:6)],'InputFormat','yyyyMMddHHmmSS', 'Format' ,'dd-MMMM-yyyy HH:mm:ss'));

newimg=OutputIMG/max(max(max(OutputIMG)));

tipo=handles.popupmenu2.Value;
size=handles.popupmenu3.Value;
iteraciones=str2double(handles.popupmenu4.String);
iteraciones=iteraciones(handles.popupmenu4.Value);

switch tipo
        case 1;
                mascara=1;
        case 2;
                mascara=ones(size,size);
                mascara=mascara/numel(mascara);
        case 3;
                mascara=-ones(size,size);
                mascara(ceil(size/2),ceil(size/2))=numel(mascara)+1;
    end


for i=1:iteraciones;
    newimg=filter2(mascara,newimg);
end

slope = handles.sliderC.Value;
intercept = handles.sliderB.Value;
newimg = newimg * slope + intercept;
newimg(newimg<0)=0;
newimg(newimg>1)=1;



axes(handles.axes1)
imshow(newimg);
colmap=get(handles.popupmenu7,'string');
colmap=char(colmap(get(handles.popupmenu7,'value')));
colormap(strtrim(colmap));
set(handles.axes1,'XTickLabel',[])
set(handles.axes1,'YTickLabel',[])
zoomIMG=newimg;

if get(handles.checkbox1,'value')==1;
    grid on
else
    grid off
end
axis on;
impixelinfo
RedibujarROIs
        


function filltables
global ResultStruct myhandles R S T
colergen = @(color,text) ['<html><table border=0 width=800 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
a=1;
datos(1,1)={''};
fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4;
    fn2=fieldnames(ResultStruct.(char(fn1(j))));
for i=2:numel(fn2);
    datos(a,1)=ResultStruct.(char(fn1(j))).(char(fn2(i))).nombre;
    try
    Color=get(ResultStruct.(char(fn1(j))).(char(fn2(i))).id.Children(1),'Color');
    catch
    Color=get(ResultStruct.(char(fn1(j))).(char(fn2(i))).id.Children(end-1),'Color');   
    end
    Red=dec2hex(Color(1)*255);
    if numel(Red)<2
        Red=strcat('0',Red);
    end
    Green=dec2hex(Color(2)*255);
    if numel(Green)<2
        Green=strcat('0',Green);
    end
    Blue=dec2hex(Color(3)*255);
    if numel(Blue)<2
        Blue=strcat('0',Blue);
    end
    datos(a,2)={colergen(strcat('#',Red,Green,Blue),'')};
    
    if ~isempty(R)
    Posicion=round(ResultStruct.(char(fn1(j))).(char(fn2(i))).posicion_mm,1);
    else
    Posicion=round(ResultStruct.(char(fn1(j))).(char(fn2(i))).posicion);
    end
    if strcmp(char(fn1(j)),'perfiles')|| strcmp(char(fn1(j)),'poligonos')
    Posicion=Posicion(:)';
    end
    Posicion=num2str(Posicion);
    datos(a,3)={Posicion};
    a=a+1;  
end
end
try
set(myhandles.uitable1,'data',datos)
catch
end

llenarpopup
    
    
    
    


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
global ResultStruct gcoOld ColorOld zoomIMG OutputIMG;

try
try
    cursorPOS=get(handles.axes1,'CurrentPoint');
try
    s=size(OutputIMG);
catch
    s=[1 1];
end
if ((s(1)>1) && (get(handles.checkbox2,'value')==1));
try
zoomPixSize=50;
y=round(cursorPOS(1,2));
x=round(cursorPOS(1,1));
s=size(zoomIMG);
x1=round(x-zoomPixSize);
if x1<1; x1=1; 
end
x2=round(x+zoomPixSize);
if x2>s(2); x2=s(2); end

y1=round(y-zoomPixSize);
if y1<1; y1=1; 
end
y2=round(y+zoomPixSize);
if y2>s(1); y2=s(1); end


cutIMG=zoomIMG(y1:y2,x1:x2);
axes(handles.axes3)
imshow(cutIMG)
if isempty(cutIMG)
else
colmap=get(handles.popupmenu7,'string');
colmap=char(colmap(get(handles.popupmenu7,'value')));
colormap(strtrim(colmap));
end
catch
end
set(handles.axes1,'XTickLabel',[])
set(handles.axes1,'YTickLabel',[])
end
catch
end



if gco==gcoOld;
elseif isempty(fieldnames(ResultStruct));
elseif (strcmp(class(gco),'matlab.graphics.primitive.Line'))||(strcmp(class(gco),'matlab.graphics.primitive.Patch'))||(strcmp(class(gco),'matlab.graphics.primitive.Group'))
    switch class(gcoOld);
        case 'matlab.graphics.primitive.Line';
            try
                 h=gcoOld;
                 h=h.Parent;
                 for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                 end
            catch
            end
        case 'matlab.graphics.primitive.Patch';
            try
                h=gcoOld;
                 h=h.Parent;
                 for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                 end
            catch
            end
        case 'matlab.graphics.primitive.Group';
            try
                h=gcoOld;
                h=h.Parent;
                 for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                 end
            catch
            end
    end
            
    switch class(gco);
        case 'matlab.graphics.primitive.Line';
            h=gco;
            h=h.Parent;
            for i=1:length(h.Children)
                try
            ColorOld(i,:)=get(h.Children(i),'Color');
                catch
                end
            end
            for i=1:length(h.Children)
                try
            set(h.Children(i),'Color',[1 0 0]);
             catch
                end
            end
            gcoOld=gco;
            if length(h.Children)==4;
            plotPerfil
            else
                plotSurf
            end
            
        case 'matlab.graphics.primitive.Patch';
             h=gco;
            h=h.Parent;
            for i=1:length(h.Children)
                try
            ColorOld(i,:)=get(h.Children(i),'Color');
                catch
                end
            end
            for i=1:length(h.Children)
                try
            set(h.Children(i),'Color',[1 0 0]);
             catch
                end
            end
            gcoOld=gco;
            plotSurf
            
                case 'matlab.graphics.primitive.Group';
            h=gco;
            h=h.Parent;
            for i=1:length(h.Children)
                try
            ColorOld(i,:)=get(h.Children(i),'Color');
                catch
                end
            end
            for i=1:length(h.Children)
                try
            set(h.Children(i),'Color',[1 0 0]);
             catch
                end
            end
            gcoOld=gco;
            plotSurf
            
    end
try
filltables
catch
end
else
end


catch
end



            


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
global ResultStruct myhandles
datos=get(myhandles.uitable1,'data');
a=1;
fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4;
    fn2=fieldnames(ResultStruct.(char(fn1(j))));
for i=2:numel(fn2);
    ResultStruct.(char(fn1(j))).(char(fn2(i))).nombre=datos(a,1);
    a=a+1;  
end
end
actualizarResult
llenarpopup


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
mostrarIMG(handles);


function RedibujarROIs
global ResultStruct myhandles OrigenCoord Fiduciales
axes(myhandles.axes1)

try
    try
delete(Fiduciales.A.id)
    catch
    end
h=impoint(myhandles.axes1,[Fiduciales.A.posicion(1) Fiduciales.A.posicion(2)]);
setColor(h,[0 1 0]);
id=get(myhandles.axes1,'children');
id=id(1);
addNewPositionCallback(h,@newposcb2);
Fiduciales.A.id=id;
try
delete(Fiduciales.B.id)
catch
end
h=impoint(myhandles.axes1,[Fiduciales.B.posicion(1) Fiduciales.B.posicion(2)]);
setColor(h,[0 1 0]);
id=get(myhandles.axes1,'children');
id=id(1);
addNewPositionCallback(h,@newposcb2);
Fiduciales.B.id=id;
try
delete(Fiduciales.C.id)
catch
end
h=impoint(myhandles.axes1,[Fiduciales.C.posicion(1) Fiduciales.C.posicion(2)]);
setColor(h,[0 1 0]);
id=get(myhandles.axes1,'children');
id=id(1);
addNewPositionCallback(h,@newposcb2);
Fiduciales.C.id=id;
catch
end

try
h=impoint(myhandles.axes1,[OrigenCoord.posicion(1) OrigenCoord.posicion(2)]);
setColor(h,[0 0 0]);
addNewPositionCallback(h,@newposcb4);
id=get(myhandles.axes1,'children');
id=id(1);
OrigenCoord.id=id;
catch
end


fn=fieldnames(ResultStruct.perfiles);
if numel(fn)>1;
    for i=2:numel(fn);
        try
        delete(ResultStruct.perfiles.(char(fn(i))).id)
        catch
        end
        h=imline(myhandles.axes1,ResultStruct.perfiles.(char(fn(i))).posicion);
        addNewPositionCallback(h,@newposcb);
        id=get(myhandles.axes1,'children');
        id=id(1);
        ResultStruct.perfiles.(char(fn(i))).id=id;       
    end
    
end

fn=fieldnames(ResultStruct.puntos);
if numel(fn)>1;
    for i=2:numel(fn);
        try
        delete(ResultStruct.puntos.(char(fn(i))).id)
        catch
        end
        h=impoint(myhandles.axes1,ResultStruct.puntos.(char(fn(i))).posicion);
        addNewPositionCallback(h,@newposcb);
        id=get(myhandles.axes1,'children');
        id=id(1);
        ResultStruct.puntos.(char(fn(i))).id=id;
    end
end

fn=fieldnames(ResultStruct.poligonos);
if numel(fn)>1;
    for i=2:numel(fn);
        try
        delete(ResultStruct.poligonos.(char(fn(i))).id)
        catch
        end
        h=impoly(myhandles.axes1,ResultStruct.poligonos.(char(fn(i))).posicion);
        setColor(h,'green');
        addNewPositionCallback(h,@newposcb);
        id=get(myhandles.axes1,'children');
        id=id(1);
        ResultStruct.poligonos.(char(fn(i))).id=id;       
    end
    
end

fn=fieldnames(ResultStruct.circulos);
if numel(fn)>1;
    for i=2:numel(fn);
        try
        delete(ResultStruct.circulos.(char(fn(i))).id)
        catch
        end
        h=imellipse(myhandles.axes1,ResultStruct.circulos.(char(fn(i))).posicion);
        setFixedAspectRatioMode(h,true);
        addNewPositionCallback(h,@newposcb);
        id=get(myhandles.axes1,'children');
        id=id(1);
        ResultStruct.circulos.(char(fn(i))).id=id;
    end
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
global selectedROInumber ResultStruct selectedROIalias selectedROIaliasOld selectedROItype;
%if strcmp(selectedROIalias{1},selectedROIaliasOld{1})
%else
%try
fn=fieldnames(ResultStruct.perfiles);
numero1=numel(fn)-1;
fn=fieldnames(ResultStruct.puntos);
numero2=numero1+numel(fn)-1;
fn=fieldnames(ResultStruct.poligonos);
numero3=numero2+numel(fn)-1;
fn=fieldnames(ResultStruct.circulos);
numero4=numero3+numel(fn)-1;

if selectedROInumber<=numero1;
    selectedROItype='perfiles';
    numero=selectedROInumber;
elseif (numero1<selectedROInumber)&&(selectedROInumber<=numero2)
    selectedROItype='puntos';
    numero=selectedROInumber-numero1;
elseif (numero2<selectedROInumber)&&(selectedROInumber<=numero3)
    selectedROItype='poligonos';
    numero=selectedROInumber-numero2;
elseif (numero3<selectedROInumber)&&(selectedROInumber<=numero4)
    selectedROItype='circulos';   
    numero=selectedROInumber-numero3;
end

fn=fieldnames(ResultStruct.(selectedROItype));
borrar=fn(numero+1);
ResultStruct.(selectedROItype)=rmfield(ResultStruct.(selectedROItype),borrar);

%catch
%end
filltables
mostrarIMG(handles);
RedibujarROIs
selectedROIaliasOld=selectedROIalias;
actualizarResult
llenarpopup
%end




function DefinirOC
global OrigenCoord Fiduciales R S T myhandles OutputIMG
%Ángulo ai=AB con x imagen
%Ángulo ar=AB con x retículo (=0)
%Ángulo bi=BC con x imagen
%Ángulo br=BC con x retículo (=0)
%Ángulo ci=CA con x imagen
%Ángulo cr=CA con x retículo (=0)
%Ángulo ri=x retículo con x imagen
try
Am=[Fiduciales.Am.posicion(1); Fiduciales.Am.posicion(2)];
Bm=[Fiduciales.Bm.posicion(1); Fiduciales.Bm.posicion(2)];
Cm=[Fiduciales.Cm.posicion(1); Fiduciales.Cm.posicion(2)];
A=[Fiduciales.A.posicion(1); Fiduciales.A.posicion(2)];
B=[Fiduciales.B.posicion(1); Fiduciales.B.posicion(2)];
C=[Fiduciales.C.posicion(1); Fiduciales.C.posicion(2)];

dx_AB=B(1)-A(1);
dy_AB=B(2)-A(2);
dx_BC=C(1)-B(1);
dy_BC=C(2)-B(2);
dx_CA=A(1)-C(1);
dy_CA=A(2)-C(2);
AB=sqrt(dx_AB^2+dy_AB^2);
BC=sqrt(dx_BC^2+dy_BC^2);
CA=sqrt(dx_CA^2+dy_CA^2);
dx_ABm=Bm(1)-Am(1);
dy_ABm=Bm(2)-Am(2);
dx_BCm=Cm(1)-Bm(1);
dy_BCm=Cm(2)-Bm(2);
dx_CAm=Am(1)-Cm(1);
dy_CAm=Am(2)-Cm(2);
ABm=sqrt(dx_ABm^2+dy_ABm^2);
BCm=sqrt(dx_BCm^2+dy_BCm^2);
CAm=sqrt(dx_CAm^2+dy_CAm^2);

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
R=Rx*Ry*Rz;
S=mean([ABm/AB BCm/BC CAm/CA]);
Ta=Am-(S*(R*A));
Tb=Bm-(S*(R*B));
Tc=Cm-(S*(R*C));
T=[mean([Ta(1) Tb(1) Tc(1)]); mean([Ta(2) Tb(2) Tc(2)])];
catch
    R=[1 0;0 -1];
    mm_pix=str2double(myhandles.edit6.String);
    if isscalar(mm_pix)
    S=mm_pix;
    else
        uiwait(errordlg('Ingrese un escalar como factor de escala.'))
    end
    T=[-round(length(OutputIMG(1,:))/2);round(length(OutputIMG(:,1))/2)]*S;
    OrigenCoord.posicion=(inv(R)*(-T/S)).';
    Fiduciales.A=[];
    Fiduciales.B=[];
    Fiduciales.C=[];    
end
OrigenCoord.posicion=round((inv(R)*(-T/S))).';

fcn = makeConstrainToRectFcn('impoint', xlim(myhandles.axes1), ylim(myhandles.axes1));
h = impoint(myhandles.axes1,OrigenCoord.posicion,'PositionConstraintFcn',fcn);
addNewPositionCallback(h,@newposcb4);
setColor(h,[0 0 0])
id=get(myhandles.axes1,'children');
id=id(1);
OrigenCoord.id=id;
myhandles.edit6.String=num2str(S);
Transf_mm2Pix
RedibujarROIs
ActualizarInfoROIs
filltables
filltables2





% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
global ResultStruct
contents=cellstr(get(hObject,'String'));
file=contents{get(hObject,'Value')};
ResultStruct.Correcciones.Background=file;
AplicarCorrecciones
mostrarIMG(handles);
filltables
actualizarResult



% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
global ResultStruct
contents=cellstr(get(hObject,'String'));
file=contents{get(hObject,'Value')};
ResultStruct.Correcciones.Calibracion=file;
AplicarCorrecciones
mostrarIMG(handles);
filltables
actualizarResult


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
mostrarIMG(handles);



% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
mostrarIMG(handles);


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
mostrarIMG(handles);


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotPerfil
global ResultStruct myhandles selectedROItype selectedROIname OutputIMG;
objactual=gco; 
try
if strcmp(selectedROItype,'perfiles')
   pos=ResultStruct.(selectedROItype).(selectedROIname{1}).posicion;
   dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
dx=(pos(2,1)-pos(1,1));
dy=(pos(2,2)-pos(1,2));
u=[dx dy]/dist;
perfil=zeros(1,round(dist));
for dr=0:round(dist);
    coord=round(pos(1,:)+(u*dr));
    perfil(dr+1)=OutputIMG(coord(2),coord(1));
end
axes(myhandles.axes2)
plot(perfil)
grid on

elseif isa(objactual,'matlab.graphics.primitive.Line')
fn=fieldnames(ResultStruct.perfiles);
try
if numel(fn)>1
    for i=2:numel(fn)
         if ResultStruct.perfiles.(char(fn(i))).id==objactual.Parent;
             pos=ResultStruct.perfiles.(char(fn(i))).posicion;
         end
    end
     
dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
dx=(pos(2,1)-pos(1,1));
dy=(pos(2,2)-pos(1,2));
u=[dx dy]/dist;
perfil=zeros(1,round(dist));
for dr=0:round(dist);
    coord=round(pos(1,:)+(u*dr));
    perfil(dr+1)=OutputIMG(coord(2),coord(1));
end
axes(myhandles.axes2)
plot(perfil)
grid on
end
catch
end
 
end
catch
end


function plotSurf
global ResultStruct myhandles selectedROItype selectedROIname OutputIMG;
objactual=gco; 
try
if strcmp(selectedROItype,'poligonos')

axes(myhandles.axes2)
surf(ResultStruct.(selectedROItype).(selectedROIname{1}).datos), shading interp
grid on

elseif strcmp(selectedROItype,'circulos')
    
    pos=ResultStruct.(selectedROItype).(selectedROIname{1}).posicion;
    datos=OutputIMG(round(pos(2)):round((pos(2)+pos(4))),round(pos(1)):round((pos(1)+pos(3))));
    for x=round(pos(1)):round((pos(1)+pos(3)))
        for y=round(pos(2)):round((pos(2)+pos(4)))
    if (((x-(pos(1)+(pos(3)/2)))^2)/((pos(3)/2)^2) + ((y-(pos(2)+(pos(4)/2)))^2)/((pos(4)/2)^2))>1
        datos(abs(y-round(pos(2)))+1,abs(x-round(pos(1)))+1)=NaN;
    end
        end
    end
axes(myhandles.axes2)
surf(datos), shading interp
grid on

elseif isa(objactual,'matlab.graphics.primitive.Line')
fn=fieldnames(ResultStruct.poligonos);
try
if numel(fn)>1
    for i=2:numel(fn)
         if ResultStruct.poligonos.(char(fn(i))).id==objactual.Parent;
             datos=ResultStruct.poligonos.(char(fn(i))).datos;
         end
    end
     
axes(myhandles.axes2)
surf(datos), shading interp
grid on
end
catch
end

elseif isa(objactual,'matlab.graphics.primitive.Patch')
fn=fieldnames(ResultStruct.poligonos);
try
if numel(fn)>1
    for i=2:numel(fn)
         if ResultStruct.poligonos.(char(fn(i))).id==objactual.Parent;
             datos=ResultStruct.poligonos.(char(fn(i))).datos;
         end
    end
     
axes(myhandles.axes2)
surf(datos), shading interp
grid on
end
catch
end

fn=fieldnames(ResultStruct.circulos);
try
if numel(fn)>1
    for i=2:numel(fn)
         if ResultStruct.circulos.(char(fn(i))).id==objactual.Parent;
         pos=ResultStruct.circulos.(char(fn(i))).posicion;
    datos=OutputIMG(round(pos(2)):round((pos(2)+pos(4))),round(pos(1)):round((pos(1)+pos(3))));
    for x=round(pos(1)):round((pos(1)+pos(3)))
        for y=round(pos(2)):round((pos(2)+pos(4)))
    if (((x-(pos(1)+(pos(3)/2)))^2)/((pos(3)/2)^2) + ((y-(pos(2)+(pos(4)/2)))^2)/((pos(4)/2)^2))>1
        datos(abs(y-round(pos(2)))+1,abs(x-round(pos(1)))+1)=NaN;
    end
        end
    end
         end
    end
     
axes(myhandles.axes2)
surf(datos), shading interp
grid on
end
catch
end
    
end
catch
end




function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
function figure1_ButtonDownFcn(hObject, eventdata, handles)

function axes1_ButtonDownFcn(hObject, eventdata, handles)


% --- Executes during object deletion, before destroying properties.
function axes1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
global selectedROInumber selectedROIalias selectedROItype selectedROIname ResultStruct ColorOld gcoOld
colergen = @(color,text) ['<html><table border=0 width=800 bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
TableData = get(handles.uitable1, 'data');

try
selectedROInumber=eventdata.Indices(1);
selectedROIalias=TableData(selectedROInumber,1);
catch
end

try
 fn=fieldnames(ResultStruct.perfiles);
 numero1=numel(fn)-1;
 fn=fieldnames(ResultStruct.puntos);
 numero2=numero1+numel(fn)-1;
 fn=fieldnames(ResultStruct.poligonos);
 numero3=numero2+numel(fn)-1;
 fn=fieldnames(ResultStruct.circulos);
 numero4=numero3+numel(fn)-1;
 
 if selectedROInumber<=numero1;
     selectedROItype='perfiles';
     numero=selectedROInumber;
 elseif (numero1<selectedROInumber)&&(selectedROInumber<=numero2)
     selectedROItype='puntos';
     numero=selectedROInumber-numero1;
 elseif (numero2<selectedROInumber)&&(selectedROInumber<=numero3)
     selectedROItype='poligonos';
     numero=selectedROInumber- numero2;
 elseif (numero3<selectedROInumber)&&(selectedROInumber<=numero4)
     selectedROItype='circulos';   
     numero=selectedROInumber-numero3;
 end
 
 fn=fieldnames(ResultStruct.(selectedROItype));
selectedROIname=fn(numero+1);
 
 switch class(gcoOld);
        case 'matlab.graphics.primitive.Line';
            
                 h=gcoOld;
                 h=h.Parent;
                 
                 if ResultStruct.(selectedROItype).(selectedROIname{1}).id==h;
                 else
                    for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                     end
               for i=1:length(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children);    
                   try
               ColorOld(i,:)=get(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color');
               set(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color',[1 0 0]);  
                   catch
                   end
               end
                gcoOld=ResultStruct.(selectedROItype).(selectedROIname{1}).id;
                 filltables
                 plotPerfil
                 plotSurf
                end    
                 
            
            
        case 'matlab.graphics.primitive.Patch';
           
                h=gcoOld;
                 h=h.Parent;
                 if ResultStruct.(selectedROItype).(selectedROIname{1}).id==h;
                 else
                    for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                     end
               for i=1:length(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children);  
                try
               ColorOld(i,:)=get(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color');
               set(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color',[1 0 0]); 
                catch
                end
               end
   gcoOld=ResultStruct.(selectedROItype).(selectedROIname{1}).id;
   filltables
   plotPerfil
   plotSurf
                 end 
                
          
        case 'matlab.graphics.primitive.Group';
            
                h=gcoOld;
                if ResultStruct.(selectedROItype).(selectedROIname{1}).id==h;
                 else
                    for i=1:length(h.Children);
                     try
                set(h.Children(i),'Color',ColorOld(i,:));
                     catch
                     end
                     end
               for i=1:length(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children);
                   try
               ColorOld(i,:)=get(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color');
               set(ResultStruct.(selectedROItype).(selectedROIname{1}).id.Children(i),'Color',[1 0 0]);  
                   catch
                   end
               end
                               gcoOld=ResultStruct.(selectedROItype).(selectedROIname{1}).id;
                               filltables
                               plotPerfil
                               plotSurf
   
                end 

            
    end
 

catch
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
global ResultStruct r R S T
actualizarResult
evaluar=get(handles.edit2,'String');
resultado=get(handles.edit3,'String');
index1=strfind(evaluar,'=');
r_old=r;
if ~isempty(index1)
    if evaluar(index1(1)+1)~='=';
index2=strfind(evaluar,'[');
index3=strfind(evaluar,']');
intstr=evaluar((index2+1):(index3-1));
arguma=(intstr==' ');
argumb=(intstr==',');
argum1=~(arguma+argumb);
ant_ch=0;
numelem=0;
for i=1:length(argum1)
    if((argum1(i)==1)&&(ant_ch==0))
        numelem=numelem+1;
    end
    ant_ch=argum1(i);
end
try
eval(evaluar);
if ((length(fieldnames(r))-numelem)==(length(fieldnames(r_old))))
    strn = regexprep(intstr(argum1),'[.]','');
    ResultStruct.expresiones.(strn)=evaluar;
else
   uiwait(errordlg('Falta escribir r. en',num2str(numelem-(length(fieldnames(r))-length(fieldnames(r_old)))),'salida(s).'));
    r=r_old;
end
catch
 uiwait(errordlg('Input incompatible.'));   
end

    else
if isempty(resultado)
    uiwait(errordlg('Indique un nombre para el resultado.'));
else
    if isempty(evaluar)
    uiwait(errordlg('Indique el cálculo a relaizar'))
    else
        try    
        r.(resultado)=eval(evaluar);
        ResultStruct.expresiones.(resultado)=evaluar;
        set(handles.edit3,'String','');
        catch
               uiwait(errordlg('Input incompatible.'));
        end
    end

end
    end
    
    
else
     
if isempty(resultado)
    uiwait(errordlg('Indique un nombre para el resultado.'));
else
    if isempty(evaluar)
    uiwait(errordlg('Indique el cálculo a relaizar'))
    else
        try
            r.(resultado)=eval(evaluar);
        ResultStruct.expresiones.(resultado)=evaluar;
        set(handles.edit3,'String','');
        catch
       uiwait(errordlg('Input incompatible.'));
end
    end
end


end
filltables2




function filltables2
global r myhandles
a=1;
fn=fieldnames(r);
for i=primerResultado:numel(fn)
    datos(a,1)={char(fn(i))};
    sz=size(r.(char(fn(i))));    
    if (sz(1)==1)&&(sz(2)==1)
        datos(a,2)={num2str(round(r.(char(fn(i))),1))};
    else
        datos(a,2)={num2str([num2str(sz(1)) 'x' num2str(sz(2)) ' ' 'double'])};
    end
    a=a+1;
end
try
set(myhandles.uitable3,'Data',datos);
catch
    datos={''};
    set(myhandles.uitable3,'Data',datos);
end
llenarpopup

function y=primerResultado
global ResultStruct
fn1=fieldnames(ResultStruct.perfiles);
n1=(numel(fn1)-1)*2;
fn2=fieldnames(ResultStruct.puntos);
n2=(numel(fn2)-1)*2;
fn3=fieldnames(ResultStruct.poligonos);
n3=(numel(fn3)-1)*3;
fn4=fieldnames(ResultStruct.circulos);
n4=(numel(fn4)-1)*3;
y=n1+n2+n3+n4+1;


function load_r
global ResultStruct r
fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
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


function llenarpopup
global r myhandles


fn=fieldnames(r);
for i=1:numel(fn)
    rois(i,:)=fn(i);
end

rois(i+1,:)={''};

try
myhandles.popupmenu9.String=rois;
myhandles.popupmenu12.String=rois;
catch
end


  
       
        






function infoROIs(tipo,ROI)
global ResultStruct OutputIMG
try

if  strcmp(char(tipo),'perfiles')
    pos=ResultStruct.(char(tipo)).(char(ROI)).posicion;
    dist=sqrt((pos(2,1)-pos(1,1))^2+(pos(2,2)-pos(1,2))^2);
    dx=(pos(2,1)-pos(1,1));
    dy=(pos(2,2)-pos(1,2));
    u=[dx dy]/dist;
    perfil=zeros(1,round(dist));
for dr=0:round(dist);
    coord=round(pos(1,:)+(u*dr));
    perfil(dr+1)=OutputIMG(coord(2),coord(1));
end
ResultStruct.(char(tipo)).(char(ROI)).datos=perfil;



elseif strcmp(char(tipo),'puntos')
    pos=ResultStruct.(char(tipo)).(char(ROI)).posicion;
    valor_p=OutputIMG(round(pos(2)),round(pos(1)));
    ResultStruct.(char(tipo)).(char(ROI)).datos=valor_p;

elseif strcmp(char(tipo),'poligonos')
    pos=ResultStruct.(char(tipo)).(char(ROI)).posicion;
    [x2,y2,BW,xi2,yi2] = roipoly(OutputIMG,pos(:,1),pos(:,2));
    valor_r=OutputIMG(y2(1):y2(2),x2(1):x2(2));
    valor_r(BW==0)=NaN;
    ResultStruct.(char(tipo)).(char(ROI)).datos=valor_r;
    area_r=polyarea(pos(:,1),pos(:,2));
    ResultStruct.(char(tipo)).(char(ROI)).area=area_r;

elseif strcmp(char(tipo),'circulos')
    pos=ResultStruct.(char(tipo)).(char(ROI)).posicion;
    pix=1;
    for x=round(pos(1)):round((pos(1)+pos(3)))
        for y=round(pos(2)):round((pos(2)+pos(4)))
    if (((x-(pos(1)+(pos(3)/2)))^2)/((pos(3)/2)^2) + ((y-(pos(2)+(pos(4)/2)))^2)/((pos(4)/2)^2))<=1
        valor_e(pix)=OutputIMG(round(y),round(x));
        pix=pix+1;
    end
        end
    end
    ResultStruct.(char(tipo)).(char(ROI)).datos=valor_e;
    area_e=pi*round((pos(3)/2)*(pos(4)/2));
    ResultStruct.(char(tipo)).(char(ROI)).area=area_e;

end
catch
end
    
    
    


% --- Executes when selected cell(s) is changed in uitable3.
function uitable3_CellSelectionCallback(hObject, eventdata, handles)




% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
uiwait(EliminarCalculo)
actualizarResult
filltables2






% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
mostrarIMG(handles);


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
set(handles.uipanel8,'Visible','off');
set(handles.uipanel18,'Visible','on');
set(handles.uipanel20,'Visible','on');
set(handles.uipanel12,'Visible','off');


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
set(handles.uipanel8,'Visible','off');
set(handles.uipanel18,'Visible','on');
set(handles.uipanel20,'Visible','off');
set(handles.uipanel12,'Visible','off');



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


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)




% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
global ResultStruct r

pop1str={'','mean','median','min','max'};
pop1=pop1str{get(handles.popupmenu8,'Value')};
pop2=get(handles.popupmenu9,'Value');
pop3str={'+','-','*','/','+'};
pop3=pop3str{get(handles.popupmenu10,'Value')};
pop4str={'','mean','median','min','max'};
pop4=pop4str{get(handles.popupmenu11,'Value')};
pop5=get(handles.popupmenu12,'Value');

pop2val=0;
pop5val=0;
poproi2='0';
poproi5='0';

k=1;
try
fn=fieldnames(r);
for i=1:numel(fn)
    if k==pop2;
            pop2val=r.(char(fn(i)));
            poproi2=['r.',fn{i}];
    end
    if k==pop5;
            pop5val=r.(char(fn(i)));
            poproi5=['r.',fn{i}];
    end
    k=k+1;
end
catch
end

evaluar=([pop1,'(','pop2val',')',pop3,pop4,'(','pop5val',')']);
resultado=get(handles.edit4,'String');
if isempty(resultado)
    uiwait(errordlg('Indique un nombre para el resultado.'));
else
 try    
r.(resultado)=eval(evaluar);
ResultStruct.expresiones.(resultado)=[pop1,'(',poproi2,')',pop3,pop4,'(',poproi5,')'];
set(handles.edit4,'String','');
filltables2
catch
       uiwait(errordlg('Input incompatible.'));
end   
end




% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
global ResultStruct Fiduciales r R S T myhandles3 Variables Functions
Variables.Fiduciales=Fiduciales;
Variables.r=r;
Variables.ResultStruct=ResultStruct;
Variables.R=R;
Variables.S=S;
Variables.T=T;


informacion=ResultStruct.info;
codigo1=informacion.PatientName.FamilyName;
codigo2=informacion.PatientID;
Fecha_Placa=datestr(datetime([informacion.ContentDate,informacion.ContentTime(1:6)],'InputFormat','yyyyMMddHHmmSS', 'Format' ,'dd-MMMM-yyyy HH:mm:ss'));
if isfield(informacion,'StudyComments')
Estudio=informacion.StudyComments;%Podria escribir algo
else
    Estudio=informacion.StudyID;
end
Variables.Control.Tipo=codigo2;
 try
        NombreArch=Variables.Control.Nombre;
 catch
        c=clock;
        Nombre=strcat(codigo2,'-',num2str(c(3)),'-',num2str(c(2)),'-',num2str(c(1)),'-',num2str(c(4)),'.',num2str(c(5)),'.',num2str(c(6)));
        Variables.Control.Nombre=Nombre;
        NombreArch=Nombre;
 end




fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4
fn=fieldnames(Variables.ResultStruct.(char(fn1(j))));
if numel(fn)>1
    for i=2:numel(fn)
        Variables.ResultStruct.(char(fn1(j))).(char(fn(i)))=rmfield(Variables.ResultStruct.(char(fn1(j))).(char(fn(i))),'id');       
    end
    
end
end

fn=['A' 'B' 'C'];
try
for i=1:numel(fn);
    Variables.Fiduciales.(char(fn(i)))=rmfield(Variables.Fiduciales.(char(fn(i))),'id');
end
catch
end
try
   
[file,path] = uiputfile('*.mat','Guardar control',[NombreArch,'.mat']);
a=[path,file];
save (a, 'Variables');
ControlsDetails=cell(0,10);
load('ControlsDetails.mat');
SiZe=size(ControlsDetails);
if SiZe(1)<5
Ltab=SiZe(1);   
else
Ltab=14;
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

if strcmp(file(1:end-4),Variables.Control.Nombre)
    %Reemplazo reporte
    for j=1:Ltab
        if strcmp(Variables.Control.Nombre,ControlsDetails{j,8})
            CheckTolerancias(j)
         report1=ControlsDetails(1:Ltab,1:7);
     report1{j,1}=Fecha_Placa;
     report1{j,2}=datestr(datetime('now','Format','dd/MM/yyyy HH:mm'));%Fecha Control
     report1{j,3}=Estudio;
     report1{j,4}=esqlist{i_esq,2};%era 3
     try
     myhandles3.uitable1.Data=report1;
     catch
     end
     ControlsDetails{j,1}=report1{j,1};
     ControlsDetails{j,2}=report1{j,2};
     ControlsDetails{j,3}=report1{j,3};
     ControlsDetails{j,4}=report1{j,4};
     ControlsDetails{j,5}=report1{j,5};
     ControlsDetails{j,6}=report1{j,6};
     ControlsDetails{j,7}=report1{j,7};
     ControlsDetails{j,8}=NombreArch;
     ControlsDetails{j,10}=SiZe(1)-j+1;
     save('ControlsDetails.mat','ControlsDetails');   
        end
    end
            
else
    %Lo guardo arriba como nuevo
     CheckTolerancias(0)
     report1=ControlsDetails(1:Ltab,1:7);
     report1{1,1}=Fecha_Placa;
     report1{1,2}=datestr(datetime('now','Format','dd/MM/yyyy HH:mm'));%Fecha Control
     report1{1,3}=Estudio;
     report1{1,4}=esqlist{i_esq,2};%era 3

     ControlsDetails{1,1}=report1{1,1};
     ControlsDetails{1,2}=report1{1,2};
     ControlsDetails{1,3}=report1{1,3};
     ControlsDetails{1,4}=report1{1,4};
     ControlsDetails{1,5}=report1{1,5};
     ControlsDetails{1,6}=report1{1,6};
     ControlsDetails{1,7}=report1{1,7};
     ControlsDetails{1,8}=NombreArch;
     ControlsDetails{1,10}=SiZe(1);
     try
     myhandles3.uitable1.Data=ControlsDetails(1:Ltab,1:7);
     myhandles3.uitable2.Data=ControlsDetails(1:Ltab,8:10);
     catch
     end
     save('ControlsDetails.mat','ControlsDetails');
end
 
     
catch
end


function CheckTolerancias(row_idx)
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
        if Variables.Tolerancias.(char(fn(i))).DifAbs{1}==1%Dif Absoluta 
           Variables.Tolerancias.(char(fn(i))).VDifAbs={r.(char(fn(i)))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difAbs=abs(Variables.Tolerancias.(char(fn(i))).VDifAbs{1});
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT2{1});
           if difAbs>lim2
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
        if Variables.Tolerancias.(char(fn(i))).DifPorc{1}==1%Dif Relativa Porcentual
           Variables.Tolerancias.(char(fn(i))).VDifPorc={((r.(char(fn(i))))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1}))*100/str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difPorc=abs(Variables.Tolerancias.(char(fn(i))).VDifPorc{1});
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT2{1});
           if difPorc>lim2
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
    Ltab=10;
end
report1=ControlsDetails(1:Ltab,1:7);
BriefReports={};
try
load('BriefReports.mat');
catch
end
if row_idx==0
BriefReports{end+1}=report2;
ControlsDetails(2:end+1,:)=ControlsDetails(1:end,:);
report1=[{''},{''},{''},{''},{''},{''},{''};report1];
row_idx=1;
else
BriefReports{SiZe(1)-row_idx+1}=report2;   
end

if fuera>0
report1(row_idx,5:7)=[{colergen('#FF0000 ',num2str(ok))},{colergen('#FF0000 ',num2str(warning))},{colergen('#FF0000 ',num2str(fuera))}];
ControlsDetails(row_idx,5:7)=[{colergen('#FF0000 ',num2str(ok))},{colergen('#FF0000 ',num2str(warning))},{colergen('#FF0000 ',num2str(fuera))}];
ControlsDetails(row_idx,9)={'F'};
elseif warning>0
    report1(row_idx,5:7)=[{colergen('#FFA500 ',num2str(ok))},{colergen('#FFA500 ',num2str(warning))},{colergen('#FFA500 ',num2str(fuera))}];
    ControlsDetails(row_idx,5:7)=[{colergen('#FFA500 ',num2str(ok))},{colergen('#FFA500 ',num2str(warning))},{colergen('#FFA500 ',num2str(fuera))}];
    ControlsDetails(row_idx,9)={'W'};
else
    report1(row_idx,5:7)=[{colergen('#00FF00 ',num2str(ok))},{colergen('#00FF00 ',num2str(warning))},{colergen('#00FF00 ',num2str(fuera))}];
    ControlsDetails(row_idx,5:7)=[{colergen('#00FF00 ',num2str(ok))},{colergen('#00FF00 ',num2str(warning))},{colergen('#00FF00 ',num2str(fuera))}];
    ControlsDetails(row_idx,9)={'O'};
end
save('ControlsDetails.mat','ControlsDetails');
save('BriefReports.mat','BriefReports');
try
myhandles3.uitable1.Data=report1(1:Ltab,1:end);
catch
end


function actualizarResult
global r ResultStruct R S T

try
r=struct;   
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
filltables2
RealizarFunctions
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


% --------------------------------------------------------------------
function openfile_Callback(hObject, eventdata, handles)
global ResultStruct Fiduciales r R S T Variables
try
[filename, pathname] = uigetfile('*.mat');
 load([pathname, filename]);
 ResultStruct=Variables.ResultStruct;
 Fiduciales=Variables.Fiduciales;
 r=Variables.r;
 try
        R=Variables.R;
        S=Variables.S;
        T=Variables.T;
 catch
 end
AplicarCorrecciones
RedibujarROIs
mostrarIMG(handles)
filltables
filltables2
catch
end


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
global R S T OrigenCoord OutputIMG ResultStruct Fiduciales r Variables esqpath

if isempty(R)
    R=[1 0;0 -1];
    mm_pix=str2double(handles.edit6.String);
    if isscalar(mm_pix)
    S=mm_pix;
    else
        uiwait(errordlg('Ingrese un escalar como factor de escala.'))
    end
    T=[-round(length(OutputIMG(1,:))/2);round(length(OutputIMG(:,1))/2)]*S;
    OrigenCoord.posicion=(inv(R)*(-T/S)).';
    Fiduciales.A=[];
    Fiduciales.B=[];
    Fiduciales.C=[];
end
 
if isfield(Variables,'Functions')
    if isempty(Variables.Functions)
     Variables.Functions=struct;
    end
else
    Variables.Functions=struct;
end

Transf_Pix2mm
Variables.Fiduciales=Fiduciales;
Variables.r=r;

try
load('ListaEsquemas.m','-mat');
catch
    esqlist='';
end

prompt = {'Nombre:', 'Código:'};
title = 'Ingrese datos del template';
answer = inputdlg(prompt,title);
check=0;
if ~isempty(answer)
while check==0
    if sum(strcmp(esqlist(:,1),answer{2}))
        title = 'Código de template ya existente';
        quest = 'Código de template ya existente, desea reemplazarlo?';
        answer_int = questdlg(quest,title);
        switch answer_int
    case 'Yes'
        idex=strcmp(esqlist(:,1),answer{2});
        to_del=strcat(esqpath{1},esqlist(idex,3));
        to_del=to_del{1};
        delete(to_del)
        esqlist(idex,:)=[];
        check=1;
    case 'No'
        prompt = {'Nombre:', 'Código:'};
        answer = inputdlg(prompt,title);
    case 'Cancel'
        answer='';
        check=1;
    case ''
        answer='';
        check=1;
        end
    elseif sum(strcmp(esqlist(:,2),answer{1}))
        title = 'Nombre de template ya existente';
        quest = 'Nombre de template ya existente, desea reemplazarlo?';
        answer_int = questdlg(quest,title);
        switch answer_int
    case 'Yes'
        idex=strcmp(esqlist(:,2),answer{1});
        to_del=strcat(esqpath{1},esqlist(idex,3));
        to_del=to_del{1};
        delete(to_del)
        esqlist(idex,:)=[];
        check=1;
    case 'No'
        prompt = {'Nombre:', 'Código:'};
        answer = inputdlg(prompt,title);
    case 'Cancel'
        answer='';
        check=1;
    case ''
        answer='';
        check=1;
        end   
    else
        check=1;
    end
end
if ~isempty(answer)
ResultStruct.NombreControl=answer{1};
ResultStruct.CodigoControl=answer{2};
Variables.ResultStruct=ResultStruct;
fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4;
fn=fieldnames(Variables.ResultStruct.(char(fn1(j))));
if numel(fn)>1;
    for i=2:numel(fn);
        Variables.ResultStruct.(char(fn1(j))).(char(fn(i)))=rmfield(Variables.ResultStruct.(char(fn1(j))).(char(fn(i))),'id');       
    end
    
end
end
if isfield(Variables.Fiduciales,'A')
Variables.Fiduciales=rmfield(Variables.Fiduciales,{'A','B','C'});
end
mm_pix=str2double(handles.edit6.String);
if isscalar(mm_pix)
else
    uiwait(errordlg('Ingrese un escalar como factor de escala.'))
end
Variables.Fiduciales.FactorEscala=mm_pix;

try
[file,path] = uiputfile('*.mat','Guardar template','template.mat');
save([path,file],'Variables');
catch
end
esqlist = cat(1,esqlist,[{ResultStruct.CodigoControl},{ResultStruct.NombreControl},{file}]);
save('ListaEsquemas.m','esqlist');
end
end




function Transf_Pix2mm
global ResultStruct R S T OutputIMG OrigenCoord myhandles Fiduciales
if isempty(R)
    R=[1 0;0 -1];
    mm_pix=str2double(myhandles.edit6.String);
    if isscalar(mm_pix)
    S=mm_pix;
    else
        uiwait(errordlg('Ingrese un escalar como factor de escala.'))
    end
    T=[-round(length(OutputIMG(1,:))/2);round(length(OutputIMG(:,1))/2)]*S;
    OrigenCoord.posicion=(inv(R)*(-T/S)).';
    Fiduciales.A=[];
    Fiduciales.B=[];
    Fiduciales.C=[];
end
fn=fieldnames(ResultStruct.perfiles);
for i=2:numel(fn);
posi=ResultStruct.perfiles.(char(fn(i))).posicion;
ResultStruct.perfiles.(char(fn(i))).posicion_mm(1,:)=round(((S*(R*posi(1,:)'))+T),3)';
ResultStruct.perfiles.(char(fn(i))).posicion_mm(2,:)=round(((S*(R*posi(2,:)'))+T),3)';
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

function Transf_mm2Pix
global ResultStruct R S T OrigenCoord OutputIMG myhandles OOBalarm

Limits1=fliplr(size(OutputIMG));
Limits2=[1 1];
OOBalarm=0;

if isempty(R)
    R=[1 0;0 -1];
    mm_pix=str2double(myhandles.edit6.String);
    if isscalar(mm_pix)
    S=mm_pix;
    else
        uiwait(errordlg('Ingrese un escalar como factor de escala.'))
    end
    T=[-round(length(OutputIMG(1,:))/2);round(length(OutputIMG(:,1))/2)]*S;
    OrigenCoord.posicion=(inv(R)*(-T/S)).';
end
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





% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
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


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
global ResultStruct
contents=cellstr(get(hObject,'String'));
file=contents{get(hObject,'Value')};
ResultStruct.Correcciones.Ganancia=file;
AplicarCorrecciones
mostrarIMG(handles);
filltables
actualizarResult


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function AplicarCorrecciones
global ResultStruct OutputIMG Variables

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
Calibracion.I=0:1:max(round(ResultStruct.InputIMG(:)));
Calibracion.D=0:1:max(round(ResultStruct.InputIMG(:)));
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

try
ActualizarInfoROIs
catch
end

function ActualizarInfoROIs
global ResultStruct

fn1={'perfiles'; 'puntos'; 'poligonos'; 'circulos'};
for j=1:4;
    fn2=fieldnames(ResultStruct.(char(fn1(j))));
for i=2:numel(fn2);
                infoROIs(fn1(j),fn2(i));
end
end
Transf_Pix2mm
filltables
plotPerfil
plotSurf
actualizarResult



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
global callindex2

callindex2=0;
ApplyFunction


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
global SelectedFunction
contents=cellstr(get(hObject,'String'));
file=contents{get(hObject,'Value')};
SelectedFunction=file;


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
global selectedROItype OOBalarm
if strcmp(selectedROItype,'');
    uiwait(errordlg('Ningún ROI seleccionado'));
else
Transf_Pix2mm
uiwait(ROIs_mm)
Transf_mm2Pix
if OOBalarm>0
     uiwait(warndlg([num2str(OOBalarm),' punto(s) fuera de la imagen se llevaron al límite de la misma.']))
     OOBalarm=0;
end
%Transf_Pix2mm
filltables
ActualizarInfoROIs
mostrarIMG(handles);
llenarpopup
end





% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
uiwait(VerTemplates)
mostrarIMG(handles)
filltables
filltables2



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





% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
global ResultStruct
contents=cellstr(get(hObject,'String'));
file=contents{get(hObject,'Value')};
ResultStruct.Correcciones.FactorCampo=file;
AplicarCorrecciones
mostrarIMG(handles);
filltables
actualizarResult


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
global Variables
uiwait(VerTemplates)
mm_pix=Variables.Fiduciales.FactorEscala;
handles.edit6.String=num2str(mm_pix);
mostrarIMG(handles)
filltables
filltables2



% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
imcontrast(handles.axes1)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
global ResultStruct r
actualizarResult
[filename, pathname] = uigetfile('*.txt','Seleccione el script a analizar');
if ~isempty(filename)
A = fopen([pathname,filename]);
try
eval(fscanf(A,'%c'))
A = fopen([pathname,filename]);
ResultStruct.expresiones.(filename(1:end-4))=fscanf(A,'%c');
catch
    uiwait(warndlg('Script incompatible'))
end
filltables2
end
