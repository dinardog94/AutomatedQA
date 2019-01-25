function varargout = FilterResults(varargin)
% FILTERRESULTS MATLAB code for FilterResults.fig
%      FILTERRESULTS, by itself, creates a new FILTERRESULTS or raises the existing
%      singleton*.
%
%      H = FILTERRESULTS returns the handle to a new FILTERRESULTS or the handle to
%      the existing singleton*.
%
%      FILTERRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTERRESULTS.M with the given input arguments.
%
%      FILTERRESULTS('Property','Value',...) creates a new FILTERRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FilterResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FilterResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FilterResults

% Last Modified by GUIDE v2.5 23-Aug-2018 17:25:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FilterResults_OpeningFcn, ...
                   'gui_OutputFcn',  @FilterResults_OutputFcn, ...
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


% --- Executes just before FilterResults is made visible.
function FilterResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FilterResults (see VARARGIN)

% Choose default command line output for FilterResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);





% --- Outputs from this function are returned to the command line.
function varargout = FilterResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
set(hObject, 'Data', cell(2,3));


% --- Executes during object creation, after setting all properties.
function uitable2_CreateFcn(hObject, eventdata, handles)
set(hObject, 'Data', cell(3,2));


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global FilteredResults myhandles3
try
     load('ControlsDetails.mat');
     catch
       ControlsDetails=cell(0,10);
end
SiZe=size(ControlsDetails);
if SiZe(1)<5
Ltab=SiZe(1);   
else
Ltab=10;
end
VectorCoincidencias=ones(Ltab,1);
Data_1=handles.uitable1.Data;
Data_2=handles.uitable2.Data;
if Data_1{1,1}==1
    VectorCoincidencias_1=(datetime(ControlsDetails{:,1},'InputFormat','dd-MMMM-yyyy HH:mm:ss', 'Format' ,'dd/MM/yyyy')>datetime(Data_1{1,2},'InputFormat','dd/MM/yyyy'));
    VectorCoincidencias_2=(datetime(ControlsDetails{:,1},'InputFormat','dd-MMMM-yyyy HH:mm:ss', 'Format' ,'dd/MM/yyyy')<datetime(Data_1{1,3},'InputFormat','dd/MM/yyyy'));
    VectorCoincidencias=VectorCoincidencias_1 & VectorCoincidencias_2;
end
if Data_1{2,1}==1
    VectorCoincidencias_1=(datetime(ControlsDetails{:,2},'InputFormat','dd/MM/yyyy HH:mm', 'Format' ,'dd/MM/yyyy')>datetime(Data_1{2,2},'InputFormat','dd/MM/yyyy'));
    VectorCoincidencias_2=(datetime(ControlsDetails{:,2},'InputFormat','dd/MM/yyyy HH:mm', 'Format' ,'dd/MM/yyyy')<datetime(Data_1{2,3},'InputFormat','dd/MM/yyyy'));
    VectorCoincidencias_3=VectorCoincidencias_1 & VectorCoincidencias_2;
    VectorCoincidencias=VectorCoincidencias & VectorCoincidencias_3;
end
if Data_2{1,1}==1
    VectorCoincidencias_1 = regexpi(ControlsDetails(:,3),Data_2{1,2});
for i = 1:length(VectorCoincidencias_1)
  if isempty(VectorCoincidencias_1{i})
    VectorCoincidencias_1{i} = 0;
  end
end
    VectorCoincidencias_1=cell2mat(VectorCoincidencias_1);
    VectorCoincidencias=VectorCoincidencias & VectorCoincidencias_1;
end
if Data_2{2,1}==1
    VectorCoincidencias_1 = regexpi(ControlsDetails(:,4),Data_2{2,2});
for i = 1:length(VectorCoincidencias_1)
  if isempty(VectorCoincidencias_1{i})
    VectorCoincidencias_1{i} = 0;
  end
end
    VectorCoincidencias_1=cell2mat(VectorCoincidencias_1);
    VectorCoincidencias=VectorCoincidencias & VectorCoincidencias_1;
end
if Data_2{3,1}==1
    VectorCoincidencias_1 = regexpi(ControlsDetails(:,9),Data_2{3,2});
for i = 1:length(VectorCoincidencias_1)
  if isempty(VectorCoincidencias_1{i})
    VectorCoincidencias_1{i} = 0;
  end
end
    VectorCoincidencias_1=cell2mat(VectorCoincidencias_1);
    VectorCoincidencias=VectorCoincidencias & VectorCoincidencias_1;
end
FilteredResults=ControlsDetails(VectorCoincidencias,:);
myhandles3.uitable1.Data=FilteredResults(:,1:7);
myhandles3.uitable2.Data=FilteredResults(:,8:10);
close(FilterResults)



% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
Data=handles.uitable1.Data;
row_col = eventdata.Indices;
if row_col(2)>1
Fecha=Data{row_col(1),row_col(2)};
try
    datetime_try=datetime(Fecha,'Format','dd/MM/yyyy');
catch
    uiwait(errordlg('Formato de fecha incorrecto, utilice: dd/MM/yyyy'));
    Data{row_col(1),row_col(2)}=[];
    handles.uitable1.Data=Data;
end
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
