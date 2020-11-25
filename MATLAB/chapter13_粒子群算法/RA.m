function y=RA(x)
%输入x,并给出相应的y值,在x=(0,0,…,0)处有全局极小点0
[row,col]=size(x);
if row>1
    error('输入的参数错误');
end
y=sum(x.^2-10*cos(2*pi*x)+10);
y=-y;
