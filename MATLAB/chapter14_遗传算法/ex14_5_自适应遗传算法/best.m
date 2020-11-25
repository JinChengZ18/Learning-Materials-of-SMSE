function best()
global maxfit bestfit gen maxgen bestgen
bestfit=maxfit(1,1);
gen=2;
while gen<=maxgen
      if bestfit<maxfit(1,gen)
         bestfit=maxfit(1,gen);
         bestgen=gen;
     end
     gen=gen+1;
end
