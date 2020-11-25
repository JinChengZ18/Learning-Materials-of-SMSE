clear all;
clc;
T=256;       % 图像维数
SUB_T=T/2;   % 子图维数
%调原始图像矩阵
load wbarb; % 下载图像
f=X;         % 原始图像
%进行二维小波分解
l=wfilters('db10','l');    % db10（消失矩为10)低通分解滤波器冲击响应（长度为20）
L=T-length(l);
l_zeros=[l,zeros(1,L)];    % 矩阵行数与输入图像一致，为2的整数幂
h=wfilters('db10','h');    % db10（消失矩为10)高通分解滤波器冲击响应（长度为20）
h_zeros=[h,zeros(1,L)];    % 矩阵行数与输入图像一致，为2的整数幂
for i=1:T;   % 列变换
    row(1:SUB_T,i)=dyaddown( ifft( fft(l_zeros).*fft(f(:,i)') ) ).';    % 圆周卷积<->FFT
    row(SUB_T+1:T,i)=dyaddown( ifft( fft(h_zeros).*fft(f(:,i)') ) ).'; % 圆周卷积<->FFT
end;
for j=1:T;   % 行变换
    line(j,1:SUB_T)=dyaddown( ifft( fft(l_zeros).*fft(row(j,:)) ) );    % 圆周卷积<->FFT
    line(j,SUB_T+1:T)=dyaddown( ifft( fft(h_zeros).*fft(row(j,:)) ) ); % 圆周卷积<->FFT
end;
decompose_pic=line; % 分解矩阵
% 图像分为四块
lt_pic=decompose_pic(1:SUB_T,1:SUB_T);      % 在矩阵左上方为低频分量--fi(x)*fi(y)
rt_pic=decompose_pic(1:SUB_T,SUB_T+1:T);    % 矩阵右上为--fi(x)*psi(y)
lb_pic=decompose_pic(SUB_T+1:T,1:SUB_T);    % 矩阵左下为--psi(x)*fi(y)
rb_pic=decompose_pic(SUB_T+1:T,SUB_T+1:T); % 右下方为高频分量--psi(x)*psi(y)
%分解结果显示
figure(1);
colormap(map);
subplot(2,1,1);
image(f);
title('原始图像');
subplot(2,1,2);
image(abs(decompose_pic)); 
title('分解后图像');
figure(2);
colormap(map);
subplot(2,1,1);
image(abs(lt_pic)); % 左上方为低频分量--fi(x)*fi(y)
title('低频分量');
subplot(2,1,2);
image(abs(rb_pic)); 
title('高频分量');
%重构源图像及结果显示
l_re=l_zeros(end:-1:1);   % 重构低通滤波
l_r=circshift(l_re',1)'; % 位置调整
h_re=h_zeros(end:-1:1);   % 重构高通滤波
h_r=circshift(h_re',1)'; % 位置调整

top_pic=[lt_pic,rt_pic]; % 图像上半部分
t=0;
for i=1:T; % 行插值低频

    if (mod(i,2)==0)
        topll(i,:)=top_pic(t,:); % 偶数行保持
    else
        t=t+1;
        topll(i,:)=zeros(1,T);   % 奇数行为零
    end
end;
for i=1:T; % 列变换
    topcl_re(:,i)=ifft( fft(l_r).*fft(topll(:,i)') )'; % 圆周卷积<->FFT
end;

bottom_pic=[lb_pic,rb_pic]; % 图像下半部分
t=0;
for i=1:T; % 行插值高频
    if (mod(i,2)==0)
        bottomlh(i,:)=bottom_pic(t,:); % 偶数行保持
    else
        bottomlh(i,:)=zeros(1,T);       % 奇数行为零
        t=t+1;
    end
end;
for i=1:T; % 列变换
    bottomch_re(:,i)=ifft( fft(h_r).*fft(bottomlh(:,i)') )'; % 圆周卷积<->FFT
end;

construct1=bottomch_re+topcl_re; % 列变换重构完毕

left_pic=construct1(:,1:SUB_T);   % 图像左半部分
t=0;
for i=1:T; % 列插值低频

    if (mod(i,2)==0)
        leftll(:,i)=left_pic(:,t); % 偶数列保持
    else
        t=t+1;
        leftll(:,i)=zeros(T,1);    % 奇数列为零
    end
end;
for i=1:T; % 行变换
    leftcl_re(i,:)=ifft( fft(l_r).*fft(leftll(i,:)) ); % 圆周卷积<->FFT
end;

right_pic=construct1(:,SUB_T+1:T); % 图像右半部分
t=0;
for i=1:T; % 列插值高频
    if (mod(i,2)==0)
        rightlh(:,i)=right_pic(:,t); % 偶数列保持
    else
        rightlh(:,i)=zeros(T,1);      % 奇数列为零
        t=t+1;
    end
end;
for i=1:T; % 行变换
    rightch_re(i,:)=ifft( fft(h_r).*fft(rightlh(i,:)) ); % 圆周卷积<->FFT
end;

construct_pic=rightch_re+leftcl_re; % 重建全部图像

% 结果显示
figure(3);
colormap(map);
subplot(2,1,1);
image(f); 
title('源图像显示');
subplot(2,1,2);
image(abs(construct_pic));  
title('重构源图像显示');
error=abs(construct_pic-f); 
figure(4);
mesh(error); % 误差三维图像
title('重构图形与原始图像误值');      
