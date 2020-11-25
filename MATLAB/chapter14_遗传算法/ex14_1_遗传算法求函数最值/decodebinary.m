function pop2=decodebinary(pop)
[px,py]=size(pop); 
%求pop行和列数
for i=1:py
pop1(:,i)=2.^(py-i).*pop(:,i);
end
pop2=sum(pop1,2); 
%求pop1的每行之和 
end
