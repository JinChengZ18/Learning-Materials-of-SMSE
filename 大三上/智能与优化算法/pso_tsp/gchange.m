function ChangeNums = gchange( Group,BestVar)
%�õ�������ChangeNums
Group=Group';
BestVar=BestVar';
[x,y]=size(Group);
ChangeNums=zeros(x,y);
for i=1:y
    pop=BestVar(:,i);%��BestVarȡ��һ��˳��
    pop1=Group(:,i);%������Ⱥ��ȡ����Ӧ��˳��
    for j=1:x  %��BestVar��˳����ȡ��һ�����
        NoFromBestVar=pop(j);
        for k=1:x    %�Ӷ�Ӧ������˳����ȡ��һ�����
            NoFromGroup=pop1(k);
            if(NoFromBestVar==NoFromGroup)&&(j~=k)  %�������ͬ�Ҳ���ͬһλ��
                ChangeNums(j,i)=k;    %������
                pop1(k)=pop1(j);
                pop1(j)=NoFromGroup;
            end
        end
    end
end
ChangeNums=ChangeNums';
end

