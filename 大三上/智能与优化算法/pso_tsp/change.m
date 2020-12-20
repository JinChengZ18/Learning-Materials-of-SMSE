% clc
% clear
% a=[1,2,3,4,5];
% b=[5,4,3,2,1];
% t=[5,4,3,4,5];
function t=change(a,b)
for k=1:size(a,1)
    for i=1:size(a,2)
        t(k,i)=find(b(k,:)==a(k,i));
        b(k,[i,t(k,i)])=b(k,[t(k,i),i]);
    end
end
end
