clear all
clc
x=zeros(1,10);
[xm,fv] = PSO_line(@LineF,60,1.2,1.2,0.9,0.6,700,2);
%ȡ�Ա���
xm;
%ȡ������Сֵ
fv;