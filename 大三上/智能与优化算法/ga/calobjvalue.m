function [objvalue]=calobjvalue(pop)
temp1=decodechrom(pop,1,10); %��popÿ��ת����ʮ������
x=temp1*10/1023; %����ֵ�� �е���ת��Ϊ������ ����
objvalue=-11*sin(7*x)+7*cos(3*x)-5*sin(6*x); %����Ŀ�꺯��ֵ
end
