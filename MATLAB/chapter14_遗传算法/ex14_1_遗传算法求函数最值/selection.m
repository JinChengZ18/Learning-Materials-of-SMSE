%ѡ����  
function [newpop]=selection(pop,fitvalue)
totalfit=sum(fitvalue); %����Ӧֵ֮��
fitvalue=fitvalue/totalfit; %�������屻ѡ��ĸ���
fitvalue=cumsum(fitvalue); %�� fitvalue=[1 2 3 4]���� cumsum(fitvalue)=[1 3 6 10] 
[px,py]=size(pop);
ms=sort(rand(px,1)); %��С��������
fitin=1;
newin=1;
while newin<=px
    if(ms(newin))<fitvalue(fitin)
        newpop(newin)=pop(fitin);
        newin=newin+1;
    else
        fitin=fitin+1;
    end
end
