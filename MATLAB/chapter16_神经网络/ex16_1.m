clear all
clc
a=4;               %列数
b=4;               %行数
c=5;               %神经元个数
W=ones(c,b);
B=ones(c,a);
P=ones(b,a);
x=W*P+B;          %计算神经网络加权输入
A=tansig(x)         %计算神经网络输出 
