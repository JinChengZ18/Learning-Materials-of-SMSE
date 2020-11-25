clc
clear all

x=rand(2,300);
x=(x-0.5)*1*2;
x1=x(1,:);
x2=x(2,:);

y=18+x1.^2-8*sin(2*pi*x1)+5*x2.^2-3*cos(2*pi*x2); 

net=newrb(x,y);
[n,m]=meshgrid(-1:0.1:1);
row=size(n);
tx1=n(:);
tx1=tx1';
tx2=m(:);
tx2=tx2';
tx=[tx1;tx2];

t=sim(net,tx);
p=reshape(t,row);
subplot(1,3,1)
mesh(n,m,p);
zlim([0,50])
title('仿真结果图象')
%目标函数图像
[x1, x2]=meshgrid(-1:0.1:1);
y=30+x1.^2-5*cos(2*pi*x1)+3*x2.^2-5*cos(2*pi*x2); 
subplot(1,3,2)
mesh(x1,x2,y);
zlim([0,50])
title('目标函数图像')
%目标函数图象和仿真函数图象的误差图像
subplot(1,3,3)
mesh(x1,x2,y-p);
zlim([-0.1,0.05])
title('误差图像')
set(gcf,'position')