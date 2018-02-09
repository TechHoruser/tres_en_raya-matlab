function salida = magnitud(segmentos,ventana)
ventanas=enventanado(segmentos,ventana);
salida=sum(abs(ventanas));
end