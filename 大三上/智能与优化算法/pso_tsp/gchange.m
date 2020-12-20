function ChangeNums = gchange( Group,BestVar)
%得到交换序ChangeNums
Group=Group';
BestVar=BestVar';
[x,y]=size(Group);
ChangeNums=zeros(x,y);
for i=1:y
    pop=BestVar(:,i);%从BestVar取出一个顺序
    pop1=Group(:,i);%从粒子群中取出对应的顺序
    for j=1:x  %从BestVar的顺序中取出一个序号
        NoFromBestVar=pop(j);
        for k=1:x    %从对应的粒子顺序中取出一个序号
            NoFromGroup=pop1(k);
            if(NoFromBestVar==NoFromGroup)&&(j~=k)  %两个序号同且不在同一位置
                ChangeNums(j,i)=k;    %交换子
                pop1(k)=pop1(j);
                pop1(j)=NoFromGroup;
            end
        end
    end
end
ChangeNums=ChangeNums';
end

