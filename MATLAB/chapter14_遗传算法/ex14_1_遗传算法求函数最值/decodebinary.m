function pop2=decodebinary(pop)
[px,py]=size(pop); 
%��pop�к�����
for i=1:py
pop1(:,i)=2.^(py-i).*pop(:,i);
end
pop2=sum(pop1,2); 
%��pop1��ÿ��֮�� 
end
