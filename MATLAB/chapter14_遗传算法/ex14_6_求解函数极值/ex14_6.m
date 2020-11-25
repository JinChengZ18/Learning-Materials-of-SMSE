%%%%%用遗传算法求解y=20+x.*sin(7*pi*x)在[-1 2]区间上的最大值%%
clear all;  
clc;
global BitLength         %全局变量，计算如果满足求解精度至少需要编码的长度 
global boundsbegin       %全局变量，自变量的起始点 
global boundsend         %全局变量，自变量的终止点 
bounds=[-1 2];           %一维自变量的取值范围 
precision=0.0001;        %运算精度 
boundsbegin=bounds(:,1); 
boundsend=bounds(:,2);   %计算如果满足求解精度至少需要多长的染色体 
BitLength=ceil(log2((boundsend-boundsbegin)' ./ precision)); 
popsize=50;              %初始种群大小  
Generationnmax=15;       %最大代数 
pcrossover=0.80;         %交配概率 
pmutation=0.08;          %变异概率  
population=round(rand(popsize,BitLength));  %初始种群，行代表一个个体，列代表不同个体  
%计算适应度 
[Fitvalue,cumsump]=fitnessfun(population);  %输入群体population，返回适应度Fitvalue和累积概率cumsump 
Generation=1;  
while Generation<(Generationnmax+1)     
    for j=1:2:popsize                       %1对1对的群体进行如下操作（交叉，变异）      
        %选择        
        seln=selection(population,cumsump);  
        %交叉       
        scro=crossover(population,seln,pcrossover);        
        scnew(j,:)=scro(1,:);   
        scnew(j+1,:)=scro(2,:);       
        %变异        
        smnew(j,:)=mutation(scnew(j,:),pmutation);  
        smnew(j+1,:)=mutation(scnew(j+1,:),pmutation);  
    end
    %产生了新的种群 
    population=smnew;
  
    %计算新种群的适应度    
    [Fitvalue,cumsump]=fitnessfun(population);    %记录当前代最好的适应度和平均适应度 
    [fmax,nmax]=max(Fitvalue);                    %最好的适应度为fmax（即函数值最大），其对应的个体为nmax     
    fmean=mean(Fitvalue);                         %平均适应度为fmean   
    ymax(Generation)=fmax;                        %每代中最好的适应度  
    ymean(Generation)=fmean;                      %每代中的平均适应度   
    %记录当前代的最佳染色体个体    
    x=transform2to10(population(nmax,:));%population(nmax,:)为最佳染色体个体  
    xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1);
    xmax(Generation)=xx;    
    Generation=Generation+1 
end
Generation=Generation-1;%Generation加1、减1的操作是为了能记录各代中的最佳函数值xmax(Generation)
targetfunvalue=targetfun(xmax)  
[Besttargetfunvalue,nmax]=max(targetfunvalue) 
Bestpopulation=xmax(nmax)   
%绘制经过遗传运算后的适应度曲线
figure(2);  
hand1=plot(1:Generation,ymax);
set(hand1,'linestyle','-','linewidth',1,'marker','*','markersize',8) 
hold on;  
hand2=plot(1:Generation,ymean); 
set(hand2,'color','k','linestyle','-','linewidth',1, 'marker','h','markersize',8) 
xlabel('进化代数');
ylabel('最大和平均适应度');
xlim([1 Generationnmax]);
legend('最大适应度','平均适应度');
box off;
hold off;    

% %%%%%%%%%%%%计算适应度函数%%%%%%%%%%%%%%%%%%%%%%%% 
% [Fitvalue,cumsump]=fitnessfun(population);
% global BitLength
% global boundsbegin
% global boundsend 
% popsize=size(population,1);             %计算个体个数
% for i=1:popsize   
%     x=transform2to10(population(i,:));  %将二进制转换为十进制     
%     %转化为[-2,2]区间的实数    
%     xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1); 
%     Fitvalue(i)=targetfun(xx);  %计算函数值，即适应度
% end
% %给适应度函数加上一个大小合理的数以便保证种群适应值为正数 
% Fitvalue=Fitvalue'+230 %该处还有一个作用就是决定适应度是有利于选取几个有利个体（加强竞争），海深减弱竞争 
% %计算选择概率
% fsum=sum(Fitvalue)  
% Pperpopulation=Fitvalue/fsum                    %适应度归一化，及被复制的概率
% %计算累积概率
% cumsump(1)=Pperpopulation(1) 
% for i=2:popsize   
%     cumsump(i)=cumsump(i-1)+Pperpopulation(i)  %求累计概率 
% end
% cumsump=cumsump'                               %累计概率    
% 
% %%%%%%%%%%%%计算目标函数%%%%%%%%%%%%%%%%%%%%%%%%
% function y=targetfun(x); %目标函数 
% y=x.*sin(10*pi*x)+2;   
% 
% %%%%%%%%%%%%新种群交叉操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %输入population为种群，seln为选择的两个个体，pc为交配的概率
% function scro=crossover(population,seln,pc);
%     BitLength=size(population,2);   %二进制数的个数 
%     pcc=IfCroIfMut(pc);             %根据交叉概率决定是否进行交叉操作，1则是，0则否 
%     %进行交叉操作  
%     if pcc==1 %进行交叉操作   
%         chb=round(rand*(BitLength-2))+1;  %在[1,BitLength-1]范围内随机产生一个交叉位  
%         scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];  
%         %序号为seln(1)的个体在交叉位chb前面的信息与序号为seln(2)的个体在交叉位chb+1后面的信息重新组合   
%         scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];    
%         %序号为seln(2)的个体在交叉位chb前面的信息与序号为seln(1)的个体在交叉位chb+1后面的信息重新组合
%     else 
%         %不进行交叉操作    
%         scro(1,:)=population(seln(1),:);    
%         scro(2,:)=population(seln(2),:);
%     end
% end
%         
% %%%%%%%%判断遗传运算是否需要进行交叉或变异%%%%%%%%%%%%%%%%%%%% 
% %mutORcro为交叉、变异发生的概率 
% %根据mutORcro决定是否进行相应的操作，产生1的概率是mutORcro，产生0的概率为1-mutORcro
% function pcc=IfCroIfMut(mutORcro); 
% test(1:100)=0;          %1x100的行向量  
% l=round(100*mutORcro);  %产生一个数为100*mutORcro，round为取靠近的整数 
% test(1:l)=1;  
% n=round(rand*99)+1; 
% pcc=test(n); 
% end
%             
%             
% %%%%%%%%%%%%新种群变异操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %snew为一个个体  
% function snnew=mutation(snew,pmutation); 
%     BitLength=size(snew,2);
%     snnew=snew;  
%     pmm=IfCroIfMut(pmutation);            %根据变异概率决定是否进行变异操作，1则是，0则否 
%     if pmm==1    
%         chb=round(rand*(BitLength-1))+1;  %在[1,BitLength]范围内随机产生一个变异位   
%         snnew(chb)=abs(snew(chb)-1);      %0变成1，1变成0 
%     end  
% end
%                     
% %%%%%%%%%%%%新种群选择操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %选择两个个体，返回个体的序号，有可能两个序号相同 
% function seln=selection(population,cumsump); %从种群中选择两个个体 
%     for i=1:2   
%         r=rand;                              %产生一个随机数   
%         prand=cumsump-r;                     %求出cumsump中第一个比r大的元素   
%         j=1;    
%         while prand(j)<0 
%             j=j+1;  
%         end
%         seln(i)=j;                            %选中个体的序号 
%     end
% end
%     
%     
% %%%%%%%%%%%%将2进制数转换为10进制数%%%%%%%%%%%%%%%%%%%%
% function x=transform2to10(Population); 
%     BitLength=size(Population,2);                %Population的列，即2进制的长度
%     x=Population(BitLength);                  
%     for i=1:BitLength-1   
%         x=x+Population(BitLength-i)*power(2,i);  %从末位加到首位
%     end
% end