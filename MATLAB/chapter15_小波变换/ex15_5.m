clear all
clc
load nelec;  								%װ���ź�
index=1:256;
x=nelec(index);
[c,l]=wavedec(x,6,'haar');  				% ��С��haar���źŽ���6��ֽ�
alpha=1.3;
[thr,nkeep]=wdcbm(c,l,alpha); 				% ��ȡ�ź�ѹ������ֵ
[xd,cxd,lxd,perf0,perfl2]=wdencmp('lvd',c,l,'haar',6,thr,'s');  	
% ���źŽ���ѹ��
subplot(2,1,1);  
plot(index,x);  
title('��ʼ�ź�');  
subplot(2,1,2);  
plot(index,xd);  
title('����ѹ��������ź�');