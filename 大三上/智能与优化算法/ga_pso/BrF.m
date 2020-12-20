% 求待优化函数的极小值
function y=BrF (x)
P1 = 20; 
P2 = 20; 
sigma_m = 150; 
sigma_p = 200; 
y  = 0;
for i=1:1
    %y=y-abs(P1*(x(2)+sqrt(2)*x(1))/(sqrt(2)*x(1)^2+2*x(1)*x(2))-sigma_p)/sigma_p
    %y=y-abs(sqrt(2)*P1*x(1)/(sqrt(2)*x(1)^2+2*x(1)*x(2))-sigma_p)/sigma_p
    %y=y-abs(P1*x(2)/(sqrt(2)*x(1)^2+2*x(1)*x(2))-sigma_m)/sigma_m
    y=y+11*sin(7*x)-7*cos(3*x)+5*sin(6*x);
end
end
