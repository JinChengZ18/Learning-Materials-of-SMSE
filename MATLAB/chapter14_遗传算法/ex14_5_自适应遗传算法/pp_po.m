function pp_po()
global popsize oldpop np
i=np+1;                      % np=floor(po*popsize);  %淘汰的个数np
j=1;
while i<=popsize   %将（np+1）～popsize的个体放在toldpop中，共（popsize-np）个
    toldpop(j,:)=oldpop(i,:);      
    j=j+1;
    i=i+1;
end
for i=1:(popsize-np)                 %从小到大顺序排列，将前面np个淘汰
    oldpop(i,:)=toldpop(i,:);          % 适应度是否也要互换？
end
