function [caracteristicas] = cep_coef(senal,pre,Fs,desp,long,vent)
    senal=preenfasis(senal,pre);
    segmentos = segmentacion(senal,long*Fs/1000,desp*Fs/1000);
    segmentos_enventanados=enventanado(segmentos,vent);

    %% Extracción de características
    %Cepstrum
    aux=rceps(segmentos_enventanados);
    cepstrum=aux(2:13,:);
    clear aux;

    %Delta
    p=2;
    divisor=sum([-p:p].^2);
    aux=[zeros(p,length(cepstrum)); cepstrum; zeros(p,length(cepstrum))];
    aux=aux';
    delta=zeros(size(cepstrum,2));
    for i=1+p:size(aux,2)-p
        for j=-p:p
            delta(:,i-p)=delta(:,i-p)+aux(:,i+j)*j;
        end
        delta(:,i-p)=delta(:,i-p)/divisor;
    end
    delta=delta(:,1:12)';
    
    caracteristicas=[cepstrum;delta];
end

