function varargout = ReadComPort(varargin)
% READCOMPORT MATLAB code for ReadComPort.fig
%      READCOMPORT, by itself, creates a new READCOMPORT or raises the existing
%      singleton*.
%
%      H = READCOMPORT returns the handle to a new READCOMPORT or the handle to
%      the existing singleton*.
%
%      READCOMPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READCOMPORT.M with the given input arguments.
%
%      READCOMPORT('Property','Value',...) creates a new READCOMPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReadComPort_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReadComPort_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReadComPort

% Last Modified by GUIDE v2.5 16-Feb-2016 23:39:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReadComPort_OpeningFcn, ...
                   'gui_OutputFcn',  @ReadComPort_OutputFcn, ...
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


% --- Executes just before ReadComPort is made visible.
function ReadComPort_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReadComPort (see VARARGIN)

% Choose default command line output for ReadComPort
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReadComPort wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReadComPort_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xlim([-1,1]);
ylim([-1,1]);
SisitPogr=22; %(учитывает систематическую погрешность. мат ожидание ошибки при статике =-22)
k=0.0517; % экспериментальная чувствительность (теоретическая 1/16.4=0.061)
Fd=10;% Hz
a=0;% угол  поворота в градусах. нач. значение.
x=[0,0];% вектор направления
y=[0,1];% начальное состояние
s1=serial('COM8');
set(s1, 'BaudRate', 9600);
set(s1, 'StopBits', 1);
fopen(s1);
    while(get(handles.radiobuttonStart, 'Value')==1)
    ReadCom=fgetl(s1);
    ReadCom=str2num(ReadCom);
    a=a+(ReadCom+SisitPogr)*k/Fd;
    x(2)=sin(pi*a/180);
    y(2)=cos(pi*a/180);
    plot(x,y);
    xlim([-1,1]);
    ylim([-1,1]);
    pause(0.005);
    end;

fclose(s1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
