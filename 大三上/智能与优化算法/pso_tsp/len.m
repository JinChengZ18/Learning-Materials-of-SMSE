function len_best=len(pn,n,distant,route_best)    
    for i=1:pn
        len_best(i)=0;
        for j=1:n-1
            len_best(i)=distant(route_best(i,j),route_best(i,j+1))+len_best(i);
        end
        len_best(i)=len_best(i)+distant(route_best(i,end),route_best(i,1));
    end
end
    