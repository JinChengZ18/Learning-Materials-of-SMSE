function hold= choose( hold,Odds )
%%如果产生的随机数大于c1，则交换序留下，否则不换

[x,y]=size(hold);
for i=1:x
    for j=1:y
        if rand>Odds
            hold(i,j)=0;
        end
    end
end
end

