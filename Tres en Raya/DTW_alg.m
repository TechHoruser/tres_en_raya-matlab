function DTW = DTW_alg(p,t)
    n=length(p);
    m=length(t);
    DTW=zeros(n+1,m+1);
    for i=2:n+1
        DTW(i,1)=Inf;
    end
    for i=2:m+1
        DTW(1,i)=Inf;
    end
    
    for i=2:n+1
        for j=2:m+1
            distancia=abs(p(i-1)-t(j-1));
            DTW(i,j) = distancia+min([DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)]);
        end
    end
end