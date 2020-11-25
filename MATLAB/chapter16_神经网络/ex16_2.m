clear all
clc
k=9;
p=[-2:0.05:7];
t=1+cos(k*pi/2*p);
figure(1);
plot(p,t,'-');
title('逼近非线性函数');
xlabel('时间');
ylabel('非线性函数');

n=7;
net = newff(minmax(p),[n,1],{'tansig' 'purelin'},'trainlm');
y1=sim(net,p);
figure(2);
plot(p,t,'-',p,y1,':')
title('未训练网络的输出结果');
xlabel('时间');
ylabel('仿真输出--原函数');

net.trainParam.epochs=300; 	%网络训练时间设置为300
net.trainParam.goal=0.3;  		%网络训练精度设置为0.3
net=train(net,p,t);        		%开始训练网络;

y2=sim(net,p);
figure(3);
plot(p,t,'-',p,y1,':',p,y2, '--')
title('训练前后结果');
xlabel('时间');
ylabel('仿真输出');