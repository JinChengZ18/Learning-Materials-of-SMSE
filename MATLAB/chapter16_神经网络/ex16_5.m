clear all
clc
%����������
m=13;
n=7;
P=rand(m,n);
for i=1:m
    for j=1:n
        if P(i,j)>0.7
            P(i,j)=1;
        else
            P(i,j)=0;
        end
    end
end
P=P';
 
%newsom����SOM����,������Ϊ7*9=63����Ԫ
net=newsom(minmax(P),[7 9]);
figure(1)
plotsom(net.layers{1}.positions)

%4�ֲ�ͬѵ�������ķ���
a=[5 20 40 80 160 320 640 1280];
% �����ʼ��һ������
yc=rands(13,13);
 
% ѵ������Ϊ5ʱ����
net.trainparam.epochs=a(1);
%ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(1,:)=vec2ind(y);
figure(2)
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ20ʱ����
net.trainparam.epochs=a(2);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(2,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
%ѵ������Ϊ40ʱ����
net.trainparam.epochs=a(3);
%ѵ������
net=train(net,P);
%��������
y=sim(net,P);
yc(3,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
%ѵ������Ϊ80ʱ����
net.trainparam.epochs=a(4);
%ѵ������
net=train(net,P);
%��������
y=sim(net,P);
yc(4,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)