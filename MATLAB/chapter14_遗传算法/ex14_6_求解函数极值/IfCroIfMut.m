  %子程序：判断遗传运算是否需要进行交叉或变异, 函数名称存储为IfCroIfMut.m 
  %mutORcro为动作（交叉、变异）发生的概率 
  %根据概率mutORcro决定是否进行操作，产生1的概率是mutORcro，产生0的概率为1-mutORcro
function pcc=IfCroIfMut(mutORcro); 
test(1:100)=0; %1x100的行向量  
l=round(100*mutORcro); %产生一个数为100*mutORcro，round为取靠近的整数 
test(1:l)=1;  
n=round(rand*99)+1; 
pcc=test(n); 
end
            
            
