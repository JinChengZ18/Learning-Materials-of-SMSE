clear all
clc
[x1,x2]=meshgrid(-2:0.05:2,-2:0.05:2);
y=0.2*(pi*(x1.^2)).*cos(pi*x2.^2);            %求得函数输出值
x11=reshape(x1,6561,1);
x12=reshape(x2,6561,1);
y1=reshape(y,6561,1);
trnData=[x11(1:2:6561) x12(1:2:6561) y1(1:2:6561)];
chkData=[x11 x12 y1];
numMFs=4;                                   %定义隶属函数个数
mfType='gbellmf';                           %定义隶属函数类型
epoch_n=50;
in_fisMat=genfis1(trnData,numMFs,mfType);
out_fisMat=anfis(trnData,in_fisMat,50);
y11=evalfis(chkData(:,1:2),out_fisMat);
x111=reshape(x11,81,81);
x112=reshape(x12,81,81);
y111=reshape(y11,81,81);
figure(1)
subplot(2,2,1),
mesh(x1,x2,y);
title('期望输出');
subplot(2,2,2),
mesh(x111,x112,y111);
title('实际输出');
subplot(2,2,3),
mesh(x1,x2,(y-y111));
title('误差');
[x,mf]=plotmf(in_fisMat,'input',1);
[x,mf1]=plotmf(out_fisMat,'input',1);
subplot(2,2,4),
plot(x,mf,'r-',x,mf1,'k--');
title('隶属度函数变化');
figure(2)
gensurf(out_fisMat)
title('推理输入输出关系图');
xlabel('输入x1');  
ylabel('输入x2'); 
zlabel('输出y');