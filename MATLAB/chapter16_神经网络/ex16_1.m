clear all
clc
a=4;               %����
b=4;               %����
c=5;               %��Ԫ����
W=ones(c,b);
B=ones(c,a);
P=ones(b,a);
x=W*P+B;          %�����������Ȩ����
A=tansig(x)         %������������� 
