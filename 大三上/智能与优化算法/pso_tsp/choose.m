function hold= choose( hold,Odds )
%%������������������c1���򽻻������£����򲻻�

[x,y]=size(hold);
for i=1:x
    for j=1:y
        if rand>Odds
            hold(i,j)=0;
        end
    end
end
end

