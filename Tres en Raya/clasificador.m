function num = clasificador(jugada,jugador_actual,jugador_opuesto,tipo,CepDel)
    dir=['../Docs/' jugador_actual '/'];
    load([dir 'Parametros']);
    caracteristicas=cep_coef2(senal_recortada(grabacion(2,str2num(Parametros{2}),str2num(Parametros{3}),str2num(Parametros{4}))),str2num(Parametros{5}),str2num(Parametros{2}),str2num(Parametros{6}),str2num(Parametros{7}),Parametros{8});
    
    load([dir 'Cepstrum']);
    
    ceps=Cepstrum;
    
    dir=['../Docs/' jugador_opuesto '/'];
    load([dir 'Cepstrum']);
    
    ceps(end,:)=Cepstrum(end,:);
    asdf=tipo{1};
    switch (asdf)
        case 'DTW',
            switch CepDel
                case 'Cepstrum'
                    t=ceps(:,1:12);
                    p=caracteristicas(1:12);
                case 'Delta'
                    t=ceps(:,13:24);
                    p=caracteristicas(13:24);
                case 'CepstrumDelta'
                    t=ceps;
                    p=caracteristicas;
            end
            for i=1:10
                DTW(i,:,:)=DTW_alg(p,t(i,:));
            end
            [error, num]=min(DTW(:,end,end));
        case 'DTW (R.G.)',
            w=10;
            for i=1:10
                DTW(i,:,:)=DTW_Rest_Globales(caracteristicas,ceps(i,:),w);
            end
            [error, num]=min(DTW(:,end,end));
        case 'Alineamiento Temporal',
            for i=1:10
                EE(i)=sum(abs(ceps(i,:)'-caracteristicas));
            end
            [error, num]=min(EE);
        case 'Red Neuronal',
            dir=['../Docs/' jugador_actual '/'];
            load([dir 'Red']);
            S=eye(10);
            for i=1:10
                RN(i)=sum(abs(S(i,:)'-Red(caracteristicas)));
            end
            [error, num]=min(RN);
    end
end