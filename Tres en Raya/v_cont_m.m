function ret = v_cont_m(v,m)
%Nos indica si algunas de las filas de la matriz m solo
%encontramos elementos del vector v.
    f=zeros(length(m),1);
    for i=1:length(v)
        [aux,b]=find(m==v(i));
        f(aux)=f(aux)+1;
    end
    if (find(f==size(m,2)))
        ret = 1;
    else
        ret = 0;
    end
end