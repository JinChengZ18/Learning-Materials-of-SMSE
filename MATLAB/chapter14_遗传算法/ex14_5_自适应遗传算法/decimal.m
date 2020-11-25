function c=decimal(chrom)
global lchrom popsize
c=0;
for j=1:lchrom
    c=c+chrom(1,j)*2.^(lchrom-j);
end
