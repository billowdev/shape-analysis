function varargout = Ex93CS63112(varargin)
% EX93CS63112 MATLAB code for Ex93CS63112.fig
%      EX93CS63112, by itself, creates a new EX93CS63112 or raises the existing
%      singleton*.
%
%      H = EX93CS63112 returns the handle to a new EX93CS63112 or the handle to
%      the existing singleton*.
%
%      EX93CS63112('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX93CS63112.M with the given input arguments.
%
%      EX93CS63112('Property','Value',...) creates a new EX93CS63112 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ex93CS63112_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ex93CS63112_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ex93CS63112

% Last Modified by GUIDE v2.5 15-Aug-2021 13:52:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ex93CS63112_OpeningFcn, ...
                   'gui_OutputFcn',  @Ex93CS63112_OutputFcn, ...
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


% --- Executes just before Ex93CS63112 is made visible.
function Ex93CS63112_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ex93CS63112 (see VARARGIN)

% Choose default command line output for Ex93CS63112
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ex93CS63112 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ex93CS63112_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ---------------------- pre-process ---------------------- %

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile({'*.png';'*.jpg';'*.bmp'},'File Selector');
pathf = strcat(pathname, filename);
f1 = imread(pathf);
handles.image1=f1;
guidata(hObject, handles);

figure(1)
subplot(1,2,1)
title("image 1");
imagesc(handles.image1)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile({'*.png';'*.jpg';'*.bmp'},'File Selector');
pathf = strcat(pathname, filename);
f2 = imread(pathf);
handles.image2=f2;
guidata(hObject, handles);

figure(1)
subplot(1,2,2)
title("image 2");
imagesc(handles.image2)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
item=get(hObject, 'value');
switch item
    case 1
        % ---------------------- process ---------------------- %
        % Image spin
        rIm1 = imrotate(handles.image1,10,'bilinear','crop');
        % Scale Image
        sIm1 = imresize(handles.image1,2);
        % ---------------------- Hu Invariant Moment ---------------------- %
        % คำนวณ Hu Invariant Moment
        v02 = hu_moment(handles.image1, 0, 2);
        v20 = hu_moment(handles.image1, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1Im1 = sprintf("H1 value of Im1 = %.4f", v20+v02);

        v02 = hu_moment(rIm1, 0, 2);
        v20 = hu_moment(rIm1, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1rIm1 = sprintf("\nH1 value of rIm1 = %.4f", v20+v02);

        v02 = hu_moment(sIm1, 0, 2);
        v20 = hu_moment(sIm1, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1sIm1 = sprintf("\nH1 value of sIm1 = %.4f", v20+v02);
        
        % ---------------------- Post-process  ---------------------- %
        % ------------ นำข้อมูลที่ได้จากการ Process มาแสดงผล ------------ %
        figure("Name", "Hu momet in image 1")
        subplot(221), imagesc(handles.image1); colormap(gray)
        title(strcat("Original Image", Hu1Im1))
        subplot(222), imagesc(rIm1); colormap(gray)
        title(strcat("r Image", Hu1rIm1))
        subplot(223), imagesc(sIm1); colormap(gray)
        title(strcat("s Image", Hu1sIm1))
        % แสดงค่า Hu Invariant Moment บน Listbox1 ซึ่งเป็นผลลัพธ์ของภาพที่ 1 
        set(handles.listbox1, "string", strcat(Hu1Im1, Hu1rIm1, Hu1sIm1));
    case 2
        % ---------------------- process ---------------------- %
        % Image spin
        rIm2 = imrotate(handles.image2,10,'bilinear','crop');
        % Scale Image
        sIm2 = imresize(handles.image2,2);

        % ---------------------- Hu Invariant Moment ---------------------- %
        % คำนวณ Hu Invariant Moment
        v02 = hu_moment(handles.image2, 0, 2);
        v20 = hu_moment(handles.image2, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1Im2 = sprintf("H1 value of Im2 = %.4f", v20+v02);

        v02 = hu_moment(rIm2, 0, 2);
        v20 = hu_moment(rIm2, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1rIm2 = sprintf("\nH1 value of rIm2 = %.4f", v20+v02);

        v02 = hu_moment(sIm2, 0, 2);
        v20 = hu_moment(sIm2, 2, 0);
        % ค่าที่ได้จากการคำนวณ และแปลงเป็นข้อความเพื่อนำไปแสดงผล
        Hu1sIm2 = sprintf("\nH1 value of sIm2 = %.4f", v20+v02);

        % ---------------------- Post-process  ---------------------- %
        % ------------ นำข้อมูลที่ได้จากการ Process มาแสดงผล ------------ %
        figure("Name", "Hu momet in image 2")
        subplot(221), imagesc(handles.image2); colormap(gray)
        title(strcat("Original Image", Hu1Im2))
        subplot(222), imagesc(rIm2); colormap(gray)
        title(strcat("r Image", Hu1rIm2))
        subplot(223), imagesc(sIm2); colormap(gray)
        title(strcat("s Image", Hu1sIm2))
        % แสดงค่า Hu Invariant Moment บน Listbox2 ซึ่งเป็นผลลัพธ์ของภาพที่ 2
        set(handles.listbox2, "string", strcat(Hu1Im2, Hu1rIm2, Hu1sIm2));
end



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
