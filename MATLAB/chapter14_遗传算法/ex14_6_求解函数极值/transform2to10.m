    
%子程序：将2进制数转换为10进制数,函数名称存储为transform2to10.m
function x=transform2to10(Population); 
    BitLength=size(Population,2); %Population的列，即2进制的长度
    x=Population(BitLength); 
    for i=1:BitLength-1   
        x=x+Population(BitLength-i)*power(2,i);%从末位加到首位
    end
end