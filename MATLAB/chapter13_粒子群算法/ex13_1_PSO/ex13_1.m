clear all
clc
x=zeros(1,10);
[xm,fv]=PSO(@fitness,40,1.2,2.2,0.6,100,10);
%ȡ�Ա���
xm
%ȡ������Сֵ
fv
