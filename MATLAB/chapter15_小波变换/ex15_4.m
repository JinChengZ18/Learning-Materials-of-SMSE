clear all
clc
N=150;
t=1:N;
x=sin(0.4*t);
%������
load noissin;
ns=noissin;
%��ʾ����
subplot(3,1,1);
plot(t,x);
title('ԭʼ�����ź�');
subplot(3,1,2);
plot(ns);
title('�������Ҳ�');
%С��ȥ��
xd=wden(ns,'minimaxi','s','one',4,'db3');
subplot(3,1,3);
plot(xd);
title('ȥ�����������ź�');
