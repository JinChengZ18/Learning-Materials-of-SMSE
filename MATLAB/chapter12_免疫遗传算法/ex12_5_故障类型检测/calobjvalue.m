%实现目标函数的计算，交叉
function [objvalue]=calobjvalue(pop,i)
global length N min max code;          
% 默认染色体的二进制长度length=10
distance=0;
for j=1:N
    temp(:,j)=decodechrom(pop,1+(j-1)*length,length);
    %将pop每行(个体）每列（每段基因）转化成十进制数
    x(:,j)=temp(:,j)/(2^length-1)*(max(j)-min(j))+min(j);   
    % popsize×N 将二值域中的数转化为变量域的数   
    distance=distance+(x(:,j)-code(i,j)).^2;             
    % 将得popsize个不同的距离
end
objvalue=sqrt(distance);
%计算目标函数值：欧氏距离
end