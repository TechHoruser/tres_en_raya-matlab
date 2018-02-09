function [pos] = num_pos(num)
    pos(1)=round((num+1)/3);
    pos(2)=mod(num-1,3)+1;
end