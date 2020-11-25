%求出群体中适应值最大的个体及其适应值
function [bestindividual,bestfit]=best(pop,fitvalue)
global popsize N length;
bestindividual=pop(1,:);
bestfit=fitvalue(1);
for i=2:popsize
    if fitvalue(i)>bestfit     % 最大的个体
       bestindividual=pop(i,:);
       bestfit=fitvalue(i);
    end
end
