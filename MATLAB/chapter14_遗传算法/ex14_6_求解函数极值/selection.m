%�ӳ�������Ⱥѡ�����, �������ƴ洢Ϊselection.m
%ѡ���������壬���ظ������ţ��п������������ͬ 
function seln=selection(population,cumsump); %����Ⱥ��ѡ���������� 
    for i=1:2   
        r=rand;  %����һ�������   
        prand=cumsump-r;  %����ȥr�����cumsump�е�һ����r���Ԫ��   
        j=1;    
        while prand(j)<0 
            j=j+1;  
        end
        seln(i)=j; %ѡ�и������� 
    end
end
    
