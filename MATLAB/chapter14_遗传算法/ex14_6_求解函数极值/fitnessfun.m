%�ӳ��򣺼�����Ӧ�Ⱥ���, �������ƴ洢Ϊfitnessfun function 
function [Fitvalue,cumsump]=fitnessfun(population);
global BitLength
global boundsbegin
global boundsend 
popsize=size(population,1);   %����������
for i=1:popsize   
    x=transform2to10(population(i,:));  %��������ת��Ϊʮ����     
    %ת��Ϊ[-1,1]�����ʵ��    
    xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1); 
    Fitvalue(i)=targetfun(xx);  %���㺯��ֵ������Ӧ��
end
%����Ӧ�Ⱥ�������һ����С��������Ա㱣֤��Ⱥ��ӦֵΪ���� 
Fitvalue=Fitvalue'; 
%����ѡ�����
fsum=sum(Fitvalue);  
Pperpopulation=Fitvalue/fsum;  %��Ӧ�ȹ�һ��
%�����ۻ�����
cumsump(1)=Pperpopulation(1) ;
for i=2:popsize   
    cumsump(i)=cumsump(i-1)+Pperpopulation(i)  ;%���ۼƸ��� 
end
cumsump=cumsump' ;  %�ۼƸ���  
end

