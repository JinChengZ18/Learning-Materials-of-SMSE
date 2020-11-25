%克隆算子
function [T,AAS]=ReproduceFun(mn,cfactor,m,Affinity,A,T);
if mn==1
    CS=m;
    T=ones(m,1)*A(Affinity(end),:);
else
    for i=1:mn
        %每个抗体的克隆数与它和抗原的亲和度成正比%
        CS(i)=round(cfactor*m);
        %计算每个抗体的克隆数目CS(i)
        AAS(i)=sum(CS); 
        %每个抗体克隆的最终下标位置
        ONECS=ones(CS(i),1); 
        %生成CS(i)行1列单位矩阵ONECS
        subscript=Affinity(end-i+1); 
        %确定当前要克隆抗体在抗体集A中的下标
        AA=A(subscript,:); 
        %确定当前要克隆抗体的基因序列集合AA(1×n)
        T=[T;ONECS*AA]; 
        %得到零时存放抗体的集合T
    end
end
