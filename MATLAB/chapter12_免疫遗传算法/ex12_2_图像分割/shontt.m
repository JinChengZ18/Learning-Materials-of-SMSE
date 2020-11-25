 %抗体相似度计算函数
function A=shontt(pop) 
[m,n]=size(pop);
for i=1:m
    for j=1:m
        if i==j
            A(i,j)=1;
        else H(i,j)=0;
            for k=1:n
                if pop(i,k)~=pop(j,k)
                    H(i,j)=H(i,j)+1;
                end
            end
        H(i,j)=H(i,j)/n;
        A(i,j)=1/(1+H(i,j));
        end
    end
end