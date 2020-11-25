%抗体的聚合适应度函数
function f=fit(A,fitness)   
t=0.8;
[m,m]=size(A);  %A为10*10的矩阵
k=-0.8;
for i=1:m
    n=0;
    for j=1:m
    if A(i,j)>t
        n=n+1;
    end
    end
    C(1,i)=n/m;   %%计算抗体的浓度
end
f=fitness.*exp(k.*C);   %抗体的聚合适应度，f为1*10的矩阵
