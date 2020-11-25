function [min,path]=dijkstra(w,start,terminal)
n=size(w,1); label(start)=0; f(start)=start;
for i=1:n
   if i~=start
       label(i)=inf;
end, end
s(1)=start; u=start;
while length(s)<n
   for i=1:n
      ins=0;
      for j=1:length(s)
         if i==s(j)
            ins=1;
      end,  end
      if ins==0
         v=i;
         if label(v)>(label(u)+w(u,v))
            label(v)=(label(u)+w(u,v)); f(v)=u;
         end
      end
   end
   
   v1=0;
   k=inf;
   for i=1:n
         ins=0;
         for j=1:length(s)
            if i==s(j)
               ins=1;
         end, end
         if ins==0
            v=i;
            if k>label(v)
               k=label(v);  v1=v;
   end,  end,  end
   s(length(s)+1)=v1;
   u=v1;
end

min=label(terminal); path(1)=terminal;
i=1;
while path(i)~=start
      path(i+1)=f(path(i));
      i=i+1 ;
end
 path(i)=start;
L=length(path);
path=path(L:-1:1);

