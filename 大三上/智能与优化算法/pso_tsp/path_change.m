function b=path_change(b,t)
if any(t)
    for k=1:size(b,1)
        for i=1:size(b,2)
            if t(k,i)~=0
                b(k,[i,t(k,i)])=b(k,[t(k,i),i]);
            end
        end
    end
end