%适应度计算
function [fitness,b,number]=fitnessty(pop,lanti,I,popsize,m,n,number)
 num=m*n;
 for i=1:popsize
     number=number+1;
        anti=pop(i,:);            
        lowsum=0;                  %低于阈值的灰度值之和
        lownum=0;                  %低于阈值的像素点的个数
        highsum=0;                 %高于阈值的灰度值之和
        highnum=0;                 %高于阈值的像素点的个数
        a=0;                 
        for j=1:lanti
            a=a+anti(1,j)*(2^(j-1));  %加权求和
        end
        b(1,i)=a*255/(2^lanti-1);     
        for x=1:m
            for y=1:n
                if I(x,y)<b(1,i)
                    lowsum=lowsum+double(I(x,y));
                    lownum=lownum+1;
                else  
                    highsum=highsum+double(I(x,y));
                    highnum=highnum+1;
                end
            end
        end
        u=(lowsum+highsum)/num;
        if lownum~=0
            u0=lowsum/lownum;
        else 
            u0=0;
        end
        if highnum~=0
            u1=highsum/highnum;
        else 
            u1=0;
        end
        w0=lownum/(num);
        w1=highnum/(num);
        fitness(1,i)=w0*(u0-u)^2+w1*(u1-u)^2;   
 end
 
end
