function y=fitness(x)
   y=((cos(x(1)^2-x(2)^2))^2-sin(x(1)^2+ x(2)^2)+2)/((3+0.2*(x(1)^2+ x(2)^2))^2)-0.9;
end
