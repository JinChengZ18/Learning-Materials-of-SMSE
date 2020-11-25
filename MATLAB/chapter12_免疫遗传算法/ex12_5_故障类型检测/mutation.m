%变异操作
function [newpop]=mutation(pop,pm)
global popsize N length;
for i=1:popsize
   if(rand<pm) %产生一随机数与变异概率比较
      mpoint=round(rand*N*length);  % 个体变异位置
     if mpoint<=0
        mpoint=1;
     end
     newpop(i,:)=pop(i,:);
     if newpop(i,mpoint)==0
        newpop(i,mpoint)=1;
     else
        newpop(i,mpoint)=0;
     end
   else
     newpop(i,:)=pop(i,:);
   end
end