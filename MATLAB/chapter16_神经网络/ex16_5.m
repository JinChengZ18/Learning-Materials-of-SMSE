clear all
clc
%设样本数据
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
 
%newsom建立SOM网络,竞争层为7*9=63个神经元
net=newsom(minmax(P),[7 9]);
figure(1)
plotsom(net.layers{1}.positions)

%4种不同训练步数的仿真
a=[5 20 40 80 160 320 640 1280];
% 随机初始化一个向量
yc=rands(13,13);
 
% 训练步数为5时仿真
net.trainparam.epochs=a(1);
%训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(1,:)=vec2ind(y);
figure(2)
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为20时仿真
net.trainparam.epochs=a(2);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(2,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
%训练步数为40时仿真
net.trainparam.epochs=a(3);
%训练网络
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(3,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
%训练步数为80时仿真
net.trainparam.epochs=a(4);
%训练网络
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(4,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)