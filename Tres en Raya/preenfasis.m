function [senal] = preenfasis(y,a)
    senal = filter([1 -a],1,y);
end