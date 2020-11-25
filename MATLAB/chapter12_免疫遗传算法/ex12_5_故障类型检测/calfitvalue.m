%计算个体的适应值，目标：产生可比较的非负数值
function fitvalue=calfitvalue(objvalue)
fitvalue=objvalue;
global popsize;
Cmin=0;
for i=1:popsize
  if objvalue(i)+Cmin>0     % objvalue 为一列向量
      temp=Cmin+objvalue(i);
   else
      temp=0;
   end
   fitvalue(i)=temp;         % 得一向量
end
end