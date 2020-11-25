% ��ά�˹������Ż��㷨
% m--�����ģ
% n--ÿ������������ַ�������
% mn--�ӿ��弯����ѡ��n�����нϸ��׺Ͷȵ���Ѹ�����п�¡����
% A--���弯��(m��n),����ĸ���Ϊm,ÿ��������n�������Ʊ���(�������)
% T--��ʱ��ſ�¡Ⱥ��ļ���,��¡��ģ�ǿ�ԭ�׺Ͷȶ����ĵ�����������
% FM--ÿ�������Ӧ��ֵ����
% FMN--ÿ��ƽ����Ӧ��ֵ����
% AAS--ÿ����¡�������±�λ��
% BBS--ÿ�����ſ�¡���±�λ��
% Fit--ÿ����Ӧ��ֵ����
% tnum--��������
% xymin--�Ա�������
% xymax--�Ա�������
% pMutate--��Ƶ�������
% cfactor--��¡(����)����
% Affinity--�׺Ͷ�ֵ��С˳��
%%%%%%%%%%%%%%%%%%
clear all
clc
tic;
m=65;
n=22;
mn=60;
xmin=-10; 
xmax=10;
tnum=100;
pMutate=0.1;
cfactor=0.3;
A=InitializeFun(m,n); %���ɿ��弯��A,������ĿΪm,ÿ��������򳤶�Ϊn
F='X+5*sin(X.*8)+7*cos(X.*3)'; %Ŀ�꺯��
FM=[]; %��Ÿ�������ֵ�ļ���
FMN=[]; %��Ÿ���ƽ��ֵ�ļ���
t=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while t<tnum
    t=t+1;
    X=DecodeFun(A(:,1:22),xmin,xmax); %����������ת����ʮ������
    Fit=eval(F); %��XΪ�Ա�������ֵ����ŵ�����Fit��
    if t==1 
        figure(1)
        fplot(F,[xmin,xmax]); 
        grid on
        hold on
        plot(X,Fit,'k*')
        title('����ĳ�ʼλ�÷ֲ�ͼ')
        xlabel('x')
        ylabel('f(x)')
    end
    if t==tnum
        figure(2)
        fplot(F,[xmin,xmax]);
        grid on
        hold on
        plot(X,Fit,'r*')
        title('���������λ�÷ֲ�ͼ')
        xlabel('x')
        ylabel('f(x)')
    end
    %����ʱ��ſ���ļ������
    T=[]; 
    %�ѵ�t���ĺ���ֵFit����С�����˳�����в���ŵ�FS��
    [FS,Affinity]=sort(Fit,'ascend'); 
    %�ѵ�t���ĺ���ֵ�����갴��С�����˳�����в���ŵ�XT��
    XT=X(Affinity(end-mn+1:end)); 
     %��FS������ȡ��mn����t���ĺ���ֵ��ԭ˳�����в���ŵ�FT��
    FT=FS(end-mn+1:end);
    %�ѵ�t�������ź���ֵ�ӵ�����FM��
    FM=[FM FT(end)]; 
    %��¡(����)����,ѡ��mn����ѡ������п�¡,��¡�����׺Ͷȳ�����,
    %AAS��ÿ����ѡ�����¡����T�еĿ�ʼ����
    [T,AAS]=ReproduceFun(mn,cfactor,m,Affinity,A,T);
    %����ǰ�Ŀ��屣�浽��ʱ��¡Ⱥ��T��
    T=Hypermutation(T,n,pMutate,xmax,xmin); 
    %�Ӵ�С��������Ҫ��¡��mn��ԭʼ����
    AF1=fliplr(Affinity(end-mn+1:end)); 
    %����ǰ�Ŀ��屣�浽��ʱ��¡Ⱥ��T��%����ʱ���弯��T�и����׺Ͷȵ�ֵѡ��mn��
    T(AAS,:)=A(AF1,:); 
    X=DecodeFun(T(:,1:22),xmin,xmax);
     Fit=eval(F);
    AAS=[0 AAS];
    FMN=[FMN mean(Fit)];
    for i=1:mn
        %��¡��Ⱥ�е��׺Ͷ����Ŀ��屻ѡ��
        [OUT(i),BBS(i)]=max(Fit(AAS(i)+1:AAS(i+1))); 
        BBS(i)=BBS(i)+AAS(i);
    end
    %�Ӵ�С��������Ҫ��¡��mn��ԭʼ����
    AF2=fliplr(Affinity(end-mn+1:end)); 
    %ѡ���¡�����mn����Ⱥ�е���ø��屣�浽A��,���ඪʧ
    A(AF2,:)=T(BBS,:); 
end
disp(sprintf('\n The optimal point is:'));
disp(sprintf('\n x: %2.4f, f(x):%2.4f',XT(end),FM(end)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
grid on 
plot(FM)
title('��Ӧֵ�仯����')
xlabel('������')
ylabel('��Ӧֵ')
hold on
plot(FMN,'r')
hold off
