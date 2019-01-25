function varargout = EliminarCalculo(varargin)
% ELIMINARCALCULO MATLAB code for EliminarCalculo.fig
%      ELIMINARCALCULO, by itself, creates a new ELIMINARCALCULO or raises the existing
%      singleton*.
%
%      H = ELIMINARCALCULO returns the handle to a new ELIMINARCALCULO or the handle to
%      the existing singleton*.
%
%      ELIMINARCALCULO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELIMINARCALCULO.M with the given input arguments.
%
%      ELIMINARCALCULO('Property','Value',...) creates a new ELIMINARCALCULO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EliminarCalculo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EliminarCalculo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EliminarCalculo

% Last Modified by GUIDE v2.5 25-Oct-2018 11:58:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EliminarCalculo_OpeningFcn, ...
                   'gui_OutputFcn',  @EliminarCalculo_OutputFcn, ...
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


% --- Executes just before EliminarCalculo is made visible.
function EliminarCalculo_OpeningFcn(hObject, eventdata, handles, varargin)
global ResultStruct
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EliminarCalculo (see VARARGIN)

% Choose default command line output for EliminarCalculo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
CalcNames=fieldnames(ResultStruct.expresiones);
CalcExpr=cell(length(CalcNames),1);
for i=1:length(CalcNames)
    CalcExpr{i}=ResultStruct.expresiones.(char(CalcNames(i)));
end
handles.uitable1.Data=[CalcNames,CalcExpr];


% --- Outputs from this function are returned to the command line.
function varargout = EliminarCalculo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global SelectedCalc ResultStruct;
if isempty(SelectedCalc)
    uiwait(warndlg('Ningún cálculo seleccionado.'))
else

try
fn=fieldnames(ResultStruct.expresiones);
borrar=fn(SelectedCalc(1));
answer = questdlg(['Desea eliminar el cálculo',borrar,'?'],'','Sí','No','Sí');

switch answer
    case 'Sí'
        ResultStruct.expresiones=rmfield(ResultStruct.expresiones,borrar);
        fn=fieldnames(ResultStruct.expresiones);
        CalcExpr=cell(length(fn),1);
        for i=1:length(fn)
            CalcExpr{i}=ResultStruct.expresiones.(char(fn(i)));
        end
        handles.uitable1.Data=[fn,CalcExpr];
        SelectedCalc=[];
    case 'No'
    case ''
end

catch
end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
global SelectedCalc
 SelectedCalc = eventdata.Indices;
