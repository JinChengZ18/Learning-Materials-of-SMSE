#coding=utf-8

import os
import cv2
import numpy as np

for T in [0.005,0.01,0.05,0.1,0.5,1,2]:
	# path = '/PARA/blsc200/jincheng/HW1/img/'+name+'_T'+str(T)+'/'
	name = 'md2_0504'
	path = 'img/'+name+ '_T'+str(T)+'/'
	filelist = os.listdir(path)
	filelist.sort()

	fps = 60  # 视频每秒60帧
	img = cv2.imread(path+filelist[1])
	size = img.shape # 需要转为视频的图片的尺寸
	size1 = size[0]
	size2 = size[1]
	size = (size2,size1)
	# 可以使用cv2.resize()进行修改

	video = cv2.VideoWriter('md2_'+name+'_T'+str(T)+'.avi', cv2.VideoWriter_fourcc('X','V','I','D'), fps, size)
	# 视频保存在当前目录下
	# print(filelist)

	for item in filelist:
		if item.endswith('.png'):
			# print(item)

		#找到路径中所有后缀名为.png的文件，可以更换为.jpg或其它
			item = path + item
			img = cv2.imread(item)

			video.write(img)
			cv2.destroyAllWindows()
	video.release()

	print('video size:')
	print(size)
	print('\n A new video has been created!')