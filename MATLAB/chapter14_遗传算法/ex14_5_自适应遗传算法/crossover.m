function crossover()
global temp popsize pcross lchrom mp
n=floor(pcross*(popsize-mp));           %交叉发生的次数（向下取整）
if rem(n,2)~=0                          % 求余
    n=n+1;                              % 保证为偶数个个体，便于交叉操作
end
j=1;
m=0;
% 对(popsize-mp)个个体将进行随机配对，满足条件者将进行交叉操作（按顺序选择要交叉的对象）
for i=1:(popsize-mp)  
    p=rand;                            % 产生随机数
    if p<pcross                         % 满足交叉条件
        parent(j,:)=temp(i,:);              % 选出1个父本
        k(1,j)=i;
        j=j+1;                         % 记录父本个数
        m=m+1;                       % 记录杂交次数
        if (j==3)&(m<=n)              % 满足两个父本(j==3)，未超过交叉次数(m<=n)
            pos=round(rand*(lchrom-1))+1;    % 确定随机位数（四舍五入取整）
            for i=1:pos
                child1(1,i)=parent(1,i);
                child2(1,i)=parent(2,i);
            end
            for i=(pos+1):lchrom
                child1(1,i)=parent(2,i);
                child2(1,i)=parent(1,i);
            end
            i=k(1,1);
            j=k(1,2);
            temp(i,:)=child1(1,:);
            temp(j,:)=child2(1,:);
            j=1;            
        end
    end
end
