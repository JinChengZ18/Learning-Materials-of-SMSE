clear all
clc
x=zeros(1,10);
[x1,x2,f] = PSO_im(@imF,60,2,2,0.8,800,5,0.0000001,10,0.6,0.0000000000000000001,0);
%得到出计算结果
disp('*************************************************');
disp('目标函数取最小值时的自变量：');
x1
x2
disp('目标函数的最小值为：')
f
disp('**************************************************');