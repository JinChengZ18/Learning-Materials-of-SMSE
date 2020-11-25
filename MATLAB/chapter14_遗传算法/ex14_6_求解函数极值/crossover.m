%子程序：新种群交叉操作,函数名称存储为crossover.m 
%输入population为种群，seln为选择的两个个体，pc为交配的概率
function scro=crossover(population,seln,pc);
    BitLength=size(population,2);%二进制数的个数 
    pcc=IfCroIfMut(pc);  %根据交叉概率决定是否进行交叉操作，1则是，0则否 
    %进行交叉操作  
    if pcc==1 %进行交叉操作   
        chb=round(rand*(BitLength-2))+1;  %在[1,BitLength-1]范围内随机产生一个交叉位  
        scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];  
        %序号为seln(1)的个体在交叉位chb前面的信息与序号为seln(2)的个体在交叉位chb+1后面的信息重新组合   
        scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];    
        %序号为seln(2)的个体在交叉位chb前面的信息与序号为seln(1)的个体在交叉位chb+1后面的信息重新组合
    else 
        %不进行交叉操作    
        scro(1,:)=population(seln(1),:);    
        scro(2,:)=population(seln(2),:);
    end
end
        
