function[xm,fv]=PSO(fitness,N,c1,c2,w,M,D)
%%%%%%%������ʼ������%%%%%%%%%%
% fitness ��Ҫ�Ż���Ŀ�꺯��
% c1ѧϰ����1
% c2ѧϰ����2
% w����Ȩ��
% M����������
% D�����ռ�ά��

% N��ʼ��Ⱥ�������Ŀ
%%%%%��ʼ����Ⱥ�ĸ���(�����������޶�λ�ú��ٶȵķ�Χ) %%%%%%%%%%
format long;
for i=1:N
    for j=1:D
        x(i,j)=randn; %�����ʼ��λ��
        v(i,j)=randn; %�����ʼ���ٶ�
    end
end
%%%%%%�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg%%%%%%%%%%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);             %PgΪȫ������
for i=1:(N-1)
    if fitness(x(i,:)) < fitness(pg)
        pg=x(i,:);
    end
end
%%%%%������Ҫѭ�������չ�ʽ���ε�����ֱ�����㾫��Ҫ��%%%%%
for t=1:M
    for i=1:N     %�����ٶȡ�λ��
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:)) < p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    Pbest(t)=fitness(pg);
end
%%%%%%������������
disp('*************************************************')
disp('Ŀ�꺯��ȡ��Сֵʱ���Ա�����')
xm=pg'
disp('Ŀ�꺯������СֵΪ��')
fv=fitness(pg)
disp('**************************************************')
