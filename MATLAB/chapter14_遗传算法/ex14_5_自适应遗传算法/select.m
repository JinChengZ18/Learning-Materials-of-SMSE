function select()
global fitness popsize sumfitness oldpop temp mp np
sumfitness=0;                       %������Ӧ��֮��
for i=1:(popsize-np-mp)               % ������(popsize-np-mp)�������ѡ�����
    sumfitness=sumfitness+fitness(1,i);
end
for i=1:(popsize-mp-np)               % ������(popsize-np-mp)�������ѡ�����
    p(1,i)=fitness(1,i)/sumfitness;       % ����Ⱦɫ���ѡ�����
end
q=cumsum(p);                      % ����Ⱦɫ����ۻ����ʣ��ڲ�����������(popsize-np-mp)��
b=sort(rand(1,(popsize-mp)));          % ����(popsize-mp)��������������������С�mpΪ����������
j=1;
k=1;
while j<=(popsize-mp)      % ��(popsize-mp-np)��ѡ��(popsize-mp)�����壬������temp(j,:)�У�
    if b(1,j)<q(1,k)
       temp(j,:)=oldpop(k,:);
       j=j+1;
    else
       k=k+1;
    end
end
j=popsize-np-mp+1;   % ��ͳһŲ�����ģ�popsize-np-mp���Ժ���塪�����������ѡ��
for i=(popsize-mp+1):popsize % ��mp������������뽻���temp(i,:)���Ա�֤Ⱥ����popsize
    temp(i,:)=oldpop(j,:);
    j=j+1;
end
