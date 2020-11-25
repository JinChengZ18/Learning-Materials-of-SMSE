详情见：https://editor.csdn.net/md/?articleId=106865611


使用 python 自带的 tkinter 库实现基于 mysql 的简单图形化学生信息管理系统。在本地安装好 mysql 即可打开使用。功能有：

1. 简单的访问控制
2. 账号管理
3. 账号协作
4. 统计计算
5. 数据可视化
6. 数据库数据的导入导出（Excel）
7. 数据排序
8. 数据表的内容增、删、改、查。



登陆/注册界面：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234120718.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

首先进行注册：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234120629.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

第一次使用会弹出下面的对话，选 ‘是’ 则开始创建程序所需的数据库，重新注册时可以开始使用：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234120366.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)


提供管理员信息：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234120448.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234120562.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

注册后登陆，开始的界面，在文件菜单下可以创建新的表格（注册时系统会默认创建一个和用户同名的表格）：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234119907.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

文件菜单下导入数据的选项：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627776.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

导入成功，注意导入数据应当有合适的结构，系统默认导入文件为 excel-2010(.xlsx) 格式（其实也只做了一种hiahiahia），默认跳过第一行（表头）并按顺序导入前 8 列的数据，其中第二列学号为主码，所以不能有缺失：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627659.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

当学号重复时，会有如下提示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234859130.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

查找功能：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627807.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627663.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

数据修改功能：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627740.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

插入新实例：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235030234.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

成绩修改功能（也可以改名字）：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235343518.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)


删除单项数据一个实例中的某个属性（除主码学号外），想删那个就在哪个框框里面随心所欲地输点东西就行：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619234627767.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

批量删除，当姓名学号为空时清空表格，否则删除匹配的项：

![在这里插入图片描述](https://img-blog.csdnimg.cn/202006192352468.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235317629.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

表格导出功能：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235438884.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235449662.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

按特定列进行排序：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235511987.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

统计工具，计算总数、平均数、标准差和中位数：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235541128.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235541106.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

统计功能也能和查找功能混合使用：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235723244.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

数据可视化，提供了两个选项，直方图和饼图，具体的数据接口我没时间做了，这里只是两个demo，有兴趣的小伙伴可以接着完善一下，需要的数据结构我写在文件的 360 行左右：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235749113.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235749251.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

协作功能，调用管理员权限查看本地用户：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235837200.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

可以将自己的权限给其他人，查看权限只能 SELECT，不能对表格 UPDATE 或 INSERT 等，有限权限可以增删改查，但是不能把权限再给其他人，完全权限包括所有的权限，可以授权给他人：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235902751.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

一个没啥用的帮助文档 _ (:τ」∠)_，在本地的txt，删了也行：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200619235924972.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)

其他功能如账号冻结、密码修改：

![在这里插入图片描述](https://img-blog.csdnimg.cn/2020062000001374.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/2020062000001333.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NTkyMDY3Mw==,size_16,color_FFFFFF,t_70)




------

重要：本系统需要管理员权限，下载后请将 index.py 的第 16 行进行修改，填入你自己设置的管理员名称和密码，否则无法正常使用！

另系统是数据库导论的大作业，期末考完后赶工做的，可能比较粗糙，目前只能本地运行，经过修改后也能远程访问（把 'localhost' 换掉就行）。如果报错一般是没装对应的库，基本上命令行 pip install xxx 就行。




