%子程序：计算适应度函数, 函数名称存储为fitnessfun function 
function [Fitvalue,cumsump]=fitnessfun(population);
global BitLength
global boundsbegin
global boundsend 
popsize=size(population,1);   %计算个体个数
for i=1:popsize   
    x=transform2to10(population(i,:));  %将二进制转换为十进制     
    %转化为[-1,1]区间的实数    
    xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1); 
    Fitvalue(i)=targetfun(xx);  %计算函数值，即适应度
end
%给适应度函数加上一个大小合理的数以便保证种群适应值为正数 
Fitvalue=Fitvalue'; 
%计算选择概率
fsum=sum(Fitvalue);  
Pperpopulation=Fitvalue/fsum;  %适应度归一化
%计算累积概率
cumsump(1)=Pperpopulation(1) ;
for i=2:popsize   
    cumsump(i)=cumsump(i-1)+Pperpopulation(i)  ;%求累计概率 
end
cumsump=cumsump' ;  %累计概率  
end

