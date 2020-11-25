clear all
clc
%��ʼ�� 
rate1=0.004;
rate2=0.007;
rate3=0.009;
k=0.47;
K=3;
y_1=zeros(3,1);
y_2=y_1;
y_3=y_2; 
u_1=zeros(3,1);
u_2=u_1;
u_3=u_2;   
h1i=zeros(3,1);
h1i_1=h1i;  %��һ��������
h2i=zeros(3,1);
h2i_1=h2i;  %�ڶ���������
h3i=zeros(3,1);
h3i_1=h3i;  %������������
x1i=zeros(3,1);
x2i=x1i;
x3i=x2i;
%������
x1i_1=x1i;
x2i_1=x2i;
x3i_1=x3i;  
%��ʼ��
k0=0.045;
%��һ��Ȩֵ
w11=k0*rand(3,2);
w11_1=w11;
w11_2=w11_1;
w12=k0*rand(3,2);
w12_1=w12;
w12_2=w12_1;
w13=k0*rand(3,2);
w13_1=w13;
w13_2=w13_1;
%�ڶ���Ȩֵ
w21=k0*rand(1,9);
w21_1=w21;
w21_2=w21_1;
w22=k0*rand(1,9);
w22_1=w22;
w22_2=w22_1;
w23=k0*rand(1,9);
w23_1=w23;
w23_2=w23_1;
 
