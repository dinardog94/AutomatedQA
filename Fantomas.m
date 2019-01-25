function varargout = Fantomas(varargin)
% FANTOMAS MATLAB code for Fantomas.fig
%      FANTOMAS, by itself, creates a new FANTOMAS or raises the existing
%      singleton*.
%
%      H = FANTOMAS returns the handle to a new FANTOMAS or the handle to
%      the existing singleton*.
%
%      FANTOMAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FANTOMAS.M with the given input arguments.
%
%      FANTOMAS('Property','Value',...) creates a new FANTOMAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fantomas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fantomas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fantomas

% Last Modified by GUIDE v2.5 15-Apr-2018 17:51:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fantomas_OpeningFcn, ...
                   'gui_OutputFcn',  @Fantomas_OutputFcn, ...
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


% --- Executes just before Fantomas is made visible.
function Fantomas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fantomas (see VARARGIN)

% Choose default command line output for Fantomas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fantomas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fantomas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close(Fantomas);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global Fiduciales;
prompt = {'Nombre Fantoma:','Coordenada x de fiducial A (mm):','Coordenada y de fiducial A (mm):','Coordenada x de fiducial B (mm):', 'Coordenada y de fiducial B (mm):','Coordenada x de fiducial C (mm):', 'Coordenada y de fiducial C (mm):'};
title = 'Ingrese coordenadas en mm';
answer = inputdlg(prompt,title);
try
Coordenadas=answer(:);

nombre=Coordenadas(1);
Fiduciales.Am.posicion(1)=str2double(Coordenadas(2));
Fiduciales.Am.posicion(2)=str2double(Coordenadas(3));
Fiduciales.Bm.posicion(1)=str2double(Coordenadas(4));
Fiduciales.Bm.posicion(2)=str2double(Coordenadas(5));
Fiduciales.Cm.posicion(1)=str2double(Coordenadas(6));
Fiduciales.Cm.posicion(2)=str2double(Coordenadas(7));

[file,path] = uiputfile('*.mat','Guardar fantoma');
dir=[path,file];
save (dir, 'Coordenadas');

datos=handles.uitable1.Data;

datos(1,1)=nombre;
datos(1,2)={['[',Coordenadas{2},';',Coordenadas{3},']']};
datos(1,3)={['[',Coordenadas{4},';',Coordenadas{5},']']};
datos(1,4)={['[',Coordenadas{6},';',Coordenadas{7},']']};

handles.uitable1.Data=datos;
catch
end




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global Coordenadas Fiduciales
[filename, pathname] = uigetfile('*.mat');

try
load([pathname, filename]);
nombre=Coordenadas(1);
Fiduciales.Am.posicion(1)=str2double(Coordenadas(2));
Fiduciales.Am.posicion(2)=str2double(Coordenadas(3));
Fiduciales.Bm.posicion(1)=str2double(Coordenadas(4));
Fiduciales.Bm.posicion(2)=str2double(Coordenadas(5));
Fiduciales.Cm.posicion(1)=str2double(Coordenadas(6));
Fiduciales.Cm.posicion(2)=str2double(Coordenadas(7));

datos=handles.uitable1.Data;

datos(1,1)=nombre;
datos(1,2)={['[',Coordenadas{2},';',Coordenadas{3},']']};
datos(1,3)={['[',Coordenadas{4},';',Coordenadas{5},']']};
datos(1,4)={['[',Coordenadas{6},';',Coordenadas{7},']']};

handles.uitable1.Data=datos;
catch
end


 
