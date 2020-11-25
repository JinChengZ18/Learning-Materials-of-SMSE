function [x,y,Result]=PSO_immu(func,N,c1,c2,w,MaxDT,D,eps,DS,replaceP,minD,Psum)
format long;
%%%%%%������ʼ������%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1=1.2;             %ѧϰ����1
c2=1.2;             %ѧϰ����2
w=0.8;            %����Ȩ��
MaxDT=800;        %����������
D=2;              %�����ռ�ά����δ֪��������
N=60;            %��ʼ��Ⱥ�������Ŀ
eps=10^(-10);     %���þ���(����֪��Сֵʱ����)
DS=8;             %ÿ��DS��ѭ���ͼ�����Ÿ����Ƿ����
replaceP=0.5;     %���ӵĸ��ʴ���replaceP���������滻
minD=1e-10;       %���Ӽ����С����
Psum=0;           %������ѵĺ�
range=100;
count = 0;
%%%%%%��ʼ����Ⱥ�ĸ���%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:D
        x(i,j)=-range+2*range*rand;  %�����ʼ��λ��
        v(i,j)=randn;  %�����ʼ���ٶ�
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg%%%%%%%%%%%%%%%%%%% 
for i=1:N    
    p(i)=feval(func,x(i,:));
    
    y(i,:)=x(i,:);
end
pg=x(1,:);             %PgΪȫ������
for i=2:N
    if feval(func,x(i,:))<feval(func,pg)    
        pg=x(i,:);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%��ѭ�������չ�ʽ���ε�����ֱ�����㾫��Ҫ��%%%%%%% 
for t=1:MaxDT
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if feval(func,x(i,:))<p(i) 
            p(i)=feval(func,x(i,:)); 
            y(i,:)=x(i,:);
        end
        if p(i)<feval(func,pg)  
            pg=y(i,:);
            subplot(1,2,1);            
            bar(pg,0.25); 
            axis([0 3 -40 40 ]) ;
            title (['Iteration  ', num2str(t)]); pause (0.1);
            subplot(1,2,2); 
          plot(pg(1,1),pg(1,2),'rs','MarkerFaceColor','r', 'MarkerSize',8)
            hold on;
            plot(x(:,1),x(:,2),'k.');
            set(gca,'Color','g')
            hold off;
            grid on;
            axis([-100 100 -100 100 ]) ;
            title(['Global Min =  ',num2str(p(i))]);
            xlabel(['Min_x= ',num2str(pg(1,1)),'  Min_y= ',num2str(pg(1,2))]);
            
        end
    end
    Pbest(t)=feval(func,pg) ;   
%     if Foxhole(pg,D)<eps                %���������㾫��Ҫ��������ѭ��
%         break;
%     end
%%%%%��ʼ��������%%%%%%%%%%%%%%%%%
    if t>DS
       if mod(t,DS)==0 && (Pbest(t-DS+1)-Pbest(t))<1e-020    %�������DS������Ⱥ���е�����û�����Ա��ţ����������.
            %�ں������ԵĹ����з��֣�����һ�������ĸ��£��������Ų���ȫ��ȣ����仯�ǳ��ǳ�С��
           for i=1:N                            %�ȼ�����������ŵĺ�
             Psum=Psum+p(i);
           end
           
           for i=1:N                            %���߳���              
               
               for j=1:N                        %����ÿ�����������i�ľ���
                   distance(j)=abs(p(j)-p(i));
               end
               num=0;   
               for j=1:N                        %�������i���������С��minD�ĸ���
                   if distance(j)<minD
                       num=num+1;
                   end
               end
               PF(i)=p(N-i+1)/Psum;             %������Ӧ�ȸ���
               PD(i)=num/N;                     %�������Ũ��
               
               a=rand;                          %������ɼ����滻���ʵ�����
               PR(i)=a*PF(i)+(1-a)*PD(i);       %�����滻����
           end
           
            for i=1:N
                if PR(i)>replaceP
                    x(i,:)=-range+2*range*rand(1,D);
               count=count+1;
                end
           end
       end
    end    
end
 
%%%%%%%������������%%%%%%%%%%%%%%%%%%%%
x=pg(1,1);
y=pg(1,2);
Result=feval(func,pg);
%%%%%%%%%%�㷨����%%%%%%%%%%%%%%%%%%
function probabolity(N,i)
PF=p(N-i)/Psum;%��Ӧ�ȸ���
disp(PF);
for jj=1:N
  distance(jj)=abs(P(jj)-P(i));
end
num=0;
for ii=1:N
    if distance(ii)<minD
        num=num+1;
    end
end
PD=num/N;            %����Ũ��
PR=a*PF+(1-a)*PD;     %�滻����