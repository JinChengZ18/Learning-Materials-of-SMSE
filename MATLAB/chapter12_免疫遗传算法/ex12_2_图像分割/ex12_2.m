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
    I=rgb2gray(I);  %ת��RGBͼ��Ϊ�Ҷ�ͼ��
end
[m,n]=size(I);
p=imhist(I);       %��ʾͼ������ֱ��ͼ
p=p';              %�������б�Ϊ��
p=p/(m*n);         %��p��ֵ�任����0,1��
figure(1)
subplot(1,2,1);
imshow(I);
title('ԭʼͼ��ĻҶ�ͼ��');
hold on
%%%����Ⱥ���ʼ��%%%%%%%%%%%
pop=2*rand(popsize,lanti)-1;   %popΪ10*8��ֵΪ��-1,1��֮������������
pop=hardlim(pop);              %���ڵ���0Ϊ1��С��0Ϊ0
%%%%%%���߲���%%%%%%%%%%%%%%%%%%
for gen=1:maxgen
  [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);%%���㿹�塪��ԭ���׺Ͷ�
  if max(fitness)>bestf
    bestf=max(fitness);
    nf=0;
  for i=1:popsize
        if fitness(1,i)==bestf        %�ҳ������Ӧ��������fitness�е����
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
A=shontt(pop);                     %���㿹�塪��������ƶ�
f=fit(A,fitness);                  %���㿹��ľۺ���Ӧ��
pop=select(pop,f);                 %����ѡ�����
pop=coss(pop,cross_rate,popsize,lanti);  %����
pop=mutation_compute(pop,mutation_rate,lanti,popsize);   %����
a=shonqt(pop); %���㿹��Ⱥ������ƶ�
if a>a0
    zpop=2*rand(zpopsize,lanti)-1;
    zpop=hardlim(zpop);                %�������zpopsize���¿���
    pop(popsize+1:popsize+zpopsize,:)=zpop(:,:);
    [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);              
    %���㿹�塪��ԭ���׺Ͷ�
    A=shontt(pop);                     %���㿹�塪��������ƶ�
    f=fit(A,fitness);                  %���㿹��ľۺ���Ӧ��
    pop=select(pop,f);                 %����ѡ�����
end
if gen==maxgen
   [fitness,yuzhi,number]=fitnessty(pop,lanti,I,popsize,m,n,number);              
   %���㿹�塪��ԭ���׺Ͷ� 
end
if_draw = ismember(gen,slect_num);
if if_draw==1
    %imshow(I);
    subplot(3,2,num_pic);
    fresult(I,yu);
    subtitle = ['����',num2str(gen),'���Ŵ����������ֵ�ָ�ͼ��'];
    title(subtitle);
    num_pic = num_pic+1;
end
end
%imshow(I);
%subplot(1,2,2);
%fresult(I,yu);
%title('��ֵ�ָ���ͼ��');
