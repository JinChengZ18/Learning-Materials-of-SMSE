function select()
global fitness popsize sumfitness oldpop temp mp np
sumfitness=0;                       %个体适应度之和
for i=1:(popsize-np-mp)               % 仅计算(popsize-np-mp)个个体的选择概率
    sumfitness=sumfitness+fitness(1,i);
end
for i=1:(popsize-mp-np)               % 仅计算(popsize-np-mp)个个体的选择概率
    p(1,i)=fitness(1,i)/sumfitness;       % 个体染色体的选择概率
end
q=cumsum(p);                      % 个体染色体的累积概率（内部函数），共(popsize-np-mp)个
b=sort(rand(1,(popsize-mp)));          % 产生(popsize-mp)个随机数，并按升序排列。mp为保护个体数
j=1;
k=1;
while j<=(popsize-mp)      % 从(popsize-mp-np)中选出(popsize-mp)个个体，并放入temp(j,:)中；
    if b(1,j)<q(1,k)
       temp(j,:)=oldpop(k,:);
       j=j+1;
    else
       k=k+1;
    end
end
j=popsize-np-mp+1;   % 从统一挪过来的（popsize-np-mp）以后个体——优秀个体中选择
for i=(popsize-mp+1):popsize % 将mp个保留个体放入交配池temp(i,:)，以保证群体数popsize
    temp(i,:)=oldpop(j,:);
    j=j+1;
end
