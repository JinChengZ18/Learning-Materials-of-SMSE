clear all
clc
x=zeros(1,10);
[xm,fv] = PSO_adp(@fitness,40,1.5,1.5,0.7,0.7,200,2)
%取自变量
xm;
%取函数最小值
fv;