function selfmutation()
global i popsize lchrom pmutation temp newpop oldpop mp fitness avgfitness maxfitness
m=lchrom*(popsize-mp);               % �ܵĻ�����
pm1=pmutation;
pm2=0.005;
a=0;
b=10;
for i=1:popsize
    chrom=oldpop(i,:);
    c=decimal(chrom);
    varible(1,i)=a+c*(b-a)/(2.^lchrom-1);  %��Ӧ����ֵ
    fitness(1,i)=varible(1,i)*sin(10*varible(1,i))+2; %Ŀ�꺯��
    if(fitness(1,i)>=avgfitness)
     pmutatio = pm1-(pm1-pm2)*(fitness(1,i)-avgfitness)/(maxfitness-avgfitness);
        else
            pmutation = pm1;   
    end
end
n=round(pmutation*m);                % ���췢���Ĵ���
for i=1:n                             % ִ�б������ѭ��
    k=round(rand*(m-1))+1;            %ȷ������λ�ã���������ȡ����
    j=ceil(k/lchrom);                  % ȷ�������ţ�ȡ����
    l=rem(k,lchrom);                  %ȷ�������б�λ�����λ�ã����ࣩ
    if l==0
       temp(j,lchrom)=~temp(j,lchrom);  % ȡ�ǲ���
    else
       temp(j,l)=~temp(j,l);            % ȡ�ǲ���
    end
end
for i=1:popsize
    newpop(i,:)=temp(i,:);     %�����µĸ���
    oldpop(i,:)=newpop(i,:);
end
