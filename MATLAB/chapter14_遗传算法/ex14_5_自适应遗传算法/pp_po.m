function pp_po()
global popsize oldpop np
i=np+1;                      % np=floor(po*popsize);  %��̭�ĸ���np
j=1;
while i<=popsize   %����np+1����popsize�ĸ������toldpop�У�����popsize-np����
    toldpop(j,:)=oldpop(i,:);      
    j=j+1;
    i=i+1;
end
for i=1:(popsize-np)                 %��С����˳�����У���ǰ��np����̭
    oldpop(i,:)=toldpop(i,:);          % ��Ӧ���Ƿ�ҲҪ������
end
