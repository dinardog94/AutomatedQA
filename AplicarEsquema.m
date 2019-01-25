function varargout = AplicarEsquema(varargin)
% APLICARESQUEMA MATLAB code for AplicarEsquema.fig
%      APLICARESQUEMA, by itself, creates a new APLICARESQUEMA or raises the existing
%      singleton*.
%
%      H = APLICARESQUEMA returns the handle to a new APLICARESQUEMA or the handle to
%      the existing singleton*.
%
%      APLICARESQUEMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLICARESQUEMA.M with the given input arguments.
%
%      APLICARESQUEMA('Property','Value',...) creates a new APLICARESQUEMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AplicarEsquema_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AplicarEsquema_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AplicarEsquema

% Last Modified by GUIDE v2.5 28-Sep-2018 12:47:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AplicarEsquema_OpeningFcn, ...
                   'gui_OutputFcn',  @AplicarEsquema_OutputFcn, ...
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


% --- Executes just before AplicarEsquema is made visible.
function AplicarEsquema_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AplicarEsquema (see VARARGIN)

% Choose default command line output for AplicarEsquema
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
try
load('ListaEsquemas.m','-mat');
catch
    esqlist=cell(1,3);
end
handles.uitable1.Data=esqlist;
clear('global', 'esqlist')


% --- Outputs from this function are returned to the command line.
function varargout = AplicarEsquema_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global esqpath SelectedEsq ResultStruct Variables r Functions Fiduciales
datostabla=handles.uitable1.Data;
    
load('ListaEsquemas.m','-mat');
esquema=esqlist{SelectedEsq(1),3};
load([esqpath{1},esquema]);
ResultStruct.angle=Variables.ResultStruct.angle;
ResultStruct.NombreControl=Variables.ResultStruct.NombreControl;
ResultStruct.CodigoControl=Variables.ResultStruct.CodigoControl;
ResultStruct.Crop=Variables.ResultStruct.Crop;
ResultStruct.Correcciones=Variables.ResultStruct.Correcciones;
ResultStruct.perfiles=Variables.ResultStruct.perfiles;
ResultStruct.puntos=Variables.ResultStruct.puntos;
ResultStruct.poligonos=Variables.ResultStruct.poligonos;
ResultStruct.circulos=Variables.ResultStruct.circulos;
ResultStruct.expresiones=Variables.ResultStruct.expresiones;
r=Variables.r;
Functions=fieldnames(Variables.Functions);
Fiduciales=Variables.Fiduciales;
AplicarCorrecciones
Fiduciales_SistCoord
PosicionROIs
InfoROIs
RealizarCalculos
RealizarFunctions
CheckTolerancias
close(AplicarEsquema)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
global SelectedEsq
 SelectedEsq = eventdata.Indices;
 
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

OutputIMG=(ResultStruct.InputIMG-Background.M).*Ganancia.G;
OutputIMG(OutputIMG<0)=0;
OutputIMG=imcrop(OutputIMG, ResultStruct.Crop);
OutputIMG=imrotate(OutputIMG,ResultStruct.angle,'bilinear','crop');

function Fiduciales_SistCoord
global Fiduciales R S T OrigenCoord OutputIMG
try
Rmin=Fiduciales.Parameters.Rmin;
Rmax=Fiduciales.Parameters.Rmax;
Sensibilidad=Fiduciales.Parameters.Sensibilidad;
Umbral=Fiduciales.Parameters.Umbral;
 [centers,radii] = imfindcircles(ResultStruct.InputIMG,[Rmin Rmax],'ObjectPolarity','dark','Sensitivity',Sensibilidad,'EdgeThreshold',Umbral);   
catch
[centers,radii] = imfindcircles(ResultStruct.InputIMG,[4 12],'ObjectPolarity','dark','Sensitivity',0.91,'EdgeThreshold',0.02);
end

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
OrigenCoord.posicion=(inv(R)*(-T/S)).';



