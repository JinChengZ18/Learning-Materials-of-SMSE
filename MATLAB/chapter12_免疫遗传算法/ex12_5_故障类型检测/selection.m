function [newpop]=selection(pop,fitvalue)
global popsize;
fitvalue=hjjsort(fitvalue);
totalfit=sum(fitvalue);          %求适应值之和
fitvalue=fitvalue/totalfit;      %单个个体被选择的概率
fitvalue=cumsum(fitvalue);       %如 fitvalue=[4 2 5 1]，则 cumsum(fitvalue)=[4 6 11 12] 
ms=sort(rand(popsize,1));        %从小到大排列，将"rand(px,1)"产生的一列随机数变成轮盘赌形式的表示方法，由小到大排列
fitin=1;                         %fivalue是一向量，fitin代表向量中元素位，即fitvalue(fitin)代表第fitin个个体的单个个体被选择的概率
newin=1;                     
while newin<=popsize
      if (ms(newin))<fitvalue(fitin)    %ms(newin)表示的是ms列向量中第"newin"位数值，同理fitvalue(fitin)
          newpop(newin,:)=pop(fitin,:); %赋值 ,即将旧种群中的第fitin个个体保留到下一代(newpop)
          newin=newin+1;
      else
          fitin=fitin+1;
      end
end
