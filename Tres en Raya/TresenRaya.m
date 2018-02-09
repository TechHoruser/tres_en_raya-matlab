function varargout = TresenRaya(varargin)
%TRESENRAYA M-file for TresenRaya.fig
%      TRESENRAYA, by itself, creates a new TRESENRAYA or raises the existing
%      singleton*.
%
%      H = TRESENRAYA returns the handle to a new TRESENRAYA or the handle to
%      the existing singleton*.
%
%      TRESENRAYA('Property','Value',...) creates a new TRESENRAYA using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to TresenRaya_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TRESENRAYA('CALLBACK') and TRESENRAYA('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TRESENRAYA.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TresenRaya

% Last Modified by GUIDE v2.5 10-May-2015 17:23:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TresenRaya_OpeningFcn, ...
                   'gui_OutputFcn',  @TresenRaya_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before TresenRaya is made visible.
function TresenRaya_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for TresenRaya
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
    
    imshow('../Imgs/base.jpeg'); hold on;
    global jugada;
    global M;
    global J1;
    global J2;
    J1='';
    J2='';
    jugada = 0;
    M = zeros(3,3);
    
    %set(handles.text5,'Visible','off')
    %set(handles.alg,'Visible','off')

% UIWAIT makes TresenRaya wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TresenRaya_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global jugada;
global M;
global J1;
global J2;
global vector;



function jugador1_Callback(hObject, eventdata, handles)
% hObject    handle to jugador1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jugador1 as text
%        str2double(get(hObject,'String')) returns contents of jugador1 as a double


% --- Executes during object creation, after setting all properties.
function jugador1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jugador1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jugador2_Callback(hObject, eventdata, handles)
% hObject    handle to jugador2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jugador2 as text
%        str2double(get(hObject,'String')) returns contents of jugador2 as a double


% --- Executes during object creation, after setting all properties.
function jugador2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jugador2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global jugada;
    global M;
    global J1;
    global J2;
    global vector;
    
    %Si alguno de los jugadores cambia pone ambos marcadores a 0
    if (~strcmp(get(handles.jugador1,'String'),J1)||~strcmp(get(handles.jugador2,'String'),J2))
        set(handles.marcador1,'String','0');
        set(handles.marcador2,'String','0');
    end
    
    J1=get(handles.jugador1,'String');
    J2=get(handles.jugador2,'String');
    
    if(isempty(J1))
        msgbox('Introduzca Jugador1.');
    elseif(isempty(J2))
        msgbox('Introduzca Jugador2.');
    else
        dir=['../Docs/' J1 '/'];
        if(~exist(dir))
            msgbox('No existe el directorio del Jugador1.');
        else
            dir=['../Docs/' J2 '/'];
            if(~exist(dir))
                msgbox('No existe el directorio del Jugador2.');
            else
                set(handles.jugador1,'Enable','off');
                set(handles.jugador2,'Enable','off');
                set(handles.capturador,'Enable','off');

                % Desabilitamos el botón para no inicializar 2 grabaciones simultaneas.
                set(handles.grabar,'Enable','off');

                if(mod(jugada,2)==0)
                    jugador_actual=J1;
                    jugador_opuesto=J2;
                else
                    jugador_actual=J2;
                    jugador_opuesto=J1;
                end
                
                var=get(handles.alg,'String');
                num = clasificador(jugada,jugador_actual,jugador_opuesto,var(get(handles.alg,'Value')),'CepstrumDelta');
                
                pos=num_pos(num);

                if (num < 10)
                    if (es_valido(M,pos))
                        vector=[vector; num];
                        M(pos(1),pos(2))=mod(jugada,2)+1;

                        jugada = jugada+1;

                        if (mod(jugada,2)==1)
                            var=imshow('../Imgs/cruz.png');
                        else
                            var=imshow('../Imgs/circulo.png');
                        end

                        set(var,'XData',(pos(2)-1)*95+6,'YData',(pos(1)-1)*95+6);
                        b=es_final(M);

                        if(b>0)
                            switch b
                                case 1,
                                    msgbox('Gana la Cruz');
                                    set(handles.marcador1,'String',...
                                        num2str(str2num(get(handles.marcador1,'String'))+1));
                                case 2,
                                    msgbox('Gana el Circulo');
                                    set(handles.marcador2,'String',...
                                        num2str(str2num(get(handles.marcador1,'String'))+1));
                                case 3,
                                    msgbox('Empate');
                            end
                            pause;
                        end
                    else
                        msgbox(['Posición ' num2str(num) ' ya ocupada.']);
                    end
                else
                    if(~isempty(vector))
                        jugada=jugada-1;
                        var=imshow(['../Imgs/' num2str(vector(end)) '.png']);
                        pos=num_pos(vector(end));
                        vector(end)=[];
                        set(var,'XData',(pos(2)-1)*95+6,'YData',(pos(1)-1)*95+6);
                        M(pos(1),pos(2))=0;
                    else
                        msgbox('No hay nada que elimminar.');
                    end
                end
            end
        end
    end
    
    % Volvemos a habilitar el botón.
    set(handles.grabar,'Enable','on');


% --- Executes on button press in reiniciar.
function reiniciar_Callback(hObject, eventdata, handles)
% hObject    handle to reiniciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    imshow('../Imgs/base.jpeg'); hold on;
    global jugada;
    global M;
    global vector;
    vector =[];
    jugada = 0;
    M = zeros(3,3);
    set(handles.jugador1,'Enable','on');
    set(handles.jugador2,'Enable','on');
    set(handles.capturador,'Enable','on');
    set(handles.grabar,'Enable','on');


% --- Executes on button press in capturador.
function capturador_Callback(hObject, eventdata, handles)
% hObject    handle to capturador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('../Capturador');
pause(1);
Capturador;
close('TresenRaya');


% --- Executes on selection change in alg.
function alg_Callback(hObject, eventdata, handles)
% hObject    handle to alg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alg


% --- Executes during object creation, after setting all properties.
function alg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
