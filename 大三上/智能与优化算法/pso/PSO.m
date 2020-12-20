% 求函数的全局最小值
function[xm,fv,xn,yn]=PSO(fitness,N,c1,c2,w,M,D) %xn,yn为分步的值
%%%%%%%给定初始化条件%%%%%%%%%%
% c1学习因子1
% c2学习因子6
% w惯性权重
% M最大迭代次数
% D搜索空间维数
% N初始化群体个体数目
%%%%%初始化种群的个体(可以在这里限定位置和速度的范围) %%%%%%%%%%
format long;
for i=1:N
    for j=1:D
        x(i,j)=randn; %随机初始化位置
        v(i,j)=randn; %随机初始化速度
    end
end
%%%%%%先计算各个粒子的适应度，并初始化Pi和Pg%%%%%%%%%%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);             %Pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:)) < fitness(pg)
        pg=x(i,:);
    end
end
%%%%%进入主要循环，按照公式依次迭代，直到满足精度要求%%%%%
for t=1:M
    for i=1:N     %更新速度、位移
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:)) < p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    yn(t)=fitness(pg);
    xn(t)=pg;
end
xm=pg';
fv=fitness(pg);