function PosicionROIs
global ResultStruct R S T
fn=fieldnames(ResultStruct.perfiles);
for i=2:numel(fn);
posi=ResultStruct.perfiles.(char(fn(i))).posicion_mm;
ResultStruct.perfiles.(char(fn(i))).posicion(1,:)=(inv(R)*((posi(1,:)'-T)/S)).';
ResultStruct.perfiles.(char(fn(i))).posicion(2,:)=(inv(R)*((posi(2,:)'-T)/S)).';
end

fn=fieldnames(ResultStruct.puntos);
for i=2:numel(fn);
posi=ResultStruct.puntos.(char(fn(i))).posicion_mm;
ResultStruct.puntos.(char(fn(i))).posicion=(inv(R)*((posi'-T)/S)).';
end

fn=fieldnames(ResultStruct.poligonos);
for i=2:numel(fn);
posi=ResultStruct.poligonos.(char(fn(i))).posicion_mm;
for j=1:length(posi(:,1))
ResultStruct.poligonos.(char(fn(i))).posicion(j,:)=(inv(R)*((posi(j,:)'-T)/S)).';
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
end



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
    valor_r=OutputIMG(round(pos(2)):round((pos(2)+pos(4))),round(pos(1)):round((pos(1)+pos(3))));
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
global r ResultStruct

try
    
load_r

fn=fieldnames(ResultStruct.expresiones);
for i=1:numel(fn)
    r.(char(fn(i)))=eval(ResultStruct.expresiones.(char(fn(i))));
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
global r Variables callindex2 Functions fdt_F warning_F ok_F

ok=0;
warning=0;
fuera=0;
report2=[];
a=1;

if isfield(Variables,'Tolerancias')
fn=fieldnames(Variables.Tolerancias);
fin=length(fn);

%%%Calculos%%%
for i=1:fin    
    if Variables.Tolerancias.(char(fn(i))).SiNo{1}==1
        Variables.Tolerancias.(char(fn(i))).VObt={r.(char(fn(i)))};
        report2{a,1}=fn(i);
        report2{a,2}=r.(char(fn(i)));
        report2{a,3}=Variables.Tolerancias.(char(fn(i))).VRef{1};
        if Variables.Tolerancias.(char(fn(i))).DifAbs{1}==1%Dif Absoluta 
           Variables.Tolerancias.(char(fn(i))).VDifAbs={r.(char(fn(i)))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difAbs=abs(Variables.Tolerancias.(char(fn(i))).VDifAbs{1});
           report2{a,4}=difAbs;
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifAbsT2{1});
           if ((difAbs>lim2) || (isnan(difAbs)))
               fuera=fuera+1;
               report2{a,5}='Fuera de tolerancia';
           else
               if difAbs>lim1
                   warning=warning+1;
                   report2{a,5}='Warning';
               else
                   ok=ok+1;
                   report2{a,5}='Ok';
               end
           end
        end
        if Variables.Tolerancias.(char(fn(i))).DifPorc{1}==1%Dif Relativa Porcentual
           Variables.Tolerancias.(char(fn(i))).VDifPorc={((r.(char(fn(i))))-str2double(Variables.Tolerancias.(char(fn(i))).VRef{1}))*100/str2double(Variables.Tolerancias.(char(fn(i))).VRef{1})};
           difPorc=abs(Variables.Tolerancias.(char(fn(i))).VDifPorc{1});
           report2{a,6}=difPorc;
           lim1=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT1{1});
           lim2=str2double(Variables.Tolerancias.(char(fn(i))).DifPorcT2{1});
           if ((difPorc>lim2) || (isnan(difPorc)))
               fuera=fuera+1;
               report2{a,7}='Fuera de tolerancia';
           else
               if difPorc>lim1
                   warning=warning+1;
                   report2{a,7}='Warning';
               else
                   ok=ok+1;
                   report2{a,7}='Ok';
               end
           end
        end
        a=a+1;
    end
end
else
end


%%%Functions%%%

fdt_F=0;
warning_F=0;
ok_F=0;
for j=1:length(Functions)
    callindex2=1;
    feval([Functions{j},'_CloseCB'])
    feval([Functions{j},'_Completar_TablaTolerancias'])
    feval([Functions{j},'_CloseCB'])
end

ok=ok+ok_F;
warning=warning+warning_F;
fuera=fuera+fdt_F;


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global esqpath SelectedEsq
datostabla=handles.uitable1.Data;
try
load('ListaEsquemas.m','-mat');
esqlist(SelectedEsq(1),:)=[];
save('ListaEsquemas.m','esqlist');
delete(strcat(esqpath{1},datostabla{SelectedEsq(1),3}))
catch
end
try
handles.uitable1.Data=esqlist;
clear('global', 'esqlist')
catch
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global esqpath SelectedEsq ResultStruct Variables r Functions Fiduciales
datostabla=handles.uitable1.Data;
try
load('ListaEsquemas.m','-mat');
%load(strcat(esqpath{1},datostabla{SelectedEsq(1),3}))
esquema=esqlist{SelectedEsq(1),3};
load([esqpath{1},esquema]);
ResultStruct.InputIMG=Variables.ResultStruct.InputIMG;
ResultStruct.angle=Variables.ResultStruct.angle;
ResultStruct.NombreControl=Variables.ResultStruct.NombreControl;
ResultStruct.CodigoControl=Variables.ResultStruct.CodigoControl;
ResultStruct.Crop=Variables.ResultStruct.Crop;
ResultStruct.Correcciones=Variables.ResultStruct.Correcciones;
ResultStruct.perfiles=Variables.ResultStruct.perfiles;
ResultStruct.puntos=Variables.ResultStruct.puntos;
ResultStruct.poligonos=Variables.ResultStruct.poligonos;
ResultStruct.circulos=Variables.ResultStruct.circulos;
ResultStruct.expresiones=Variables.ResultStruct.expresiones;
r=Variables.r;
Functions=fieldnames(Variables.Functions);
Fiduciales=Variables.Fiduciales;
AplicarCorrecciones
Fiduciales_SistCoord
PosicionROIs
InfoROIs
RealizarCalculos
RealizarFunctions
CheckTolerancias
try
handles.uitable1.Data=esqlist;
clear('global', 'esqlist')
catch
end
close(AplicarEsquema)
catch
end
