  %�ӳ����ж��Ŵ������Ƿ���Ҫ���н�������, �������ƴ洢ΪIfCroIfMut.m 
  %mutORcroΪ���������桢���죩�����ĸ��� 
  %���ݸ���mutORcro�����Ƿ���в���������1�ĸ�����mutORcro������0�ĸ���Ϊ1-mutORcro
function pcc=IfCroIfMut(mutORcro); 
test(1:100)=0; %1x100��������  
l=round(100*mutORcro); %����һ����Ϊ100*mutORcro��roundΪȡ���������� 
test(1:l)=1;  
n=round(rand*99)+1; 
pcc=test(n); 
end
            
            
