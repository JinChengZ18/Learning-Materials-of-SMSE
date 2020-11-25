function A=InitializeFun(m,n)
A=2.*rand(m,n)-1;
A=hardlim(A);
end
