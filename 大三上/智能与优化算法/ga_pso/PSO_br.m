% 求解函数的极小值
function [xm,fv,xn,yn] = PSO_br(fitness,N,c1,c2,w,bc,bs,M,D)
format long;
% fitness学习函数
% N初始化群体个体数目
% c1学习因子1
% c2学习因子2
% w惯性权重
% bc杂交概率
% bs杂交池的大小比例
% M最大迭代次数
% D搜索空间维数
% xm目标函数取最小值时的自变量
% fv目标函数最小值
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%初始化种群的个体%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:D
        x(i,j)=randn;  %随机初始化位置
        v(i,j)=randn;  %随机初始化速度
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%先计算各个粒子的适应度，并初始化Pi和Pg%%%%%%%%%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg = x(N,:);             %Pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%进入主要循环，按照公式依次迭代%%%%%%%%%%%%%%%%%
for t=1:M
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
        r1 =rand();
        if r1 < bc
            numPool = round(bs*N);
            PoolX = x(1:numPool,:);
            PoolVX = v(1:numPool,:);
            for i=1:numPool
                seed1 = floor(rand()*(numPool-1)) + 1;
                seed2 = floor(rand()*(numPool-1)) + 1;
                pb = rand();
                childx1(i,:) = pb*PoolX(seed1,:) + (1-pb)*PoolX(seed2,:);
                 childv1(i,:) = (PoolVX(seed1,:) + PoolVX(seed2,:))*norm(PoolVX(seed1,:))/ ...
                    norm(PoolVX(seed1,:) + PoolVX(seed2,:));
            end
            x(1:numPool,:) = childx1;
            v(1:numPool,:) = childv1;
        end
    end
    xn(t) = pg';
    yn(t) = fitness(pg);
end
xm = pg';
fv = fitness(pg);
