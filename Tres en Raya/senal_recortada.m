function recortada = senal_recortada(x)
    fs=8000;
    fsize=40e-3;
    x=x(50:end); %eliminamos las 50 primeras ventanas de ruido
    x=x';
    frame_length = round(fs .* fsize);   
    N= frame_length - 1   ;     
    
    for b=1 : frame_length : (length(x)- frame_length),
        y1=x(b:b+N);     
        y = filter([1 -.9378], 1, y1);  %filtro preenfasis

        [B, A]=butter(9,.33,'low');
        y1=filter(B,A,y);
        vec(b:(b + N)) = sum(abs(y1));
    end
    %calculo del inicio fin

    thresh_msf = (((sum(vec)./length(vec)) - min(vec)) .* (0.67) ) + min(vec);
    senal =  vec > thresh_msf;

    longitud=length(senal);
    flag=0;
    sortida(1)=0;
    sortida(2)=0;
    for n=1:longitud-1,
        if (senal(n)==1)&&(flag==0),
            flag=1;
            sortida(1)=n;
        else    
            if (senal(n))==1 && (senal(n+1))==0 && (flag==1),
                sortida(2)=n;

            end
        end
    end
    x=x';
    if(sortida(2)==0)
        sortida(2)=length(x);
    end
    recortada=x(sortida(1):sortida(2));
end