%�޶�ֵ
ynmax=1;
ynmin=-1;  %ϵͳ���ֵ�޶�
xpmax=1;
xpmin=-1;  %P�ڵ�����޶�
qimax=1;
qimin=-1;  %I�ڵ�����޶�
qdmax=1;
qdmin=-1;  %D�ڵ�����޶�
uhmax=1;
uhmin=-1;  %�������޶�
%��������Ż�
for k=1:1:150
    %ϵͳ���
    y1(k)=(0.4*y_1(1)+u_1(1)/(1+u_1(1)^2)+0.2*u_1(1)^3+0.5*u_1(2))+0.3*y_1(2);
    y2(k)=(0.2*y_1(2)+u_1(2)/(1+u_1(2)^2)+0.4*u_1(2)^3+0.2*u_1(1))+0.3*y_1(3);
    y3(k)=(0.3*y_1(3)+u_1(3)/(1+u_1(3)^2)+0.4*u_1(3)^3+0.4*u_1(2))+0.3*y_1(1);
    r1(k)=0.7;
    r2(k)=0.5;
    r3(k)=0.9;
    %����ϵͳ���
    yn=[y1(k),y2(k),y3(k)];
    yn(find(yn>ynmax))=ynmax;
    yn(find(yn<ynmin))=ynmin;
    %�����
    x1o=[r1(k);yn(1)];x2o=[r2(k);yn(2)];x3o=[r3(k);yn(3)];
    %������ 
    x1i=w11*x1o;
    x2i=w12*x2o;
    x3i=w13*x3o;
 
    %������ԪP����
    xp=[x1i(1),x2i(1),x3i(1)];
    xp(find(xp>xpmax))=xpmax;
    xp(find(xp<xpmin))=xpmin;
    qp=xp;
    h1i(1)=qp(1);
    h2i(1)=qp(2);
    h3i(1)=qp(3);
 
    %������ԪI����
    xi=[x1i(2),x2i(2),x3i(2)];
    qi=[0,0,0];
    qi_1=[h1i(2),h2i(2),h3i(2)];
    qi=qi_1+xi;
    qi(find(qi>qimax))=qimax;
    qi(find(qi<qimin))=qimin;
    h1i(2)=qi(1);
    h2i(2)=qi(2);
    h3i(2)=qi(3);
 
    %΢����ԪD����
    xd=[x1i(3),x2i(3),x3i(3)];
    qd=[0 0 0];
    xd_1=[x1i_1(3),x2i_1(3),x3i_1(3)];
    qd=xd-xd_1;
    qd(find(qd>qdmax))=qdmax;
    qd(find(qd<qdmin))=qdmin;
    h1i(3)=qd(1);
    h2i(3)=qd(2);
    h3i(3)=qd(3);
 
    %��������
    wo=[w21;w22;w23];
    qo=[h1i',h2i',h3i'];
    qo=qo';
    uh=wo*qo;
    uh(find(uh>uhmax))=uhmax;
    uh(find(uh<uhmin))=uhmin;
    u1(k)=uh(1);
    u2(k)=uh(2);
    u3(k)=uh(3);  
    %�������
    error=[r1(k)-y1(k);r2(k)-y2(k);r3(k)-y3(k)];  
    error1(k)=error(1);
    error2(k)=error(2);
    error3(k)=error(3);
    J(k)=0.5*(error(1)^2+error(2)^2+error(3)^2);   %������С
    ypc=[y1(k)-y_1(1);y2(k)-y_1(2);y3(k)-y_1(3)];
    uhc=[u_1(1)-u_2(1);u_1(2)-u_2(2);u_1(3)-u_2(3)];
    %������������Ȩֵ����
    Sig1=sign(ypc./(uhc(1)+0.00001));
    dw21=sum(error.*Sig1)*qo';  
    w21=w21+rate2*dw21+rate3*(w21_1-w21_2);
    Sig2=sign(ypc./(uh(2)+0.00001));
    dw22=sum(error.*Sig2)*qo';
    w22=w22+rate2*dw22+rate3*(w22_1-w21_2);
    Sig3=sign(ypc./(uh(3)+0.00001));
    dw23=sum(error.*Sig3)*qo';
    w23=w23+rate2*dw23+rate3*(w23_1-w23_2);
 
    %����������������Ȩֵ
    delta2=zeros(3,3);
    wshi=[w21;w22;w23];
    for t=1:1:3
        delta2(1:3,t)=error(1:3).*sign(ypc(1:3)./(uhc(t)+0.0000001));
    end
    for j=1:1:3
        sgn(j)=sign((h1i(j)-h1i_1(j))/(x1i(j)-x1i_1(j)+0.0001));
    end
 
     s1=sgn'*[r1(k),y1(k)];
     wshi2_1=wshi(1:3,1:3);
     alter=zeros(3,1);
     dws1=zeros(3,2);
     for j=1:1:3
         for p=1:1:3
             alter(j)=alter(j)+delta2(p,:)*wshi2_1(:,j);
         end
     end
     
     for p=1:1:3
         dws1(p,:)=alter(p)*s1(p,:);
     end
     w11=w11+rate1*dws1+rate3*(w11_1-w11_2);
 
     %����Ȩֵ
    for j=1:1:3
        sgn(j)=sign((h2i(j)-h2i_1(j))/(x2i(j)-x2i_1(j)+0.0000001));
    end
    s2=sgn'*[r2(k),y2(k)];
    wshi2_2=wshi(:,4:6);
    alter2=zeros(3,1);
    dws2=zeros(3,2);
    for j=1:1:3
        for p=1:1:3
            alter2(j)=alter2(j)+delta2(p,:)*wshi2_2(:,j);
        end
    end
    for p=1:1:3
        dws2(p,:)=alter2(p)*s2(p,:);
    end
    w12=w12+rate1*dws2+rate3*(w12_1-w12_2);
    
    for j=1:1:3
        sgn(j)=sign((h3i(j)-h3i_1(j))/(x3i(j)-x3i_1(j)+0.0000001));
    end
    s3=sgn'*[r3(k),y3(k)];
    wshi2_3=wshi(:,7:9);
    alter3=zeros(3,1);
    dws3=zeros(3,2);
    for j=1:1:3
        for p=1:1:3
            alter3(j)=(alter3(j)+delta2(p,:)*wshi2_3(:,j));
        end
    end
    for p=1:1:3
        dws3(p,:)=alter2(p)*s3(p,:);
    end
    w13=w13+rate1*dws3+rate3*(w13_1-w13_2);
 
    %��������
    u_3=u_2;
    u_2=u_1;
    u_1=uh;
    y_2=y_1;
    y_1=yn;
    h1i_1=h1i;
    h2i_1=h2i;
    h3i_1=h3i;
    x1i_1=x1i;
    x2i_1=x2i;
    x3i_1=x3i;
    w11_1=w11;
    w11_2=w11_1;
    w12_1=w12;
    w12_2=w12_1;
    w13_1=w13;
    w13_2=w13_1;
    %�ڶ���Ȩֵ
    w21_1=w21;
    w21_2=w21_1;
    w22_1=w22;
    w22_2=w22_1;
    w23_1=w23;
    w23_2=w23_1;
end
 
% �������
time=0.001*(1:k);
figure(1)
subplot(3,1,1)
plot(time,r1,'r-',time,y1,'b-');
title('PID�����������','fontsize',12);
ylabel('������һ','fontsize',12);
subplot(3,1,2)
plot(time,r2,'r-',time,y2,'b-');
ylabel('��������','fontsize',12);
subplot(3,1,3)
plot(time,r3,'r-',time,y3,'b-');       
xlabel('ʱ��/��','fontsize',12);
ylabel('������3','fontsize',12);
 
figure(2)
plot(time,u1,'r-',time,u2,'g-',time,u3,'b');
title('����Ŀ�������');
xlabel('ʱ��');
ylabel('������');
legend('u1','u2','u3');
grid on

figure(3)
plot(time,J,'r-');
axis([0,0.3,0,2]);
grid on
title('�����������','fontsize',12);
xlabel('ʱ��','fontsize',12);
ylabel('�������','fontsize',12);