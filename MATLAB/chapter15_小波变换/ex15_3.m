clear all
clc
load leleccum; 		    %装载采集的信号
s=leleccum(1:2000); 	%将信号中第1到第1000个采样点赋给s
ls=length(s);
subplot(2,2,1);
plot(s);
title('原始信号图形');
grid on
%用db1小波对原始信号进行3层分解并提取系数
[c,l]=wavedec(s,3,'db1');
ca3=appcoef(c,l,'db1',3);
cd3=detcoef(c,l,3);
cd2=detcoef(c,l,2);
cd1=detcoef(c,l,1);
%对信号进行强制性去噪处理并图示结果
cdd3=zeros(1,length(cd3));
cdd2=zeros(1,length(cd2));
cdd1=zeros(1,length(cd1));
c1=[ca3 cdd3 cdd2 cdd1];
s1=waverec(c1,l,'db1');
subplot(2,2,3);
plot(s1);
title('强制去噪后的信号');
grid on
%用默认阈值对信号进行去噪处理并图示结果
%用ddencmp()函数获得信号的默认阈值,使用wdencmp()命令函数实现去噪过程
[thr,sorh,keepapp]=ddencmp('den','wv',s);
s2=wdencmp('gbl',c,l,'db1',3,thr,sorh,keepapp);
subplot(2,2,2);
plot(s2);
title('默认阈值去噪后的信号');
grid on
%用给定的软阈值进行去噪处理
cd1soft=wthresh(cd1,'s',2.65);
cd2soft=wthresh(cd2,'s',1.53);
cd3soft=wthresh(cd3,'s',1.76);
c2=[ca3 cd3soft cd2soft cd1soft];
s3=waverec(c2,l,'db1');
subplot(2,2,4);
plot(s3);
title('给定软阈值去噪后的信号');
grid on
