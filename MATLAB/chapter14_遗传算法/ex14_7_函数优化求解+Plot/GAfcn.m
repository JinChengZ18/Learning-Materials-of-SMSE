function f=GAfcn(x)
for j = 1:size(x,1)
    y = x(j,:);
    temp1 = 0; 
    temp2 = 0;
    y1 = y(1);
    y2 = y(2);
    for i = 1:10
        temp1 = temp1 + i.*sin((i+1).*y1+i);
        temp2 = temp2 + i.*sin((i+1).*y2+i);
    end
    f(j) = temp1.*temp2;
end
