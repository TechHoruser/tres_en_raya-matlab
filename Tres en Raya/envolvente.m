function amplitudes = envolvente(tramas_enventanadas)
    % C�lculo de los coeficientes de predicci�n lineal
    num_puntos = 1024;
    transFourier = abs(fft(tramas_enventanadas,num_puntos));
    orden = 12;
    for i=1:size(tramas_enventanadas,2),
        % C�lculo de los coeficientes
        lpcoefs = lpc(tramas_enventanadas(:,i),orden);
        % Estimaci�n de la se�al
        estsenal = filter([0 - lpcoefs(2:end)],1,[tramas_enventanadas(:,i);zeros(orden,1)]);
        % Error
        error = [tramas_enventanadas(:,i);zeros(orden,1)] - estsenal;
        % Ganancia del filtro LPC
        G = sqrt(sum(error .^ 2));
        % Respuesta en frecuencia del sistema
        H = freqz(G,lpcoefs,round(num_puntos/2)+1);
        frecuencias = linspace(0,8000/2,(num_puntos/2)+1);
        amplitudes = abs(H);
        plot(frecuencias,amplitudes);
    end
end