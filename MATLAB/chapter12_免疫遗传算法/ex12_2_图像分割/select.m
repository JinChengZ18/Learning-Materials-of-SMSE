%Ñ¡Ôñ²Ù×÷
function v=select(v,fit)
[px,py]=size(v);
for i=1:px;
pfit(i)=fit(i)./sum(fit);
end
pfit=cumsum(pfit);
if pfit(px)<1
    pfit(px)=1;
end
rs=rand(1,10);
for i=1:10
    ss=0 ;
    for j=1:px
        if rs(i)<=pfit(j)
            v(i,:) = v(j,:);
            ss=1;
        end
        if ss==1
            break;
        end
    end
end