clear all
clc
k=9;
p=[-2:0.05:7];
t=1+cos(k*pi/2*p);
figure(1);
plot(p,t,'-');
title('�ƽ������Ժ���');
xlabel('ʱ��');
ylabel('�����Ժ���');

n=7;
net = newff(minmax(p),[n,1],{'tansig' 'purelin'},'trainlm');
y1=sim(net,p);
figure(2);
plot(p,t,'-',p,y1,':')
title('δѵ�������������');
xlabel('ʱ��');
ylabel('�������--ԭ����');

net.trainParam.epochs=300; 	%����ѵ��ʱ������Ϊ300
net.trainParam.goal=0.3;  		%����ѵ����������Ϊ0.3
net=train(net,p,t);        		%��ʼѵ������;

y2=sim(net,p);
figure(3);
plot(p,t,'-',p,y1,':',p,y2, '--')
title('ѵ��ǰ����');
xlabel('ʱ��');
ylabel('�������');