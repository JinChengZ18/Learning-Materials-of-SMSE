%%%%%���Ŵ��㷨���y=20+x.*sin(7*pi*x)��[-1 2]�����ϵ����ֵ%%
clear all;  
clc;
global BitLength         %ȫ�ֱ������������������⾫��������Ҫ����ĳ��� 
global boundsbegin       %ȫ�ֱ������Ա�������ʼ�� 
global boundsend         %ȫ�ֱ������Ա�������ֹ�� 
bounds=[-1 2];           %һά�Ա�����ȡֵ��Χ 
precision=0.0001;        %���㾫�� 
boundsbegin=bounds(:,1); 
boundsend=bounds(:,2);   %�������������⾫��������Ҫ�೤��Ⱦɫ�� 
BitLength=ceil(log2((boundsend-boundsbegin)' ./ precision)); 
popsize=50;              %��ʼ��Ⱥ��С  
Generationnmax=15;       %������ 
pcrossover=0.80;         %������� 
pmutation=0.08;          %�������  
population=round(rand(popsize,BitLength));  %��ʼ��Ⱥ���д���һ�����壬�д���ͬ����  
%������Ӧ�� 
[Fitvalue,cumsump]=fitnessfun(population);  %����Ⱥ��population��������Ӧ��Fitvalue���ۻ�����cumsump 
Generation=1;  
while Generation<(Generationnmax+1)     
    for j=1:2:popsize                       %1��1�Ե�Ⱥ��������²��������棬���죩      
        %ѡ��        
        seln=selection(population,cumsump);  
        %����       
        scro=crossover(population,seln,pcrossover);        
        scnew(j,:)=scro(1,:);   
        scnew(j+1,:)=scro(2,:);       
        %����        
        smnew(j,:)=mutation(scnew(j,:),pmutation);  
        smnew(j+1,:)=mutation(scnew(j+1,:),pmutation);  
    end
    %�������µ���Ⱥ 
    population=smnew;
  
    %��������Ⱥ����Ӧ��    
    [Fitvalue,cumsump]=fitnessfun(population);    %��¼��ǰ����õ���Ӧ�Ⱥ�ƽ����Ӧ�� 
    [fmax,nmax]=max(Fitvalue);                    %��õ���Ӧ��Ϊfmax��������ֵ��󣩣����Ӧ�ĸ���Ϊnmax     
    fmean=mean(Fitvalue);                         %ƽ����Ӧ��Ϊfmean   
    ymax(Generation)=fmax;                        %ÿ������õ���Ӧ��  
    ymean(Generation)=fmean;                      %ÿ���е�ƽ����Ӧ��   
    %��¼��ǰ�������Ⱦɫ�����    
    x=transform2to10(population(nmax,:));%population(nmax,:)Ϊ���Ⱦɫ�����  
    xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1);
    xmax(Generation)=xx;    
    Generation=Generation+1 
end
Generation=Generation-1;%Generation��1����1�Ĳ�����Ϊ���ܼ�¼�����е���Ѻ���ֵxmax(Generation)
targetfunvalue=targetfun(xmax)  
[Besttargetfunvalue,nmax]=max(targetfunvalue) 
Bestpopulation=xmax(nmax)   
%���ƾ����Ŵ���������Ӧ������
figure(2);  
hand1=plot(1:Generation,ymax);
set(hand1,'linestyle','-','linewidth',1,'marker','*','markersize',8) 
hold on;  
hand2=plot(1:Generation,ymean); 
set(hand2,'color','k','linestyle','-','linewidth',1, 'marker','h','markersize',8) 
xlabel('��������');
ylabel('����ƽ����Ӧ��');
xlim([1 Generationnmax]);
legend('�����Ӧ��','ƽ����Ӧ��');
box off;
hold off;    

% %%%%%%%%%%%%������Ӧ�Ⱥ���%%%%%%%%%%%%%%%%%%%%%%%% 
% [Fitvalue,cumsump]=fitnessfun(population);
% global BitLength
% global boundsbegin
% global boundsend 
% popsize=size(population,1);             %����������
% for i=1:popsize   
%     x=transform2to10(population(i,:));  %��������ת��Ϊʮ����     
%     %ת��Ϊ[-2,2]�����ʵ��    
%     xx=boundsbegin+x*(boundsend-boundsbegin)/(power(2,BitLength)-1); 
%     Fitvalue(i)=targetfun(xx);  %���㺯��ֵ������Ӧ��
% end
% %����Ӧ�Ⱥ�������һ����С��������Ա㱣֤��Ⱥ��ӦֵΪ���� 
% Fitvalue=Fitvalue'+230 %�ô�����һ�����þ��Ǿ�����Ӧ����������ѡȡ�����������壨��ǿ������������������� 
% %����ѡ�����
% fsum=sum(Fitvalue)  
% Pperpopulation=Fitvalue/fsum                    %��Ӧ�ȹ�һ�����������Ƶĸ���
% %�����ۻ�����
% cumsump(1)=Pperpopulation(1) 
% for i=2:popsize   
%     cumsump(i)=cumsump(i-1)+Pperpopulation(i)  %���ۼƸ��� 
% end
% cumsump=cumsump'                               %�ۼƸ���    
% 
% %%%%%%%%%%%%����Ŀ�꺯��%%%%%%%%%%%%%%%%%%%%%%%%
% function y=targetfun(x); %Ŀ�꺯�� 
% y=x.*sin(10*pi*x)+2;   
% 
% %%%%%%%%%%%%����Ⱥ�������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %����populationΪ��Ⱥ��selnΪѡ����������壬pcΪ����ĸ���
% function scro=crossover(population,seln,pc);
%     BitLength=size(population,2);   %���������ĸ��� 
%     pcc=IfCroIfMut(pc);             %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0��� 
%     %���н������  
%     if pcc==1 %���н������   
%         chb=round(rand*(BitLength-2))+1;  %��[1,BitLength-1]��Χ���������һ������λ  
%         scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)];  
%         %���Ϊseln(1)�ĸ����ڽ���λchbǰ�����Ϣ�����Ϊseln(2)�ĸ����ڽ���λchb+1�������Ϣ�������   
%         scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)];    
%         %���Ϊseln(2)�ĸ����ڽ���λchbǰ�����Ϣ�����Ϊseln(1)�ĸ����ڽ���λchb+1�������Ϣ�������
%     else 
%         %�����н������    
%         scro(1,:)=population(seln(1),:);    
%         scro(2,:)=population(seln(2),:);
%     end
% end
%         
% %%%%%%%%�ж��Ŵ������Ƿ���Ҫ���н�������%%%%%%%%%%%%%%%%%%%% 
% %mutORcroΪ���桢���췢���ĸ��� 
% %����mutORcro�����Ƿ������Ӧ�Ĳ���������1�ĸ�����mutORcro������0�ĸ���Ϊ1-mutORcro
% function pcc=IfCroIfMut(mutORcro); 
% test(1:100)=0;          %1x100��������  
% l=round(100*mutORcro);  %����һ����Ϊ100*mutORcro��roundΪȡ���������� 
% test(1:l)=1;  
% n=round(rand*99)+1; 
% pcc=test(n); 
% end
%             
%             
% %%%%%%%%%%%%����Ⱥ�������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %snewΪһ������  
% function snnew=mutation(snew,pmutation); 
%     BitLength=size(snew,2);
%     snnew=snew;  
%     pmm=IfCroIfMut(pmutation);            %���ݱ�����ʾ����Ƿ���б��������1���ǣ�0��� 
%     if pmm==1    
%         chb=round(rand*(BitLength-1))+1;  %��[1,BitLength]��Χ���������һ������λ   
%         snnew(chb)=abs(snew(chb)-1);      %0���1��1���0 
%     end  
% end
%                     
% %%%%%%%%%%%%����Ⱥѡ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %ѡ���������壬���ظ������ţ��п������������ͬ 
% function seln=selection(population,cumsump); %����Ⱥ��ѡ���������� 
%     for i=1:2   
%         r=rand;                              %����һ�������   
%         prand=cumsump-r;                     %���cumsump�е�һ����r���Ԫ��   
%         j=1;    
%         while prand(j)<0 
%             j=j+1;  
%         end
%         seln(i)=j;                            %ѡ�и������� 
%     end
% end
%     
%     
% %%%%%%%%%%%%��2������ת��Ϊ10������%%%%%%%%%%%%%%%%%%%%
% function x=transform2to10(Population); 
%     BitLength=size(Population,2);                %Population���У���2���Ƶĳ���
%     x=Population(BitLength);                  
%     for i=1:BitLength-1   
%         x=x+Population(BitLength-i)*power(2,i);  %��ĩλ�ӵ���λ
%     end
% end