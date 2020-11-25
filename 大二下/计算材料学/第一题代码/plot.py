import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math
import os


# def plot(r,v,N,Ks,Ps,K_sums,P_sums,L,T,steps,step,name='md2'):
def plot(r,v,N,rho,Ks,Ps,K_sums,P_sums,E_sums,d_avers,L,T,steps,step,name):
	'''
	scatter_3d_plot(r,v,N,Ks,Ps,K_sums,P_sums,L,T,steps,step,name='md2')
	r is positions, in shape [N,3]      ---numpy array
	v is velocities, in shape [N,3]     ---numpy array
	N is the number of atoms            ---scalar
	rho is the particle density			---scalar
	Ks are the kinetics                 ---numpy array
	Ps are the potientials              ---numpy array
	K_sums is the sum of kinetics              ---list
	P_sums is the sum of potentials            ---list
	E_sums is the sum of energy            	   ---list
	d_avers is the average distance			   ---list
	L is the size of the lattice               ---scalar
	T is the initial Temperature               ---scalar
	'''
	# 全局变量step_list
	
	# 子图的位置和大小
	left, width = 0.2, 1
	bottom, height = 0.2, 1
	spacing = 0.2
	rect_s1 = [left*0, bottom, width, height]  # Scatter
	rect_s2 = [left*0 + width + spacing, bottom, width, height]  # Scatter

	rect_k = [left, bottom-height*0.4-spacing, width*0.8, height*0.4]  # overall
	rect_p = [left + width + spacing, bottom-height*0.4-spacing, width*0.8, height*0.4]  # overall_plot

	rect_e = [left, bottom-height*0.4*2-spacing*2, width*0.8, height*0.4]  # overall
	rect_d = [left + width + spacing, bottom-height*0.4*2-spacing*2, width*0.8, height*0.4]  # overall_plot
	rect_a = [left*0 + width*2 + spacing*2, bottom-height*0.4-spacing, width*0.4, height*0.4]  # Pie
	# Plot
	fig = plt.figure()
	overall_plot(fig,T,K_sums,P_sums,E_sums,d_avers,steps,step,rect_k,rect_p,rect_e,rect_d)
	# overall_plot(fig,K_sums,P_sums,E_sums,d_aver,steps,step,rect_k,rect_p,rect_e,rect_d):
	scatter_3d_plot(fig,r,v,N,rho,Ks,Ps,L,rect_s1,rect_s2)
	polar_plot(fig,v,N,rect_a)
	
	# Save
	path = '/PARA/blsc200/jincheng/HW1/img/'+name+'_T'+str(T)+'/'
	#path = '/home/jincheng18/Desktop/计算材料学Homework1/img/'+name+'_T'+str(T)+'/'
	try:
		os.makedirs(path)
		#name = 'img/'+name+'_T'+str(T)+'/'+'step_'+str(step).zfill(10)+'.png'
		name = 'step_'+str(step).zfill(10)+'.png'
		plt.savefig(path+name,bbox_inches='tight')
		plt.close()
	except:
		name = 'step_'+str(step).zfill(10)+'.png'
		plt.savefig(path+name,bbox_inches='tight')
		plt.close()	


def overall_plot(fig,T,K_sums,P_sums,E_sums,d_avers,steps,step,rect_k,rect_p,rect_e,rect_d):
	step_list = np.array(range(step))
	K_sums = np.array(K_sums)
	P_sums = np.array(P_sums)
	E_sums = np.array(E_sums)
	d_avers = np.array(d_avers)	
	# Subplot
	axk_sum = fig.add_axes(rect_k)
	axp_sum = fig.add_axes(rect_p)
	axe_sum = fig.add_axes(rect_e)
	axd_aver = fig.add_axes(rect_d)
	axk_sum.set_xlim(0, steps)
	axp_sum.set_xlim(0, steps)
	axe_sum.set_xlim(0, steps)
	axd_aver.set_xlim(0, steps)
	axk_sum.plot(step_list, K_sums, label='T:'+str(T))
	axp_sum.plot(step_list, P_sums, label='T:'+str(T))
	axe_sum.plot(step_list, E_sums, label='T:'+str(T))
	axd_aver.plot(step_list,d_avers,label='T:'+str(T))
	# Subplot
	axk_sum.legend()
	axp_sum.legend()
	axe_sum.legend()
	axd_aver.legend()
	axk_sum.set_xlabel('Step'); axk_sum.set_ylabel('Average Kinetic')
	axp_sum.set_xlabel('Step'); axp_sum.set_ylabel('Average Potential')
	axe_sum.set_xlabel('Step'); axe_sum.set_ylabel('Average Energy')
	axd_aver.set_xlabel('Step');axd_aver.set_ylabel('Average Distance')



def scatter_3d_plot(fig,r,v,N,rho,Ks,Ps,L,rect_s1,rect_s2):
	# 使用切片提取二维数组内的数据
	xs = r[:,0]
	ys = r[:,1]
	zs = r[:,2]
	# Subplot
	axk = fig.add_axes(rect_s1,projection='3d')
	axp = fig.add_axes(rect_s2, projection='3d')
	axk.set_xlim(0, L);	axk.set_ylim(0, L);	axk.set_zlim(0, L)
	axp.set_xlim(0, L);	axp.set_ylim(0, L);	axp.set_zlim(0, L)
	# Subplot
	axk.scatter(xs, ys, zs, c=Ks,cmap=plt.cm.rainbow,s=4.,label = 'rho:'+str(rho)+'N:'+str(N))
	# ax.scatter(xs, ys, zs, c=zs,cmap=plt.cm.rainbow,marker=m)
	axp.scatter(xs, ys, zs, c=Ps,cmap=plt.cm.rainbow,s=4.,label = 'rho:'+str(rho)+'N:'+str(N))
	axk.set_xlabel('Dimension X'); axk.set_ylabel('Dimension Y'); axk.set_zlabel('Dimension Z')
	axp.set_xlabel('Dimension X'); axp.set_ylabel('Dimension Y'); axp.set_zlabel('Dimension Z')
	axk.set_title('Kinetic of Each Particle')
	axp.set_title('Potential of Each Particle')
	axk.legend()
	axp.legend()
	

def computeTheta(v,N):
	thetas=[]
	for i in range(N):
		cos = v[i,0]/pow(v[i,0]**2+v[i,1]**2, 0.5)
		theta = math.acos(cos)
		thetas.append(theta)
	return thetas


def polar_plot(fig,v,N,rect_a):
	# 计算得x-y平面上粒子运动的方位角
	thetas = computeTheta(v,N)
	polar_num = 40
	polar_count = []
	polar = np.linspace(0.0, 2 * np.pi, polar_num, endpoint=False)	 # 设置切分区域20个
	listLabels = list(range(polar_num-1))  # 设置切分后对应标签
	
	# 利用pd.cut进行数据离散化切分
	theta_cut = pd.cut(thetas,bins=list(polar),labels=listLabels)
	# 得到分组的list
	for listLabel in listLabels:
		polar_count.append(theta_cut[listLabel])

	polar_count = np.array(polar_count)/max(polar_count)
	
	theta = np.linspace(0.0, 2 * np.pi, len(polar_count), endpoint=False)
	radii = 10 * polar_count
	width = np.pi / 4 * polar_count
	colors = plt.cm.viridis(radii / 10.)

	axpol = fig.add_axes(rect_a,projection='polar')
	axpol.bar(theta, radii, width=width, bottom=0.0, color=colors, alpha=0.5)
	axpol.set_title('Angular Distribution')