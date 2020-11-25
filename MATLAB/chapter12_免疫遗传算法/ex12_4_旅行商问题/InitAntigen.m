function result = InitAntigen(A, B)
[m,n] = size(A);
global D;
Index = 1:n;
result = [B];
tmp = B;
Index(:,B) = [];
for col = 2:n
    [p,q] = size(Index);
    tmplen = D(tmp,Index(1,1));
    tmpID = 1;
    for ss = 1:q
        if D(tmp,Index(1,ss)) < tmplen
            tmpID = ss;
            tmplen = D(tmp,Index(1,ss));
        end
    end
    tmp = Index(1,tmpID);
    result = [result tmp];
    Index(:,tmpID) = [];
end
