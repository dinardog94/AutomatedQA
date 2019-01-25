function varargout = EliminarCalculo(varargin)
% ELIMINAREXPRESION MATLAB code for EliminarExpresion.fig
%      ELIMINAREXPRESION, by itself, creates a new ELIMINAREXPRESION or raises the existing
%      singleton*.
%
%      H = ELIMINAREXPRESION returns the handle to a new ELIMINAREXPRESION or the handle to
%      the existing singleton*.
%
%      ELIMINAREXPRESION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELIMINAREXPRESION.M with the given input arguments.
%
%      ELIMINAREXPRESION('Property','Value',...) creates a new ELIMINAREXPRESION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EliminarExpresion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EliminarExpresion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EliminarExpresion

% Last Modified by GUIDE v2.5 25-Oct-2018 11:54:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EliminarExpresion_OpeningFcn, ...
                   'gui_OutputFcn',  @EliminarExpresion_OutputFcn, ...
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


% --- Executes just before EliminarExpresion is made visible.
function EliminarExpresion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EliminarExpresion (see VARARGIN)

% Choose default command line output for EliminarExpresion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EliminarExpresion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EliminarExpresion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global selectedCALC r ResultStruct selectedCALCname selectedCALCnameOld;
if strcmp(selectedCALCname{1},selectedCALCnameOld{1})
else
try
fn1=fieldnames(r);
fn1=fn1(primerResultado:numel(fn1));
borrar1=fn1(selectedCALC);
r=rmfield(r,borrar1);
fn2=fieldnames(ResultStruct.expresiones);
borrar2=fn2(selectedCALC);
ResultStruct.expresiones=rmfield(ResultStruct.expresiones,borrar2);
catch
end

filltables2

selectedCALCnameOld=selectedCALCname;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
