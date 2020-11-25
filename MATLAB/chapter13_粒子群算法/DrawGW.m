clear all
clc
x=[-7:0.05:7];
y=x;
[X,Y]=meshgrid(x,y);
[row,col]=size(X);
for l=1:col
   for h=1:row
       z(h,l)=GW([X(h,l),Y(h,l)]);
   end
end
surf(X,Y,z);
shading interp
