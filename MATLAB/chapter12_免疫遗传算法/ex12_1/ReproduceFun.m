%��¡����
function [T,AAS]=ReproduceFun(mn,cfactor,m,Affinity,A,T);
if mn==1
    CS=m;
    T=ones(m,1)*A(Affinity(end),:);
else
    for i=1:mn
        %ÿ������Ŀ�¡�������Ϳ�ԭ���׺Ͷȳ�����%
        CS(i)=round(cfactor*m);
        %����ÿ������Ŀ�¡��ĿCS(i)
        AAS(i)=sum(CS); 
        %ÿ�������¡�������±�λ��
        ONECS=ones(CS(i),1); 
        %����CS(i)��1�е�λ����ONECS
        subscript=Affinity(end-i+1); 
        %ȷ����ǰҪ��¡�����ڿ��弯A�е��±�
        AA=A(subscript,:); 
        %ȷ����ǰҪ��¡����Ļ������м���AA(1��n)
        T=[T;ONECS*AA]; 
        %�õ���ʱ��ſ���ļ���T
    end
end
