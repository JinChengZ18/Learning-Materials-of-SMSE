function crossover()
global temp popsize pcross lchrom mp
n=floor(pcross*(popsize-mp));           %���淢���Ĵ���������ȡ����
if rem(n,2)~=0                          % ����
    n=n+1;                              % ��֤Ϊż�������壬���ڽ������
end
j=1;
m=0;
% ��(popsize-mp)�����彫���������ԣ����������߽����н����������˳��ѡ��Ҫ����Ķ���
for i=1:(popsize-mp)  
    p=rand;                            % ���������
    if p<pcross                         % ���㽻������
        parent(j,:)=temp(i,:);              % ѡ��1������
        k(1,j)=i;
        j=j+1;                         % ��¼��������
        m=m+1;                       % ��¼�ӽ�����
        if (j==3)&(m<=n)              % ������������(j==3)��δ�����������(m<=n)
            pos=round(rand*(lchrom-1))+1;    % ȷ�����λ������������ȡ����
            for i=1:pos
                child1(1,i)=parent(1,i);
                child2(1,i)=parent(2,i);
            end
            for i=(pos+1):lchrom
                child1(1,i)=parent(2,i);
                child2(1,i)=parent(1,i);
            end
            i=k(1,1);
            j=k(1,2);
            temp(i,:)=child1(1,:);
            temp(j,:)=child2(1,:);
            j=1;            
        end
    end
end
