clear
clc
% 导入数据
t0 = clock;
load city30.txt
citys = city30;
n=size(citys,1);   %空间维数
city_num=1:n;
route_best=1:n;

distant= zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            distant(i,j) = sqrt(sum( ( citys(i,:) - citys(j,:) ).^2 ) );
        else
            distant(i,j) = 1e-4;          %设定的对角矩阵修正值
        end
    end
end

pn=500;                          % 例子数目
nc=1;
nc_max=100;                   % 最大迭代次数        
wmax=0.96;                     % 惯性权重  
wmin=0.4;
w=0.8;
c1=0.5;                       % 自我学习因子  
c2=15;                       % 群体学习因子
x=zeros(pn,n);
for i=1:pn
    x(i,:)=x(i,:)+randperm(n);
end
v = zeros(pn,n);                % 初始速度
for i=1:pn
    v(i,:)=round(rand(1,n)'*n); %round取整
end
remg=inf(1,pn);
remx=inf(pn,n);
nums=0;
stop=0;

while (nc<nc_max)&&(stop==0)
    glen=len(pn,n,distant,x);
    [len_b,best_index]=min(glen);
    gb=x(best_index,:);
    len_best(1)=inf;
    len_best(nc+1)=min(len_b,len_best(nc));
    if len_best(nc+1)==len_b
        g_best=gb;
        nums=1;
    else
        nums=nums+1;
    end
    if nums>=20
        stop=1;
    end
    remg=[remg;glen];
    [remg,remg_index]=min(remg);
    remx(find(remg_index==2),:)=x(find(remg_index==2),:);
    
    w=wmax-(wmax-wmin)*nc/nc_max;
    t1=change(remx,x);
    t1=choose(t1,c1);
    t2=change(repmat(g_best,[pn,1]),x);
    t2=choose(t2,c2);
    v=choose(v,w);
    x=path_change(x,v);
    x=path_change(x,t1);
    x=path_change(x,t2);
    nc=nc+1;
end
Time_Cost = etime(clock,t0);
disp(['程序执行时间:' num2str(Time_Cost),'秒']);
disp(['最短距离:' num2str(len_best(end))]);
disp(['最优路径为:' num2str(x(1,:))]);
r=g_best;
resultplot(len_best,citys,r);
% figure(1);
% scatter(citys(:,1),citys(:,2),'*')
% hold on
% plot(citys(r,1),citys(r,2),'-');
% hold on
% text(citys(r(1),1),citys(r(1),2),'  起点');
% text(citys(r(end),1),citys(r(end),2),'  终点');
% for i = 1:size(citys,1)
%     text(citys(i,1),citys(i,2),['  ' num2str(i)]);
% end
% 
% figure(2);
% plot(1:size(len_best,2),len_best);


