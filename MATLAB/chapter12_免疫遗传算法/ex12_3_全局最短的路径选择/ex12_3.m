clear all
clc
edge= [ 2,3,1,3,3,5,4, 4,1,7,6,6,5, 5,11,1,8,6,9,10,8,9, 9,10;...
        3,4,2,7,5,3,5,11,7,6,7,5,6,11, 5,8,1,9,5,11,9,8,10, 9;...
        3,5,8,5,6,6,1,12,7,9,9,2,2,10,10,8,8,3,7, 2,9,9, 2, 2];
n=11; 
weight=inf*ones(n, n);
for i=1:n
   weight(i, i)=0;
end
for i=1:size(edge,2)
weight(edge(1, i), edge(2, i))=edge(3, i);
end
[dis, path]=dist(weight, 1, 5)
