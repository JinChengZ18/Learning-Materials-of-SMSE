function F=fitness(x)
F=0;
for i=1:1
    F = F+11*sin(7*x(i))-7*cos(3*x(i))+5*sin(6*x(i));
end
