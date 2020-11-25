clear all
clc
%�������2�е�Ŀ������
T = [-1 1; 1 -1;-1 -1];

%����Hopfield�������ȶ��ռ�ͼ��
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

%����Hopfield������
net = newhop(T);
 
% �����ʼ��
a = {rands(3,1)};
%�趨Hopfield�������
[y,Pf,Af] = net({1 10},{},a);

%�趨һ���ȶ��ռ��ڵĻ��
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot3(start(1,1),start(2,1),start(3,1),'bx', ...
   record(1,:),record(2,:),record(3,:))

%ѭ��ģ��30����ʼ����
color = 'rgbmy';
for i=1:30
   a = {rands(3,1)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kx', ...
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1)) 
end

%ʹ����������P����Hopfield������
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
