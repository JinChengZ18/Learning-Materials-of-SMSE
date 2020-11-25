clear all
clc
global chrom lchrom oldpop newpop varible fitness  popsize  sumfitness %����ȫ�ֱ���
global pcross pmutation temp bestfit maxfit gen bestgen 
global maxgen po pp mp np
lchrom=18;         %Ⱦɫ�峤��
popsize=80;        %��Ⱥ��С
pcross=0.8;        %�������
pmutation=0.02;     %�������
maxgen=200;        %������
po=0.1;            %��̭����
pp=0.1;            %��������
mp=floor(pp*popsize);  %�����ĸ���
np=floor(po*popsize);  %��̭�ĸ���
initpop;              % ��ʼ����Ⱥ
for gen=1:maxgen
      objfun;                   %������Ӧ��ֵ
      pp_po;                    %ִ�б��Ų���
      select;                   %ѡ�����
      selfmutation;             %�Ա������
      crossover;                %�������
end
best
bestfit           % ��Ѹ�����Ӧ��ֵ���
bestgen           % ��Ѹ������ڴ������
figure
gen=1:maxgen;
plot(gen,maxfit(1,gen));  % ��������
hold on;
plot(bestgen,bestfit);
xlabel('Generation');
ylabel('Fitness');
