clear all
clc
global chrom lchrom oldpop newpop varible fitness  popsize  sumfitness %定义全局变量
global pcross pmutation temp bestfit maxfit gen bestgen 
global maxgen po pp mp np
lchrom=18;         %染色体长度
popsize=80;        %种群大小
pcross=0.8;        %交叉概率
pmutation=0.02;     %变异概率
maxgen=200;        %最大代数
po=0.1;            %淘汰概率
pp=0.1;            %保护概率
mp=floor(pp*popsize);  %保护的个数
np=floor(po*popsize);  %淘汰的个数
initpop;              % 初始化种群
for gen=1:maxgen
      objfun;                   %计算适应度值
      pp_po;                    %执行保优操作
      select;                   %选择操作
      selfmutation;             %自变异操作
      crossover;                %交叉操作
end
best
bestfit           % 最佳个体适应度值输出
bestgen           % 最佳个体所在代数输出
figure
gen=1:maxgen;
plot(gen,maxfit(1,gen));  % 进化曲线
hold on;
plot(bestgen,bestfit);
xlabel('Generation');
ylabel('Fitness');
