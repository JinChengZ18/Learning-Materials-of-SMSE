function objfun()
global lchrom oldpop fitness popsize chrom maxfit gen varible avgfiness savgfitness
% a=0;b=3;
a=0;b=10;
for i=1:popsize
    chrom=oldpop(i,:);
    c=decimal(chrom);
    varible(1,i)=a+c*(b-a)/(2.^lchrom-1);  %对应变量值
    fitness(1,i)=varible(1,i)*sin(10*varible(1,i))+2;
end
avgfitness=sum(fitness)/popsize;
lsort;  % 个体排序
maxfit(1,gen)=max(fitness);        %求本代中的最大适应度值maxfit
