function [x,y,Result]=PSO_immu(func,N,c1,c2,w,MaxDT,D,eps,DS,replaceP,minD,Psum)
format long;
%%%%%%给定初始化条件%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1=1.2;             %学习因子1
c2=1.2;             %学习因子2
w=0.8;            %惯性权重
MaxDT=800;        %最大迭代次数
D=2;              %搜索空间维数（未知数个数）
N=60;            %初始化群体个体数目
eps=10^(-10);     %设置精度(在已知最小值时候用)
DS=8;             %每隔DS次循环就检查最优个体是否变优
replaceP=0.5;     %粒子的概率大于replaceP将被免疫替换
minD=1e-10;       %粒子间的最小距离
Psum=0;           %个体最佳的和
range=100;
count = 0;
%%%%%%初始化种群的个体%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:D
        x(i,j)=-range+2*range*rand;  %随机初始化位置
        v(i,j)=randn;  %随机初始化速度
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%先计算各个粒子的适应度，并初始化Pi和Pg%%%%%%%%%%%%%%%%%%% 
for i=1:N    
    p(i)=feval(func,x(i,:));
    
    y(i,:)=x(i,:);
end
pg=x(1,:);             %Pg为全局最优
for i=2:N
    if feval(func,x(i,:))<feval(func,pg)    
        pg=x(i,:);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%主循环，按照公式依次迭代，直到满足精度要求%%%%%%% 
for t=1:MaxDT
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if feval(func,x(i,:))<p(i) 
            p(i)=feval(func,x(i,:)); 
            y(i,:)=x(i,:);
        end
        if p(i)<feval(func,pg)  
            pg=y(i,:);
            subplot(1,2,1);            
            bar(pg,0.25); 
            axis([0 3 -40 40 ]) ;
            title (['Iteration  ', num2str(t)]); pause (0.1);
            subplot(1,2,2); 
          plot(pg(1,1),pg(1,2),'rs','MarkerFaceColor','r', 'MarkerSize',8)
            hold on;
            plot(x(:,1),x(:,2),'k.');
            set(gca,'Color','g')
            hold off;
            grid on;
            axis([-100 100 -100 100 ]) ;
            title(['Global Min =  ',num2str(p(i))]);
            xlabel(['Min_x= ',num2str(pg(1,1)),'  Min_y= ',num2str(pg(1,2))]);
            
        end
    end
    Pbest(t)=feval(func,pg) ;   
%     if Foxhole(pg,D)<eps                %如果结果满足精度要求则跳出循环
%         break;
%     end
%%%%%开始进行免疫%%%%%%%%%%%%%%%%%
    if t>DS
       if mod(t,DS)==0 && (Pbest(t-DS+1)-Pbest(t))<1e-020    %如果连续DS代数，群体中的最优没有明显变优，则进行免疫.
            %在函数测试的过程中发现，经过一定代数的更新，个体最优不完全相等，但变化非常非常小，
           for i=1:N                            %先计算出个体最优的和
             Psum=Psum+p(i);
           end
           
           for i=1:N                            %免疫程序              
               
               for j=1:N                        %计算每个个体与个体i的距离
                   distance(j)=abs(p(j)-p(i));
               end
               num=0;   
               for j=1:N                        %计算与第i个个体距离小于minD的个数
                   if distance(j)<minD
                       num=num+1;
                   end
               end
               PF(i)=p(N-i+1)/Psum;             %计算适应度概率
               PD(i)=num/N;                     %计算个体浓度
               
               a=rand;                          %随机生成计算替换概率的因子
               PR(i)=a*PF(i)+(1-a)*PD(i);       %计算替换概率
           end
           
            for i=1:N
                if PR(i)>replaceP
                    x(i,:)=-range+2*range*rand(1,D);
               count=count+1;
                end
           end
       end
    end    
end
 
%%%%%%%最后给出计算结果%%%%%%%%%%%%%%%%%%%%
x=pg(1,1);
y=pg(1,2);
Result=feval(func,pg);
%%%%%%%%%%算法结束%%%%%%%%%%%%%%%%%%
function probabolity(N,i)
PF=p(N-i)/Psum;%适应度概率
disp(PF);
for jj=1:N
  distance(jj)=abs(P(jj)-P(i));
end
num=0;
for ii=1:N
    if distance(ii)<minD
        num=num+1;
    end
end
PD=num/N;            %个体浓度
PR=a*PF+(1-a)*PD;     %替换概率