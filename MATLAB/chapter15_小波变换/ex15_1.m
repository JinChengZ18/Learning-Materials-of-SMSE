clear all
clc
N=512;
S=randn(1,N);%��������Ϊ512��ԭʼ�ź�S
[C1,L1]=dwt(S,'db1');%���źŽ��е�һ�ηֽ�
[C2,L2]=dwt(C1,'db1');% ���źŽ��еڶ��ηֽ�
[C3,L3]=dwt(C2,'db1');% ���źŽ��е����ηֽ�
c2=idwt(C3,L3,'db1');% �ؽ��õ��ڶ��ηֽ�ʱ�ĵ�Ƶ����
c1=idwt(c2,L2,'db1');% �ؽ��õ���һ�ηֽ�ʱ�ĵ�Ƶ����
s=idwt(c1,L1,'db1');% �ؽ�ԭʼ�ź�
subplot(6,1,1);
plot(S);
title('ԭʼ�ź�S');
ylabel('S');
xlabel('�ź�����');
subplot(6,1,2);	
plot(C3);
title('���ηֽ��ĵ�Ƶ����');
ylabel('C3');
xlabel('�ź�����');
subplot(6,1,3);
plot(L1);
title('һ�ηֽ��ĸ�Ƶ����');
ylabel('L1');
xlabel('�ź�����');
subplot(6,1,4);
plot(L2);
title('���ηֽ��ĸ�Ƶ����');
ylabel('L2');
xlabel('�ź�����');
subplot(6,1,5);
plot(L3);
title('���ηֽ��ĸ�Ƶ����');
ylabel('L3');
xlabel('�ź�����');
subplot(6,1,6);
plot(s);
title('�ؽ��ź�S');
ylabel('s');
xlabel('�ź�����');