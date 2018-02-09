function DTW = DTW_Rest_Globales(p,t,w)
    n=length(p);
    m=length(t);
    w=max([w abs(n-m)]);
    %DTW=zeros(n+1,m+1);
    for i=1:n+1
        for j=1:m+1
            DTW(i,j)=Inf;
        end
    end
    DTW(1,1)=0;
   
    
    for i=2:n+1
        for j=max([2 i-w]):min([m+1 i+w])
            distancia=abs(p(i-1)-t(j-1));
            DTW(i,j) = distancia+min([DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)]);
        end
    end
    DTW
end