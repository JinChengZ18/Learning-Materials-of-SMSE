clear all
clc
N=512;
S=randn(1,N);%构建长度为512的原始信号S
[C1,L1]=dwt(S,'db1');%对信号进行第一次分解
[C2,L2]=dwt(C1,'db1');% 对信号进行第二次分解
[C3,L3]=dwt(C2,'db1');% 对信号进行第三次分解
c2=idwt(C3,L3,'db1');% 重建得到第二次分解时的低频部分
c1=idwt(c2,L2,'db1');% 重建得到第一次分解时的低频部分
s=idwt(c1,L1,'db1');% 重建原始信号
subplot(6,1,1);
plot(S);
title('原始信号S');
ylabel('S');
xlabel('信号序列');
subplot(6,1,2);	
plot(C3);
title('三次分解后的低频部分');
ylabel('C3');
xlabel('信号序列');
subplot(6,1,3);
plot(L1);
title('一次分解后的高频部分');
ylabel('L1');
xlabel('信号序列');
subplot(6,1,4);
plot(L2);
title('二次分解后的高频部分');
ylabel('L2');
xlabel('信号序列');
subplot(6,1,5);
plot(L3);
title('三次分解后的高频部分');
ylabel('L3');
xlabel('信号序列');
subplot(6,1,6);
plot(s);
title('重建信号S');
ylabel('s');
xlabel('信号序列');