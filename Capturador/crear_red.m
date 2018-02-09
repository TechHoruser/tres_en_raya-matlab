function net = crear_clasificador(datos, ocultas)
%Nos crea una red neuronal (la variable 'ocultas' puede ser omitida).
    [c, n]=size(datos);
    numClases=n;
    if (nargin==1)
        ocultas=round(numClases+c/2);
    end
        
    S=eye(numClases,numClases);
    
    clases=datos(c,:);
    c=c-1;
    datos=datos(1:c,:);
    
    %Capas ocultas y de salida con sigmoide
    net=newff(datos,S(clases,:)',ocultas);
    net=train(net,datos,S(clases,:)');
end