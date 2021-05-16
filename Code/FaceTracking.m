function varargout = FaceTracking(varargin)
% FACETRACKING MATLAB code for FaceTracking.fig
%      FACETRACKING, by itself, creates a new FACETRACKING or raises the existing
%      singleton*.
%
%      H = FACETRACKING returns the handle to a new FACETRACKING or the handle to
%      the existing singleton*.
%
%      FACETRACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACETRACKING.M with the given input arguments.
%
%      FACETRACKING('Property','Value',...) creates a new FACETRACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaceTracking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      exit.  All inputs are passed to FaceTracking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaceTracking

% Last Modified by GUIDE v2.5 30-Mar-2020 20:41:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaceTracking_OpeningFcn, ...
                   'gui_OutputFcn',  @FaceTracking_OutputFcn, ...
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


% --- Executes just before FaceTracking is made visible.
function FaceTracking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaceTracking (see VARARGIN)

% Choose default command line output for FaceTracking
handles.output = hObject;
axes(handles.axes1);
imshow('blank.jpg');
axis off;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FaceTracking wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaceTracking_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');

guidata(hObject, handles);


% --- Executes on button press in face.
function face_Callback(hObject, eventdata, handles)
% hObject    handle to face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 5;
start(handles.vid);

while(1)
facedetector = vision.CascadeObjectDetector;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(facedetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'Face');
imshow(hello);
end

guidata(hObject, handles);


% --- Executes on button press in exit.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
stop(handles.vid),clear handles.vid %, ,delete(handles.vid)
guidata(hObject, handles);




% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc
display 'Exiting Tracking Module!!'
close(handles.figure1)
