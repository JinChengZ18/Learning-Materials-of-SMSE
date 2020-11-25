function initpop()
global lchrom oldpop popsize chrom
for i=1:popsize
    chrom=rand(1,lchrom);    %  lchrom=12  染色体长度
    for j=1:lchrom
        if chrom(1,j)<0.5
            chrom(1,j)=0;
       else 
           chrom(1,j)=1;
        end
    end
    oldpop(i,1:lchrom)=chrom;    
end
