%����������Ӧֵ��Ŀ�꣺�����ɱȽϵķǸ���ֵ
function fitvalue=calfitvalue(objvalue)
fitvalue=objvalue;
global popsize;
Cmin=0;
for i=1:popsize
  if objvalue(i)+Cmin>0     % objvalue Ϊһ������
      temp=Cmin+objvalue(i);
   else
      temp=0;
   end
   fitvalue(i)=temp;         % ��һ����
end
end