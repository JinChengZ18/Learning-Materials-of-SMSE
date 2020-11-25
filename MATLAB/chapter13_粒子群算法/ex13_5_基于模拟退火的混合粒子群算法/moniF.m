function y=moniF(x)
y=0;
for i=1:8
    y=y+(i-3)/(((x(i)-1)^2)+0.8);
end
y=1/(0.9+y);
end
