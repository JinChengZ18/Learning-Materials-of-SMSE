function [xm,fv] = PSO_adp(fitness,N,c1,c2,wmax,wmin,M,D)
format long;
% fitnessѧϰ����
% c1ѧϰ����1
% c2ѧϰ����2
% wmax����Ȩ�����ֵ
% wmin����Ȩ����ֵС
% M����������
% D�����ռ�ά��
% N��ʼ��Ⱥ�������Ŀ
% xmĿ�꺯��ȡ��Сֵʱ���Ա���
% fvĿ�꺯����Сֵ
%��ʼ����Ⱥ�ĸ���
for i=1:N
    for j=1:D
        x(i,j)=randn;  
        v(i,j)=randn;  
    end
end
%�ȼ���������ӵ���Ӧ��
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);             %Pg��ʾȫ������
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
%������Ҫѭ��
for t=1:M
    for j=1:N
        fv(j) = fitness(x(j,:));
    end
    fvag = sum(fv)/N;
    fmin = min(fv);
    for i=1:N
        if fv(i) <= fvag
            w = wmin + (fv(i)-fmin)*(wmax-wmin)/(fvag-fmin);
        else
            w = wmax;
        end
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
end
%�õ���������
disp('*************************************************');
disp('Ŀ�꺯��ȡ��Сֵʱ���Ա�����');
xm=pg'
disp('Ŀ�꺯������СֵΪ��')
fv=fitness(pg)
disp('**************************************************');