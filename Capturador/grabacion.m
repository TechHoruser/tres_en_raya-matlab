function senal=grabacion(t,Fs,Ch,bits)
if nargin==3 bits=16; end
recObj=audiorecorder(Fs,bits,Ch);
h=msgbox('Grabando');
delete(findobj(h,'string','OK'));
delete(findobj(h,'style','frame'));
recordblocking(recObj,t);
delete(h);
senal=getaudiodata(recObj);
end

