function b = es_final(M)
%Nos indica si M es o no final, las posibilidades son:
%   b=0 -> M no es final.
%   b=1 -> 1 es ganador.
%   b=2 -> 2 es ganador.
%   b=3 -> M se ha completado y no hay ganador.
    
    v1=find(M==1);
    v2=find(M==2);
    casos_finales = [1 4 7; 1 2 3; 7 8 9; 3 6 9; 1 5 9; 3 5 7; 4 5 6; 2 5 8];
    if (v_cont_m(v1,casos_finales))
        b=1;
    else
        if (v_cont_m(v2,casos_finales))
            b=2;
        else
            if(isempty(find(M==0)))
                b=3;
            else
                b=0;
            end
        end
    end
end