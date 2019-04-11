function varargout = untitled2(varargin)
% UNTITLED2 M-file for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 02-Apr-2010 15:00:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear  ;
%Design  the MACE filter
%Create  the X matrix
%K=input('input the number_of_training_images:');
K=inputdlg('input the number_of_training_images:');
[val]= str2num(K{1});
number_of_training_images=val;
X=[];
for i=1:number_of_training_images;
   G=int2str(i);
   G=strcat('\',G,'.bmp');
   G=strcat('C:\Users\User\Desktop\Training',G);
   image=imread(G);
   subplot(2,2,1);imshow(image);
   title('The sample of training images');
   image=fft2(im2double(image));
[M N]=size(image);
Z=reshape(image,M*N,1);
v(i,:)=Z';
end 
X=v';
K=number_of_training_images;
%Create the D matrix
ASD=abs(X).^2;
sum=0;
for i=1:K;
    dig_asd=diag(ASD(:,i));
   sum=sum+dig_asd;
end
D=sum./K;
%create the D invers
D_inv=inv(D);


%Create the U matrix
 U = ones(K,1);
  
 
 %Create the  complex conjugate transpose
  C=ctranspose(X);
  
  
  %Compute the h filter, then creat the H filter(MACE)
  F=inv((C)*(D_inv)*(X));
  Y=F*U;
  E=D_inv*X;
  h=E*Y;
  [M N]=size(image);
  H=reshape(h,M,N);
  subplot(2,2,2);imshow(H);
  title('The MACE Filter');
  
  
      
  %for a test image
  %test=imread('C:\Users\User\Desktop\Training\10.bmp');
  test=imread('C:\Users\User\Desktop\ORL\s28\10.bmp');
  subplot(2,2,3);imshow(test);
  title('The Test image');
  test_f=fft2(im2double(test));
  output=real(ifft2(test_f.*conj(H)));
  output=ifftshift(output);
  subplot(2,2,4);
  mesh(output);title('The output correlation in 3-D'); 
  %plot(output);title('The output correlation in 2-D'); 
 
  
  %colormap(jet); colorbar



