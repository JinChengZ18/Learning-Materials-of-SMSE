clear all
clc
A = [-1 2; 
    1 3; 
    5 1];
b = [3; 5; 2];
lb = zeros(2,1);
[x,fval,exitflag] = ga(@lincontest6,2,A,b,[],[],lb)
