function [objvalue]=calobjvalue(pop)
temp1=decodechrom(pop,1,10); %��popÿ��ת����ʮ������
x=temp1*10/1023; %����ֵ�� �е���ת��Ϊ������ ����
objvalue=10*sin(5*x)+7*cos(4*x); %����Ŀ�꺯��ֵ
end
