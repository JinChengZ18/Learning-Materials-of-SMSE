clc
clear all

x1=-2:0.02:2;   
x2=-2:0.02:2;

y=18+x1.^2-8*sin(2*pi*x1)+5*x2.^2-3*cos(2*pi*x2); 

net=newrbe([x1;x2],y)
t=sim(net,[x1;x2]);
figure(1)
plot3(x1,x2,y,'rd');
hold on;
plot3(x1,x2,t,'b-.');
view(100,25)
title('ÄâºÏÐ§¹û')
xlabel('x1')
ylabel('x2')
zlabel('y')
grid on 
