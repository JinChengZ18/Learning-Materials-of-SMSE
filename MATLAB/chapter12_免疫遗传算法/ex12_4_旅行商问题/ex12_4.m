clear all
clc
N=8;               
%���еĸ���
M=N-1;               
%��Ⱥ�ĸ���
pos=randn(N,2);
%%���ɳ��е�����
global D;
%���о�������
D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

%�м�������
global TmpResult;
TmpResult = [];
global TmpResult1;
TmpResult1 = [];

%�����趨
[M, N] = size(D);%��Ⱥ��ģ
pCharChange = 1;%�ַ���λ����
pStrChange = 0.4;%�ַ�����λ����
pStrReverse = 0.4;%�ַ�����ת����
pCharReCompose = 0.4;%�ַ��������
MaxIterateNum = 100;%����������

%���ݳ�ʼ��
mPopulation = zeros(N-1,N);
mRandM = randperm(N-1);%����·��
mRandM = mRandM + 1;
for rol = 1:N-1
    mPopulation(rol,:) = randperm(N);%������ʼ����
    mPopulation(rol,:) = DisplaceInit(mPopulation(rol,:));%Ԥ����
end

%����
count = 0;
figure(2);
while count < MaxIterateNum
    %�����¿���
    B = Mutation(mPopulation, [pCharChange pStrChange pStrReverse pCharReCompose]);
    %�������п�����׺��������п�������ſ�����ų���
    mPopulation = SelectAntigen(mPopulation,B);
    hold on
    plot(count,TmpResult(end),'o');
    drawnow
display(TmpResult(end));
display(TmpResult1(end));
    count = count + 1;
end

hold on
plot(TmpResult,'-r');
title('�����Ӧ�ȱ仯����')
xlabel('������')
ylabel('�����Ӧ��')

mRandM