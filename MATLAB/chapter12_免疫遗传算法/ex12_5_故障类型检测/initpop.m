% �����ʼ������
% initpop.m�����Ĺ�����ʵ��Ⱥ��ĳ�ʼ����popsize��ʾȺ��Ĵ�С��chromlength��ʾȾɫ��ĳ���(��ֵ���ĳ���)��
% ���ȴ�Сȡ���ڱ����Ķ����Ʊ���ĳ��ȡ�
function pop=initpop(popsize,chromlength) 
pop=round(rand(popsize,chromlength)); 
% rand�������ÿ����ԪΪ {0,1} ����Ϊpopsize������Ϊchromlength�ľ���
% roud�Ծ����ÿ����Ԫ����Բ����������������ĳ�ʼ��Ⱥ��
end