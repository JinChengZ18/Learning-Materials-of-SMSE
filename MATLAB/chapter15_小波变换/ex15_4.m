clear all
clc
N=150;
t=1:N;
x=sin(0.4*t);
%加噪声
load noissin;
ns=noissin;
%显示波形
subplot(3,1,1);
plot(t,x);
title('原始正弦信号');
subplot(3,1,2);
plot(ns);
title('含噪正弦波');
%小波去噪
xd=wden(ns,'minimaxi','s','one',4,'db3');
subplot(3,1,3);
plot(xd);
title('去噪后的正波形信号');
