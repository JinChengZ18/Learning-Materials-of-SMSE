clear all
clc 
popsize=40; 							%群体大小  
chromlength=10; 						%字符串长度（个体长度） 
pc=0.8;   							%交叉概率
pm=0.006;                                 %变异概率
pop=initpop(popsize,chromlength);             %随机产生初始群体

% fitvalue即为函数值，倾向于选择fitvalue大的解
for i=1:20                                  %40为迭代次数
[objvalue]=calobjvalue(pop);                   %计算目标函数 
fitvalue=calfitvalue(objvalue);                  %计算群体中每个个体的适应度
[newpop]=selection(pop,fitvalue);               %复制 
[newpop]=crossover(pop,pc);                   %交叉 
[newpop]=mutation(pop,pc);                    %变异 
[bestindividual,bestfit]=best(pop,fitvalue);		  %求出群体中适应值最大的个体及其适应值 
y(i)=max(bestfit); 
n(i)=i;  
pop5=bestindividual;
x(i)=decodechrom(pop5,1,chromlength)*10/1023; 
pop=newpop; 
end

%给出计算结果
[fm,max_index] = max(y)
disp('*************************************************');
disp('目标函数取最小值时的自变量：');
xm = x(max_index)
disp('目标函数的最小值为：')
fm
disp('**************************************************');

figure(1) % 绘制函数曲线及所拟合的最优解、最优值
fplot(@(x)-11*sin(7*x)+7*cos(3*x)-5*sin(6*x),[0 11])
hold on
plot(x,y,'r*')
hold off

figure(2) % 绘制各世代的最优值
plot(n,y)

%function [objvalue]=calobjvalue(pop)
%temp1=decodechrom(pop,1,10); %将pop每行转化成十进制数
%x=temp1*10/1023; %将二值域 中的数转化为变量域 的数
%objvalue=10*sin(5*x)+7*cos(4*x); %计算目标函数值
%end
