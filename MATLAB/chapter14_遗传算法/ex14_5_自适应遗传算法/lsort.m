function lsort()
global popsize fitness oldpop
for i=1:popsize
    j=i+1;
    while j<=popsize
        if fitness(1,i)>fitness(1,j)    
            tf=fitness(1,i);            % ��Ӧ��ֵ
            tc=oldpop(i,:);            % �������
            fitness(1,i)=fitness(1,j);     % ��Ӧ��ֵ����
            oldpop(i,:)=oldpop(j,:);     % ������뻥��
            fitnescs(1,j)=tf;
            oldpop(j,:)=tc;
        end
        j=j+1;
    end
end
