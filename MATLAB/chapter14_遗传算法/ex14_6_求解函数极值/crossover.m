%�ӳ�������Ⱥ�������,�������ƴ洢Ϊcrossover.m 
%����populationΪ��Ⱥ��selnΪѡ����������壬pcΪ����ĸ���
function scro=crossover(population,seln,pc);
    BitLength=size(population,2);%���������ĸ��� 
    pcc=IfCroIfMut(pc);  %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0��� 
    %���н������  
    if pcc==1 %���н������   
        chb=round(rand*(BitLength-2))+1;  %��[1,BitLength-1]��Χ���������һ������λ  
        scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];  
        %���Ϊseln(1)�ĸ����ڽ���λchbǰ�����Ϣ�����Ϊseln(2)�ĸ����ڽ���λchb+1�������Ϣ�������   
        scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];    
        %���Ϊseln(2)�ĸ����ڽ���λchbǰ�����Ϣ�����Ϊseln(1)�ĸ����ڽ���λchb+1�������Ϣ�������
    else 
        %�����н������    
        scro(1,:)=population(seln(1),:);    
        scro(2,:)=population(seln(2),:);
    end
end
        
