clear all
clc 
popsize=40; 							%Ⱥ���С  
chromlength=10; 						%�ַ������ȣ����峤�ȣ� 
pc=0.8;   							%�������
pm=0.006;                                 %�������
pop=initpop(popsize,chromlength);             %���������ʼȺ��

% fitvalue��Ϊ����ֵ��������ѡ��fitvalue��Ľ�
for i=1:20                                  %40Ϊ��������
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

%����������
[fm,max_index] = max(y)
disp('*************************************************');
disp('Ŀ�꺯��ȡ��Сֵʱ���Ա�����');
xm = x(max_index)
disp('Ŀ�꺯������СֵΪ��')
fm
disp('**************************************************');

figure(1) % ���ƺ������߼�����ϵ����Ž⡢����ֵ
fplot(@(x)-11*sin(7*x)+7*cos(3*x)-5*sin(6*x),[0 11])
hold on
plot(x,y,'r*')
hold off

figure(2) % ���Ƹ�����������ֵ
plot(n,y)

%function [objvalue]=calobjvalue(pop)
%temp1=decodechrom(pop,1,10); %��popÿ��ת����ʮ������
%x=temp1*10/1023; %����ֵ�� �е���ת��Ϊ������ ����
%objvalue=10*sin(5*x)+7*cos(4*x); %����Ŀ�꺯��ֵ
%end
