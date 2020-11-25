clear all;
clc;
T=256;       % ͼ��ά��
SUB_T=T/2;   % ��ͼά��
%��ԭʼͼ�����
load wbarb; % ����ͼ��
f=X;         % ԭʼͼ��
%���ж�άС���ֽ�
l=wfilters('db10','l');    % db10����ʧ��Ϊ10)��ͨ�ֽ��˲��������Ӧ������Ϊ20��
L=T-length(l);
l_zeros=[l,zeros(1,L)];    % ��������������ͼ��һ�£�Ϊ2��������
h=wfilters('db10','h');    % db10����ʧ��Ϊ10)��ͨ�ֽ��˲��������Ӧ������Ϊ20��
h_zeros=[h,zeros(1,L)];    % ��������������ͼ��һ�£�Ϊ2��������
for i=1:T;   % �б任
    row(1:SUB_T,i)=dyaddown( ifft( fft(l_zeros).*fft(f(:,i)') ) ).';    % Բ�ܾ��<->FFT
    row(SUB_T+1:T,i)=dyaddown( ifft( fft(h_zeros).*fft(f(:,i)') ) ).'; % Բ�ܾ��<->FFT
end;
for j=1:T;   % �б任
    line(j,1:SUB_T)=dyaddown( ifft( fft(l_zeros).*fft(row(j,:)) ) );    % Բ�ܾ��<->FFT
    line(j,SUB_T+1:T)=dyaddown( ifft( fft(h_zeros).*fft(row(j,:)) ) ); % Բ�ܾ��<->FFT
end;
decompose_pic=line; % �ֽ����
% ͼ���Ϊ�Ŀ�
lt_pic=decompose_pic(1:SUB_T,1:SUB_T);      % �ھ������Ϸ�Ϊ��Ƶ����--fi(x)*fi(y)
rt_pic=decompose_pic(1:SUB_T,SUB_T+1:T);    % ��������Ϊ--fi(x)*psi(y)
lb_pic=decompose_pic(SUB_T+1:T,1:SUB_T);    % ��������Ϊ--psi(x)*fi(y)
rb_pic=decompose_pic(SUB_T+1:T,SUB_T+1:T); % ���·�Ϊ��Ƶ����--psi(x)*psi(y)
%�ֽ�����ʾ
figure(1);
colormap(map);
subplot(2,1,1);
image(f);
title('ԭʼͼ��');
subplot(2,1,2);
image(abs(decompose_pic)); 
title('�ֽ��ͼ��');
figure(2);
colormap(map);
subplot(2,1,1);
image(abs(lt_pic)); % ���Ϸ�Ϊ��Ƶ����--fi(x)*fi(y)
title('��Ƶ����');
subplot(2,1,2);
image(abs(rb_pic)); 
title('��Ƶ����');
%�ع�Դͼ�񼰽����ʾ
l_re=l_zeros(end:-1:1);   % �ع���ͨ�˲�
l_r=circshift(l_re',1)'; % λ�õ���
h_re=h_zeros(end:-1:1);   % �ع���ͨ�˲�
h_r=circshift(h_re',1)'; % λ�õ���

top_pic=[lt_pic,rt_pic]; % ͼ���ϰ벿��
t=0;
for i=1:T; % �в�ֵ��Ƶ

    if (mod(i,2)==0)
        topll(i,:)=top_pic(t,:); % ż���б���
    else
        t=t+1;
        topll(i,:)=zeros(1,T);   % ������Ϊ��
    end
end;
for i=1:T; % �б任
    topcl_re(:,i)=ifft( fft(l_r).*fft(topll(:,i)') )'; % Բ�ܾ��<->FFT
end;

bottom_pic=[lb_pic,rb_pic]; % ͼ���°벿��
t=0;
for i=1:T; % �в�ֵ��Ƶ
    if (mod(i,2)==0)
        bottomlh(i,:)=bottom_pic(t,:); % ż���б���
    else
        bottomlh(i,:)=zeros(1,T);       % ������Ϊ��
        t=t+1;
    end
end;
for i=1:T; % �б任
    bottomch_re(:,i)=ifft( fft(h_r).*fft(bottomlh(:,i)') )'; % Բ�ܾ��<->FFT
end;

construct1=bottomch_re+topcl_re; % �б任�ع����

left_pic=construct1(:,1:SUB_T);   % ͼ����벿��
t=0;
for i=1:T; % �в�ֵ��Ƶ

    if (mod(i,2)==0)
        leftll(:,i)=left_pic(:,t); % ż���б���
    else
        t=t+1;
        leftll(:,i)=zeros(T,1);    % ������Ϊ��
    end
end;
for i=1:T; % �б任
    leftcl_re(i,:)=ifft( fft(l_r).*fft(leftll(i,:)) ); % Բ�ܾ��<->FFT
end;

right_pic=construct1(:,SUB_T+1:T); % ͼ���Ұ벿��
t=0;
for i=1:T; % �в�ֵ��Ƶ
    if (mod(i,2)==0)
        rightlh(:,i)=right_pic(:,t); % ż���б���
    else
        rightlh(:,i)=zeros(T,1);      % ������Ϊ��
        t=t+1;
    end
end;
for i=1:T; % �б任
    rightch_re(i,:)=ifft( fft(h_r).*fft(rightlh(i,:)) ); % Բ�ܾ��<->FFT
end;

construct_pic=rightch_re+leftcl_re; % �ؽ�ȫ��ͼ��

% �����ʾ
figure(3);
colormap(map);
subplot(2,1,1);
image(f); 
title('Դͼ����ʾ');
subplot(2,1,2);
image(abs(construct_pic));  
title('�ع�Դͼ����ʾ');
error=abs(construct_pic-f); 
figure(4);
mesh(error); % �����άͼ��
title('�ع�ͼ����ԭʼͼ����ֵ');      
