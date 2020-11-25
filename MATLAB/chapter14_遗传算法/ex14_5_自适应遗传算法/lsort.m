function lsort()
global popsize fitness oldpop
for i=1:popsize
    j=i+1;
    while j<=popsize
        if fitness(1,i)>fitness(1,j)    
            tf=fitness(1,i);            % 适应度值
            tc=oldpop(i,:);            % 基因代码
            fitness(1,i)=fitness(1,j);     % 适应度值互换
            oldpop(i,:)=oldpop(j,:);     % 基因代码互换
            fitnescs(1,j)=tf;
            oldpop(j,:)=tc;
        end
        j=j+1;
    end
end
