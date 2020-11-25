function selfmutation()
global i popsize lchrom pmutation temp newpop oldpop mp fitness avgfitness maxfitness
m=lchrom*(popsize-mp);               % 总的基因数
pm1=pmutation;
pm2=0.005;
a=0;
b=10;
for i=1:popsize
    chrom=oldpop(i,:);
    c=decimal(chrom);
    varible(1,i)=a+c*(b-a)/(2.^lchrom-1);  %对应变量值
    fitness(1,i)=varible(1,i)*sin(10*varible(1,i))+2; %目标函数
    if(fitness(1,i)>=avgfitness)
     pmutatio = pm1-(pm1-pm2)*(fitness(1,i)-avgfitness)/(maxfitness-avgfitness);
        else
            pmutation = pm1;   
    end
end
n=round(pmutation*m);                % 变异发生的次数
for i=1:n                             % 执行变异操作循环
    k=round(rand*(m-1))+1;            %确定变异位置（四舍五入取整）
    j=ceil(k/lchrom);                  % 确定个体编号（取整）
    l=rem(k,lchrom);                  %确定个体中变位基因的位置（求余）
    if l==0
       temp(j,lchrom)=~temp(j,lchrom);  % 取非操作
    else
       temp(j,l)=~temp(j,l);            % 取非操作
    end
end
for i=1:popsize
    newpop(i,:)=temp(i,:);     %产生新的个体
    oldpop(i,:)=newpop(i,:);
end
