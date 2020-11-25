%变异操作
function pop=mutation_compute(pop,mutation_rate,lanti,popsize)  %均匀变异
for i=1:popsize
    s=rand(1,lanti);
    for j=1:lanti
        if s(1,j)<mutation_rate
            if pop(i,j)==1
                pop(i,j)=0;
            else pop(i,j)=1;
            end
        end
    end
end
