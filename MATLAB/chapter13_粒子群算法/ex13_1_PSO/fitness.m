function F=fitness(x)
F=0;
for i=1:10
    F=F+x(i)^2+2*x(i)-3;
end
