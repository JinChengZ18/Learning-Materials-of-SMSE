clear all
clc
load leleccum; 		    %װ�زɼ����ź�
s=leleccum(1:2000); 	%���ź��е�1����1000�������㸳��s
ls=length(s);
subplot(2,2,1);
plot(s);
title('ԭʼ�ź�ͼ��');
grid on
%��db1С����ԭʼ�źŽ���3��ֽⲢ��ȡϵ��
[c,l]=wavedec(s,3,'db1');
ca3=appcoef(c,l,'db1',3);
cd3=detcoef(c,l,3);
cd2=detcoef(c,l,2);
cd1=detcoef(c,l,1);
%���źŽ���ǿ����ȥ�봦��ͼʾ���
cdd3=zeros(1,length(cd3));
cdd2=zeros(1,length(cd2));
cdd1=zeros(1,length(cd1));
c1=[ca3 cdd3 cdd2 cdd1];
s1=waverec(c1,l,'db1');
subplot(2,2,3);
plot(s1);
title('ǿ��ȥ�����ź�');
grid on
%��Ĭ����ֵ���źŽ���ȥ�봦��ͼʾ���
%��ddencmp()��������źŵ�Ĭ����ֵ,ʹ��wdencmp()�����ʵ��ȥ�����
[thr,sorh,keepapp]=ddencmp('den','wv',s);
s2=wdencmp('gbl',c,l,'db1',3,thr,sorh,keepapp);
subplot(2,2,2);
plot(s2);
title('Ĭ����ֵȥ�����ź�');
grid on
%�ø���������ֵ����ȥ�봦��
cd1soft=wthresh(cd1,'s',2.65);
cd2soft=wthresh(cd2,'s',1.53);
cd3soft=wthresh(cd3,'s',1.76);
c2=[ca3 cd3soft cd2soft cd1soft];
s3=waverec(c2,l,'db1');
subplot(2,2,4);
plot(s3);
title('��������ֵȥ�����ź�');
grid on
