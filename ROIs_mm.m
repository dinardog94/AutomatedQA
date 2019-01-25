function varargout = ROIs_mm(varargin)
% ROIS_MM MATLAB code for ROIs_mm.fig
%      ROIS_MM, by itself, creates a new ROIS_MM or raises the existing
%      singleton*.
%
%      H = ROIS_MM returns the handle to a new ROIS_MM or the handle to
%      the existing singleton*.
%
%      ROIS_MM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROIS_MM.M with the given input arguments.
%
%      ROIS_MM('Property','Value',...) creates a new ROIS_MM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ROIs_mm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ROIs_mm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ROIs_mm

% Last Modified by GUIDE v2.5 14-Jun-2018 11:00:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ROIs_mm_OpeningFcn, ...
                   'gui_OutputFcn',  @ROIs_mm_OutputFcn, ...
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


% --- Executes just before ROIs_mm is made visible.
function ROIs_mm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ROIs_mm (see VARARGIN)

% Choose default command line output for ROIs_mm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global selectedROItype selectedROIalias coordenadas_mm selectedROIname ResultStruct
switch selectedROItype
    case 'perfiles'
set(handles.uipanel10,'Visible','off');
set(handles.uipanel11,'Visible','off');
set(handles.uipanel12,'Visible','off');
set(handles.uipanel1,'Visible','on');
set(handles.text9,'String',{['Perfil: ' selectedROIalias{1}]});
coordenadas_mm=cell(2,2);
coordenadas_mm(1,1:2)=[{round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,1),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,2),1)}];
coordenadas_mm(1,3:4)=[{round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(2,1),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(2,2),1)}];
set(handles.uitable1,'data',coordenadas_mm);
    case 'puntos'
set(handles.uipanel10,'Visible','on');
set(handles.uipanel11,'Visible','off');
set(handles.uipanel12,'Visible','off');
set(handles.uipanel1,'Visible','off');
set(handles.text17,'String',{['Punto: ' selectedROIalias{1}]});
coordenadas_mm=cell(1,2);
coordenadas_mm(1,1:2)=[{round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,1),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,2),1)}];
set(handles.uitable9,'data',coordenadas_mm);
    case 'circulos'
set(handles.uipanel11,'Visible','on');
set(handles.uipanel10,'Visible','off');
set(handles.uipanel12,'Visible','off');
set(handles.uipanel1,'Visible','off');
set(handles.text19,'String',{['Círculo: ' selectedROIalias{1}]});
coordenadas_mm=cell(1,3);
coordenadas_mm(1,1:3)=[{round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,1),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,2),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(1,3),1)}];
set(handles.uitable10,'data',coordenadas_mm);    
    case 'poligonos'
set(handles.uipanel12,'Visible','on');
set(handles.uipanel10,'Visible','off');
set(handles.uipanel11,'Visible','off');
set(handles.uipanel1,'Visible','off');
set(handles.text21,'String',{['Polígono: ' selectedROIalias{1}]});
vertix=length(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(:,1));
coordenadas_mm=cell(1,vertix);
for i=1:vertix
    coordenadas_mm(i,1:2)=[{round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(i,1),1)} {round(ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm(i,2),1)}];
end
set(handles.uitable11,'data',coordenadas_mm);
end



% --- Outputs from this function are returned to the command line.
function varargout = ROIs_mm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
global coordenadas_mm ResultStruct selectedROIname selectedROItype
try
switch selectedROItype
    case'perfiles'
    coordenadas_mm=[coordenadas_mm{1,1} coordenadas_mm{1,2}; coordenadas_mm{1,3} coordenadas_mm{1,4}];
    case 'puntos'
    coordenadas_mm=[coordenadas_mm{1,1} coordenadas_mm{1,2}];
    case 'circulos'
    coordenadas_mm=[coordenadas_mm{1,1} coordenadas_mm{1,2} coordenadas_mm{1,3}];
    case 'poligonos'
    coordenadas_mm=[cat(1,coordenadas_mm{:,1}) cat(1,coordenadas_mm{:,2})];
end
if (isnumeric(coordenadas_mm) && ~isempty(coordenadas_mm(:)))
ResultStruct.(selectedROItype).(selectedROIname{1}).posicion_mm=coordenadas_mm;
else
end
catch
end
close(ROIs_mm);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
close(ROIs_mm);


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
global coordenadas_mm
coordenadas_mm=get(handles.uitable1,'data');



% --- Executes when entered data in editable cell(s) in uitable2.
function uitable9_CellEditCallback(hObject, eventdata, handles)
global coordenadas_mm
coordenadas_mm=get(handles.uitable9,'data');



% --- Executes when entered data in editable cell(s) in uitable3.
function uitable10_CellEditCallback(hObject, eventdata, handles)
global coordenadas_mm
coordenadas_mm=get(handles.uitable10,'data');


% --- Executes when entered data in editable cell(s) in uitable4.
function uitable11_CellEditCallback(hObject, eventdata, handles)
global coordenadas_mm
coordenadas_mm=get(handles.uitable11,'data');
