function [salida] = enventanado(segmentos,ventana)
    N = size(segmentos,1);
    switch(ventana)
        case 'rectwin', vent=rectwin(N);
        case 'hamming', vent=hamming(N);
        case 'hanning', vent=hanning(N);
        case 'bartlett', vent=bartlett(N);
    end
    
    for i = 1:size(segmentos,2)
        salida(:,i) = vent.*segmentos(:,i);
    end
end