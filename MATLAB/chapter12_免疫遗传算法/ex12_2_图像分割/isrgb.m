%ÅÐ¶ÏÊÇ·ñÎªRGBÕæ²ÊÍ¼Ïñ
function y = isrgb(x)
wid = sprintf('Images:%s:obsoleteFunction',mfilename);
str1= sprintf('%s is obsolete and may be removed in the future.',mfilename);
str2 = 'See product release notes for more information.';
warning(wid,'%s\n%s',str1,str2);

y = size(x,3)==3;
if y
   if isa(x, 'logical')
      y = false;
   elseif isa(x, 'double')
      m = size(x,1);
      n = size(x,2);
      chunk = x(1:min(m,10),1:min(n,10),:);         
      y = (min(chunk(:))>=0 && max(chunk(:))<=1);
      if y
         y = (min(x(:))>=0 && max(x(:))<=1);
      end
   end
end