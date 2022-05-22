function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 20-May-2022 21:09:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
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
%Pengambilan data
curah_hujan = cell2mat(readcell('data.xlsx','Range','B2:B11'))
kedalaman_air = cell2mat(readcell('data.xlsx','Range','C2:C11'))
keasaman_tanah = cell2mat(readcell('data.xlsx','Range','D2:D11'))
wilayah = readcell('data.xlsx','Range','A2:A11')

%Penentuan nilai maksimum/minimum
max_curah_hujan = max(curah_hujan)
max_kedalaman_air = max(kedalaman_air)
max_keasaman_tanah = max(keasaman_tanah)

%Penentuan BOBOT
bobot = [2 3 4]
bobot = bobot/sum(bobot)

%normalisasi
max_value = [max_curah_hujan,max_kedalaman_air,max_keasaman_tanah]
curah_hujan = curah_hujan/max_curah_hujan
kedalaman_air = kedalaman_air/max_kedalaman_air
keasaman_tanah = keasaman_tanah/max_keasaman_tanah
data_norm = [curah_hujan';kedalaman_air';keasaman_tanah']
data_norm = data_norm'

[m n] = size(data_norm)
result = []

for i=1:m
    result(i) = 0
    for j=1:n
        data_norm(i,j) = data_norm(i,j)*bobot(j)
        result(i) = result(i)+data_norm(i,j)
    end
end

%Pengurutan
j = result
result = result'
s_result = Quick_sort(result)
f_result = []
f_wilayah = wilayah

%Menentukan rangking tiap wilayah
for i=1:numel(result)
    for j=1:numel(result)
        if result(i) == s_result(j)
            f_result(j) = result(i)
            f_wilayah(j) = wilayah(i)
        end
    end
end

set(handles.jumlah,'string',numel(wilayah))
set(handles.uitable1,'data',f_wilayah)
set(handles.uitable2,'data',f_result')
