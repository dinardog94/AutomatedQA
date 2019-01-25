function varargout = ApplyFunction(varargin)
% APPLYFUNCTION MATLAB code for ApplyFunction.fig
%      APPLYFUNCTION, by itself, creates a new APPLYFUNCTION or raises the existing
%      singleton*.
%
%      H = APPLYFUNCTION returns the handle to a new APPLYFUNCTION or the handle to
%      the existing singleton*.
%
%      APPLYFUNCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPLYFUNCTION.M with the given input arguments.
%
%      APPLYFUNCTION('Property','Value',...) creates a new APPLYFUNCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ApplyFunction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ApplyFunction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ApplyFunction

% Last Modified by GUIDE v2.5 27-Jul-2018 17:29:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ApplyFunction_OpeningFcn, ...
                   'gui_OutputFcn',  @ApplyFunction_OutputFcn, ...
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


% --- Executes just before ApplyFunction is made visible.
function ApplyFunction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ApplyFunction (see VARARGIN)

% Choose default command line output for ApplyFunction
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global myhandles4 SelectedFunction myhandles Variables
myhandles4=handles;
if isempty(SelectedFunction)
    SelectedFunction=myhandles.popupmenu15.String{1};
end
BlankFormat
try
    feval([SelectedFunction,'_Completar_TablaTolerancias'])
    feval([SelectedFunction,'_Plot'])
catch
    %cla %Clear axis
end
    




% --- Outputs from this function are returned to the command line.
function varargout = ApplyFunction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global SelectedFunction myhandles4

feval([SelectedFunction,'_Function'])
feval([SelectedFunction,'_Completar_TablaTolerancias'])
feval([SelectedFunction,'_Plot'])




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global PlotNumber SelectedFunction
try
if PlotNumber(1)>1
PlotNumber(1)=PlotNumber(1)-1;
else
PlotNumber(1)=sum(PlotNumber(2:end));
end

feval([SelectedFunction,'_Plot'])
catch
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global PlotNumber SelectedFunction
try
if PlotNumber(1)<sum(PlotNumber(2:end))
PlotNumber(1)=PlotNumber(1)+1;
else
PlotNumber(1)=1;
end

feval([SelectedFunction,'_Plot'])
catch
end


% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
global SelectedFunction
feval([SelectedFunction,'_Save_Tolerancias'])
feval([SelectedFunction,'_Completar_TablaTolerancias'])




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SelectedFunction callindex2
callindex2=0;
feval([SelectedFunction,'_SaveFunction'])
close(ApplyFunction)

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global SelectedFunction
feval([SelectedFunction,'_CloseCB'])
delete(hObject)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global SelectedFunction Variables
try
    Variables.Functions=rmfield(Variables.Functions,SelectedFunction);
    BlankFormat
catch
    feval([SelectedFunction,'_CloseCB'])
    BlankFormat
end

function BlankFormat
global SelectedFunction myhandles4
InfoFormulario=feval([SelectedFunction,'_InfoFormulario']);
ColumnName_Table1=InfoFormulario.ColumnName_Table1;
RowName_Table1=InfoFormulario.RowName_Table1;
ColumnEditable_Table1=InfoFormulario.ColumnEditable_Table1;
ColumnFormat_Table1=InfoFormulario.ColumnFormat_Table1;
data_Table1=InfoFormulario.data_Table1;
Visible_Table1=InfoFormulario.Visible_Table1;
ColumnName_Table2=InfoFormulario.ColumnName_Table2;
RowName_Table2=InfoFormulario.RowName_Table2;
ColumnEditable_Table2=InfoFormulario.ColumnEditable_Table2;
ColumnFormat_Table2=InfoFormulario.ColumnFormat_Table2;
data_Table2=InfoFormulario.data_Table2;
Visible_Table2=InfoFormulario.Visible_Table2;
ColumnName_Table3=InfoFormulario.ColumnName_Table3;
RowName_Table3=InfoFormulario.RowName_Table3;
ColumnEditable_Table3=InfoFormulario.ColumnEditable_Table3;
ColumnFormat_Table3=InfoFormulario.ColumnFormat_Table3;
data_Table3=InfoFormulario.data_Table3;
Visible_Table3=InfoFormulario.Visible_Table3;
set(myhandles4.uitable1,'ColumnName',ColumnName_Table1,'RowName',RowName_Table1,'ColumnEditable', ColumnEditable_Table1, 'ColumnFormat', ColumnFormat_Table1,'data',data_Table1,'Visible',Visible_Table1)
set(myhandles4.uitable2,'ColumnName',ColumnName_Table2,'RowName',RowName_Table2,'ColumnEditable', ColumnEditable_Table2, 'ColumnFormat', ColumnFormat_Table2,'data',data_Table2,'Visible',Visible_Table2)
set(myhandles4.uitable3,'ColumnName',ColumnName_Table3,'RowName',RowName_Table3,'ColumnEditable', ColumnEditable_Table3, 'ColumnFormat', ColumnFormat_Table3,'data',data_Table3,'Visible',Visible_Table3)
set(myhandles4.text4,'String',SelectedFunction)
cla %clear axis

    
