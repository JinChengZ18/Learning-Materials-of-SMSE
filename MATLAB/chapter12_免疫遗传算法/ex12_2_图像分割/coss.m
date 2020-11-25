%均匀杂交
function pop=coss(pop,cross_rate,popsize,lanti)  
j=1;
for i=1:popsize   %选择进行抗体交叉的个体
    p=rand;
    if p<cross_rate
        parent(j,:)=pop(i,:);
        a(1,j)=i;
        j=j+1;
    end
end
j=j-1;
if rem(j,2)~=0
    j=j-1;
end
for i=1:2:j
    p=2*rand(1,lanti)-1;   %随机生成一个模版
    p=hardlim(p);
    for k=1:lanti
        if p(1,k)==1
            pop(a(1,i),k)=parent(i+1,k);
            pop(a(1,i+1),k)=parent(i,k);
        end
    end
end