% 二维人工免疫优化算法
% m--抗体规模
% n--每个抗体二进制字符串长度
% mn--从抗体集合里选择n个具有较高亲和度的最佳个体进行克隆操作
% A--抗体集合(m×n),抗体的个数为m,每个抗体用n个二进制编码(代表参数)
% T--临时存放克隆群体的集合,克隆规模是抗原亲和度度量的单调递增函数
% FM--每代最大适应度值集合
% FMN--每代平均适应度值集合
% AAS--每个克隆的最终下标位置
% BBS--每代最优克隆的下标位置
% Fit--每代适应度值集合
% tnum--迭代代数
% xymin--自变量下限
% xymax--自变量上限
% pMutate--高频变异概率
% cfactor--克隆(复制)因子
% Affinity--亲和度值大小顺序
%%%%%%%%%%%%%%%%%%
clear all
clc
tic;
m=65;
n=22;
mn=60;
xmin=-10; 
xmax=10;
tnum=100;
pMutate=0.1;
cfactor=0.3;
A=InitializeFun(m,n); %生成抗体集合A,抗体数目为m,每个抗体基因长度为n
F='X+5*sin(X.*8)+7*cos(X.*3)'; %目标函数
FM=[]; %存放各代最优值的集合
FMN=[]; %存放各代平均值的集合
t=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while t<tnum
    t=t+1;
    X=DecodeFun(A(:,1:22),xmin,xmax); %将二进制数转换成十进制数
    Fit=eval(F); %以X为自变量求函数值并存放到集合Fit中
    if t==1 
        figure(1)
        fplot(F,[xmin,xmax]); 
        grid on
        hold on
        plot(X,Fit,'k*')
        title('抗体的初始位置分布图')
        xlabel('x')
        ylabel('f(x)')
    end
    if t==tnum
        figure(2)
        fplot(F,[xmin,xmax]);
        grid on
        hold on
        plot(X,Fit,'r*')
        title('抗体的最终位置分布图')
        xlabel('x')
        ylabel('f(x)')
    end
    %把零时存放抗体的集合清空
    T=[]; 
    %把第t代的函数值Fit按从小到大的顺序排列并存放到FS中
    [FS,Affinity]=sort(Fit,'ascend'); 
    %把第t代的函数值的坐标按从小到大的顺序排列并存放到XT中
    XT=X(Affinity(end-mn+1:end)); 
     %从FS集合中取后mn个第t代的函数值按原顺序排列并存放到FT中
    FT=FS(end-mn+1:end);
    %把第t代的最优函数值加到集合FM中
    FM=[FM FT(end)]; 
    %克隆(复制)操作,选择mn个候选抗体进行克隆,克隆数与亲和度成正比,
    %AAS是每个候选抗体克隆后在T中的开始坐标
    [T,AAS]=ReproduceFun(mn,cfactor,m,Affinity,A,T);
    %把以前的抗体保存到临时克隆群体T里
    T=Hypermutation(T,n,pMutate,xmax,xmin); 
    %从大到小重新排列要克隆的mn个原始抗体
    AF1=fliplr(Affinity(end-mn+1:end)); 
    %把以前的抗体保存到临时克隆群体T里%从临时抗体集合T中根据亲和度的值选择mn个
    T(AAS,:)=A(AF1,:); 
    X=DecodeFun(T(:,1:22),xmin,xmax);
     Fit=eval(F);
    AAS=[0 AAS];
    FMN=[FMN mean(Fit)];
    for i=1:mn
        %克隆子群中的亲和度最大的抗体被选中
        [OUT(i),BBS(i)]=max(Fit(AAS(i)+1:AAS(i+1))); 
        BBS(i)=BBS(i)+AAS(i);
    end
    %从大到小重新排列要克隆的mn个原始抗体
    AF2=fliplr(Affinity(end-mn+1:end)); 
    %选择克隆变异后mn个子群中的最好个体保存到A里,其余丢失
    A(AF2,:)=T(BBS,:); 
end
disp(sprintf('\n The optimal point is:'));
disp(sprintf('\n x: %2.4f, f(x):%2.4f',XT(end),FM(end)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
grid on 
plot(FM)
title('适应值变化趋势')
xlabel('迭代数')
ylabel('适应值')
hold on
plot(FMN,'r')
hold off
