%���������ֵ����ͼ��ָ�������
function fresult(I,f,m,n)
[m,n]=size(I);
for i=1:m
    for j=1:n
        if I(i,j)<=f
            I(i,j)=0;
        else
            I(i,j)=255;
        end
    end
end
imshow(I);