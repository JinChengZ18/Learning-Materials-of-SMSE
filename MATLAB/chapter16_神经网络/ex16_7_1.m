clear all
clc
[x1,x2]=meshgrid(0:0.05:1,0:0.05:1);
y=0.2*(pi*(x1.^2)).*cos(pi*x2.^2);            %��ú������ֵ
x11=reshape(x1,441,1);                      %�����������Ϊ������
x12=reshape(x2,441,1);
y1=reshape(y,441,1);                        %�����������Ϊ������
trnData=[x11(1:2:441) x12(1:2:441) y1(1:2:441)]; %����ѵ������
chkData=[x11 x12 y1];                       %�����������
numMFs=6;                                   %����������������
mfType='gbellmf';                           %����������������
epoch_n=30;                                 %����ѵ������
in_fisMat=genfis1(trnData,numMFs,mfType);   %����genfis1������ѵ������ֱ������ģ������ϵͳ
out_fisMat=anfis(trnData,in_fisMat,30);     %ѵ��ģ��ϵͳ
y11=evalfis(chkData(:,1:2),out_fisMat);     %�ò������ݲ���ϵͳ
x111=reshape(x11,21,21);
x112=reshape(x12,21,21);
y111=reshape(y11,21,21);
figure(1)
subplot(2,2,1),
mesh(x1,x2,y);
title('�������');
subplot(2,2,2),
mesh(x111,x112,y111);
title('ʵ�����');
subplot(2,2,3),
mesh(x1,x2,(y-y111));
title('���');
[x,mf]=plotmf(in_fisMat,'input',1);
[x,mf1]=plotmf(out_fisMat,'input',1);
subplot(2,2,4),
plot(x,mf,'r-',x,mf1,'k--');
title('�����Ⱥ����仯');
figure(2)
gensurf(out_fisMat)
title('�������������ϵͼ');
xlabel('����x1');  
ylabel('����x2'); 
zlabel('���y'); 