clear all
clc
%定义具有2列的目标向量
T = [-1 1; 1 -1;-1 -1];

%绘制Hopfield神经网络稳定空间图形
axis([-1 1 -1 1 -1 1])
set(gca,'box','on'); 
axis manual;  
hold on;
plot3(T(1,:),T(2,:),T(3,:),'r*')
title('Hopfield Network State Space')
xlabel('x(1)');
ylabel('x(2)');
zlabel('x(3)');
view([35 16 50]);

%创建Hopfield神经网络
net = newhop(T);
 
% 随机起始点
a = {rands(3,1)};
%设定Hopfield仿真参数
[y,Pf,Af] = net({1 10},{},a);

%设定一个稳定空间内的活动点
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot3(start(1,1),start(2,1),start(3,1),'bx', ...
   record(1,:),record(2,:),record(3,:))

%循环模拟30个初始条件
color = 'rgbmy';
for i=1:30
   a = {rands(3,1)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kx', ...
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1)) 
end

%使用输入向量P仿真Hopfield神经网络
P = [ 0.1  -1  -0.6  1  1 1; ...
      0   0   0  0  0 0; ...
     -0.1   1   0.6  -1  -1 -1];
cla
plot3(T(1,:),T(2,:),T(3,:),'r*')
color = 'rgbmy';
for i=1:6
   a = {P(:,i)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kx', ...
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1))
end
