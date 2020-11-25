clear all
clc 
popsize=20; 							%Ⱥ���С  
chromlength=10; 						%�ַ������ȣ����峤�ȣ� 
pc=0.8;   							%�������
pm=0.006;                                 %�������
pop=initpop(popsize,chromlength);             %���������ʼȺ�� 
for i=1:30                                  %30Ϊ��������
[objvalue]=calobjvalue(pop);                   %����Ŀ�꺯�� 
fitvalue=calfitvalue(objvalue);                  %����Ⱥ����ÿ���������Ӧ��
[newpop]=selection(pop,fitvalue);               %���� 
[newpop]=crossover(pop,pc);                   %���� 
[newpop]=mutation(pop,pc);                    %���� 
[bestindividual,bestfit]=best(pop,fitvalue);		  %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ 
y(i)=max(bestfit); 
n(i)=i;  
pop5=bestindividual;  
x(i)=decodechrom(pop5,1,chromlength)*10/1023; 
pop=newpop; 
end  
fplot('11*sin(7*x)-7*cos(3*x)',[0 11])
hold on
plot(x,y,'r*')
hold off
f=max(y)
