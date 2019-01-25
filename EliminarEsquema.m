function varargout = EliminarEsquema(varargin)
% ELIMINARESQUEMA MATLAB code for EliminarEsquema.fig
%      ELIMINARESQUEMA, by itself, creates a new ELIMINARESQUEMA or raises the existing
%      singleton*.
%
%      H = ELIMINARESQUEMA returns the handle to a new ELIMINARESQUEMA or the handle to
%      the existing singleton*.
%
%      ELIMINARESQUEMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELIMINARESQUEMA.M with the given input arguments.
%
%      ELIMINARESQUEMA('Property','Value',...) creates a new ELIMINARESQUEMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EliminarEsquema_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EliminarEsquema_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EliminarEsquema

% Last Modified by GUIDE v2.5 28-Sep-2018 12:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EliminarEsquema_OpeningFcn, ...
                   'gui_OutputFcn',  @EliminarEsquema_OutputFcn, ...
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


% --- Executes just before EliminarEsquema is made visible.
function EliminarEsquema_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EliminarEsquema (see VARARGIN)

% Choose default command line output for EliminarEsquema
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
function varargout = EliminarEsquema_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
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



% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
global SelectedEsq
 SelectedEsq = eventdata.Indices;


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
