function newpop=crossover(pop,pc,k)
global N length M;
pc=pc-(M-k)/M*1/20;
A=1:N*length;
% A=randcross(A,N,length); % 将数组A的次序随机打乱（可实现两两随机配对）
for i=1:length
    n1=A(i);n2=i+10; % 随机选中的要进行交叉操作的两个染色体
    for j=1:N                     % N点（段）交叉
           cpoint=length-round(length*pc);        % 这两个染色体中随机选择的交叉的位置
           temp1=pop(n1,(j-1)*length+cpoint+1:j*length);temp2=pop(n2,(j-1)*length+cpoint+1:j*length);
           pop(n1,(j-1)*length+cpoint+1:j*length)=temp2;pop(n2,(j-1)*length+cpoint+1:j*length)=temp1;
    end      
    newpop=pop;
end
end