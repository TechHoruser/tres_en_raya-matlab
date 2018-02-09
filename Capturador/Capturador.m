function varargout = Capturador(varargin)
% CAPTURADOR MATLAB code for Capturador.fig
%      CAPTURADOR, by itself, creates a new CAPTURADOR or raises the existing
%      singleton*.
%
%      H = CAPTURADOR returns the handle to a new CAPTURADOR or the handle to
%      the existing singleton*.
%
%      CAPTURADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTURADOR.M with the given input arguments.
%
%      CAPTURADOR('Property','Value',...) creates a new CAPTURADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Capturador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Capturador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Capturador

% Last Modified by GUIDE v2.5 12-May-2015 18:52:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Capturador_OpeningFcn, ...
                   'gui_OutputFcn',  @Capturador_OutputFcn, ...
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


% --- Executes just before Capturador is made visible.
function Capturador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Capturador (see VARARGIN)

% Choose default command line output for Capturador
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Capturador wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.reproducir,'Enable','off');
set(handles.recortar,'Enable','off');
set(handles.guardar,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = Capturador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global senal
global senal_r
global bandera
global parametros
clear all


% --- Executes on selection change in numero.
function numero_Callback(hObject, eventdata, handles)
% hObject    handle to numero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns numero contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numero


% --- Executes during object creation, after setting all properties.
function numero_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tiempo_Callback(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tiempo as text
%        str2double(get(hObject,'String')) returns contents of tiempo as a double


% --- Executes during object creation, after setting all properties.
function tiempo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to mostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bandera
global senal
global parametros
set(handles.reproducir,'Enable','on');
set(handles.recortar,'Enable','on');
set(handles.guardar,'Enable','on');


bandera = 'senal';
can=get(handles.canal,'String');
ven=get(handles.ventana,'String');
b=get(handles.bits,'String');
aux=str2num(b);
uno=1;
while(aux>uno)
    uno=uno*2;
end
if(uno==aux)
    parametros=[get(handles.tiempo,'String');
                get(handles.fs,'String');
                can(get(handles.canal,'Value'));
                b;
                get(handles.pre,'String');
                get(handles.desp,'String');
                get(handles.trama,'String');
                ven(get(handles.ventana,'Value'))];
    senal=grabacion(str2num(parametros{1}),str2num(parametros{2}),str2num(parametros{3}),str2num(parametros{4}));
    plot(senal);
else
    msgbox('El número de Bits debe ser potencia de 2.');
end


% --- Executes on button press in mostrar.
function mostrar_Callback(hObject, eventdata, handles)
% hObject    handle to mostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bandera
global senal
global parametros

if(isempty(get(handles.jugador,'String')))
    msgbox('Introduzca numbre de Jugador');
else
    dir=['../Docs/' get(handles.jugador,'String') '/'];
    if(~exist(dir))
        msgbox('No existe el directorio de ese jugador.');
    else
        set(handles.reproducir,'Enable','on');
        set(handles.recortar,'Enable','on');
        set(handles.guardar,'Enable','on');
        bandera = 'senal';
        load ([dir 'Senal']);
        load ([dir 'Cepstrum']);
        load ([dir 'Parametros']);
        parametros=Parametros;
        senal=Senal(get(handles.variable,'Value'),:);
        plot(senal);
    end
end


% --- Executes on button press in recortar.
function recortar_Callback(hObject, eventdata, handles)
% hObject    handle to recortar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bandera
global senal
global senal_r
set(handles.reproducir,'Enable','on');
set(handles.recortar,'Enable','off');
set(handles.guardar,'Enable','on');

bandera = 'recortada';
senal_r=senal_recortada(senal);
plot(senal_r);


% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global senal
global parametros
if (isempty(get(handles.jugador,'String')))
    msgbox('Introduzca Nombre de Jugador');
else
    dir=['../Docs/' get(handles.jugador,'String') '/'];
    if(~exist(dir))
        Parametros=parametros;
        mkdir('../Docs/', get(handles.jugador,'String'));
        Senal=zeros(10,str2num(Parametros{1})*str2num(Parametros{2}));
        save([dir 'Parametros'], 'Parametros');
        Cepstrum=zeros(10,24);
    else
        load([dir 'Parametros']);
        if(isequal(parametros,Parametros))
            load ([dir 'Senal']);
            load ([dir 'Cepstrum']);
        else
            par=[{'Los parámetros de la señal que intenta almacenar en este jugador no coincide con los ya almacenados.'};
                {['Tiempo: ' Parametros{1}]};
                {['Fs: ' Parametros{2}]};
                {['Canal: ' Parametros{3}]};
                {['Bits: ' Parametros{4}]};
                {['Preénfasis: ' Parametros{5}]};
                {['Desplazamiento: ' Parametros{6}]};
                {['Long. Trama: ' Parametros{7}]};
                {['Ventana: ' Parametros{8}]}];
            msgbox(par);
            return
        end
    end
    Senal(get(handles.variable,'Value'),:)=senal;
    Cepstrum(get(handles.variable,'Value'),:)=cep_coef(senal_recortada(senal),str2num(parametros{5}),str2num(parametros{2}),str2num(parametros{6}),str2num(parametros{7}),parametros{8});
    save ([dir 'Senal'],'Senal')
    save ([dir 'Cepstrum'],'Cepstrum')
end
        



% --- Executes on selection change in variable.
function variable_Callback(hObject, eventdata, handles)
% hObject    handle to variable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns variable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from variable


% --- Executes during object creation, after setting all properties.
function variable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to variable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jugador_Callback(hObject, eventdata, handles)
% hObject    handle to jugador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jugador as text
%        str2double(get(hObject,'String')) returns contents of jugador as a double


% --- Executes during object creation, after setting all properties.
function jugador_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jugador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in eliminar.
function eliminar_Callback(hObject, eventdata, handles)
% hObject    handle to eliminar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isempty(get(handles.jugador,'String')))
    msgbox('Introduzca Nombre de Jugador');
else
    dir=['../Docs/' get(handles.jugador,'String') '/'];
    if(~exist(dir))
        msgbox('No existe el directorio de ese jugador.');
    else
        delete([dir 'Parametros.mat'],[dir 'Red.mat'],[dir 'Senal.mat'],[dir 'Cepstrum.mat']);
        rmdir(dir);
    end
end


function fs_Callback(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs as text
%        str2double(get(hObject,'String')) returns contents of fs as a double


% --- Executes during object creation, after setting all properties.
function fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reproducir.
function reproducir_Callback(hObject, eventdata, handles)
% hObject    handle to reproducir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bandera
global senal
global senal_r

switch bandera
    case 'recortada'
        sound(senal_r,str2num(get(handles.fs,'String')));
    case 'senal'
        sound(senal,str2num(get(handles.fs,'String')));
end


% --- Executes on button press in tresenraya.
function tresenraya_Callback(hObject, eventdata, handles)
% hObject    handle to tresenraya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('../Tres en Raya');
pause(1);
TresenRaya;
close('Capturador');


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(get(handles.jugador,'String')))
    msgbox('Introduzca numbre de Jugador');
else
    dir=['../Docs/' get(handles.jugador,'String') '/'];
    if(~exist(dir))
        msgbox('No existe el directorio de ese jugador.');
    else
        load ([dir 'Senal']);
        numeros=[];
        nombres=get(handles.variable,'String');
        for(i=1:10)
            Nceros=find(Senal(i,:)==0);
            if(length(Nceros)==length(Senal(i,:)))
                numeros=[numeros; nombres(i)];
            end
        end
        if(isempty(numeros))
            load ([dir 'Cepstrum']);
            datos=[Cepstrum'; [1:10]];
            Red=crear_red(datos,24);
            save([dir 'Red'], 'Red');
        else
            nums=[];
            for(i=1:length(numeros))
                nums=[nums, numeros(i)];
            end
            msgbox(['Faltan: ' ,nums]);
        end
    end
end


% --- Executes on selection change in canal.
function canal_Callback(hObject, eventdata, handles)
% hObject    handle to canal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns canal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from canal


% --- Executes during object creation, after setting all properties.
function canal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to canal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bits_Callback(hObject, eventdata, handles)
% hObject    handle to bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bits as text
%        str2double(get(hObject,'String')) returns contents of bits as a double


% --- Executes during object creation, after setting all properties.
function bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pre_Callback(hObject, eventdata, handles)
% hObject    handle to pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre as text
%        str2double(get(hObject,'String')) returns contents of pre as a double


% --- Executes during object creation, after setting all properties.
function pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trama_Callback(hObject, eventdata, handles)
% hObject    handle to trama (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trama as text
%        str2double(get(hObject,'String')) returns contents of trama as a double


% --- Executes during object creation, after setting all properties.
function trama_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trama (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ventana.
function ventana_Callback(hObject, eventdata, handles)
% hObject    handle to ventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ventana contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ventana


% --- Executes during object creation, after setting all properties.
function ventana_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function desp_Callback(hObject, eventdata, handles)
% hObject    handle to desp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of desp as text
%        str2double(get(hObject,'String')) returns contents of desp as a double


% --- Executes during object creation, after setting all properties.
function desp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to desp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
