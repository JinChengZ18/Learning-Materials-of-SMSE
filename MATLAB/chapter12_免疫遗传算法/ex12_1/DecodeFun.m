function X=DecodeFun(A,xmin,xmax)
A=fliplr(A); %×óÓÒ·­×ª¾ØÕóA
SA=size(A);
AX=0:1:21;
AX=ones(SA(1),1)*AX;
SX=sum((A.*2.^AX)');
X=xmin+(xmax-xmin)*SX./4194303;
end
