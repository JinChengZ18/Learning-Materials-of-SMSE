clear all
clc
tic
popsize = 15;
lanti = 10;
maxgen = 60;
cross_rate = 0.3;
mutation_rate = 0.05;
a0 = 0.6
zpopsize = 5;
bestf = 0;
nf = 0;
number = 0;
num_pic = 1;
slect_num = [10,20,30,40,50,60];
I = imread('fly.png');
q = isrgb(I);
if q==1 
    I=rgb2gray(I);  %转换RGB图像为灰度图像
end
[m,n]=size(I);
p=imhist(I);       %显示图像数据直方图
p=p';              %阵列由列变为行
p=p/(m*n);         %将p的值变换到（0,1）
figure(1)
subplot(1,2,1);
imshow(I);
title('原始图像的灰度图像');
hold on
%%%抗体群体初始化%%%%%%%%%%%
pop=2*rand(popsize,lanti)-1;   %pop为10*8的值为（-1,1）之间的随机数矩阵
pop=hardlim(pop);              %大于等于0为1，小于0为0
%%%%%%免疫操作%%%%%%%%%%%%%%%%%%
for gen=1:maxgen
  [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);%%计算抗体—抗原的亲和度
  if max(fitness)>bestf
    bestf=max(fitness);
    nf=0;
  for i=1:popsize
        if fitness(1,i)==bestf        %找出最大适应度在向量fitness中的序号
            v=i;
        end
  end
 yu=yuzhi(1,v);
  elseif max(fitness)==bestf
    nf=nf+1;
  end
    if nf>=20
     break;
     end
A=shontt(pop);                     %计算抗体—抗体的相似度
f=fit(A,fitness);                  %计算抗体的聚合适应度
pop=select(pop,f);                 %进行选择操作
pop=coss(pop,cross_rate,popsize,lanti);  %交叉
pop=mutation_compute(pop,mutation_rate,lanti,popsize);   %变异
a=shonqt(pop); %计算抗体群体的相似度
if a>a0
    zpop=2*rand(zpopsize,lanti)-1;
    zpop=hardlim(zpop);                %随机生成zpopsize个新抗体
    pop(popsize+1:popsize+zpopsize,:)=zpop(:,:);
    [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);              
    %计算抗体—抗原的亲和度
    A=shontt(pop);                     %计算抗体—抗体的相似度
    f=fit(A,fitness);                  %计算抗体的聚合适应度
    pop=select(pop,f);                 %进行选择操作
end
if gen==maxgen
   [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);              
   %计算抗体—抗原的亲和度 
end
if_draw = ismember(gen,slect_num);
if if_draw==1
    %imshow(I);
    subplot(3,2,num_pic);
    fresult(I,yu);
    subtitle = ['经过',num2str(gen),'次遗传迭代后的阈值分割图像'];
    title(subtitle);
    num_pic = num_pic+1;
end
end
%imshow(I);
%subplot(1,2,2);
%fresult(I,yu);
%title('阈值分割后的图像');
