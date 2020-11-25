function y=BrF (x)
y=0;
for i=1:5
    y=y+i/(1-(x(i)+2)^2);
end
y=1/(3+y)+0.8;
end
