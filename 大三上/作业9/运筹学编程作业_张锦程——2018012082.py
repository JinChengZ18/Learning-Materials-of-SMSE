import matplotlib.tri as tri
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
import time
import copy

def function_z(x, y): # 待优化的函数
    return (1-x)**2 + 2*(y-x**2)**2
def function_zsqrt(x, y):
    return ((1-x)**2 + 2*(y-x**2)**2)**0.25
def function_dz(x, y): # function_z 的导数矩阵, 也可由scipy求导
    return np.array([-2+2*x+8*x**3-8*x*y, 4*y-4*x**2])
def function_d2z(x, y): # function_z 的 Hessian 导数矩阵, 也可由scipy求二阶导
    return np.array([[2+24*x**2-8*y, -8*x], [-8*x, 4]])

def f_length(A): # 向量 A 的长度
    length2 = 0
    for i in range(len(A)):
        length2 += A[i]**2
    return length2**0.5

def newton_optimization(point0,ε,D): # point0为初始点，ε为搜索精度, D为搜索方向
    point=np.array(point0); D=np.array(D); t=1000
    N = 200; i = 0
    while (t>ε) or (t<-ε) :
        f  = function_z(point[0],point[1])
        df = np.dot(function_dz(point[0],point[1]),D)
        d2f= np.dot(D, np.dot(function_d2z(point[0],point[1]),D.T))
        if i > N:
            return point
        if df != 0:
            t = -df/d2f
            point = point + t*D
            print(t)
        else:
            return point
        i = i+1
    return point

def l1_optimization(point0): # point0 为待寻找优化方向的点
    # 维数
    dimension = len(point0)
    D = np.zeros(dimension)
    dz = function_dz(point0[0], point0[1])
    i  = np.argmax(abs(dz)) # 选定的优化坐标序号
    D[i]=-np.sign(dz[i])
def l2_optimization(point0): # point0 为待寻找优化方向的点
    # 维数
    dimension = len(point0)
    D = np.zeros(dimension)
    dz= function_dz(point0[0], point0[1])
    D = -dz/f_length(dz)
    return D
# Fletcher-Reeves共轭梯度法, f_nabla为先前一步的梯度绝对值,Di为前一步的优化方向
def FR_optimization(point0,f_nabla,Di):
    dz= function_dz(point0[0], point0[1])
    α = f_length(dz)**2/f_nabla**2 # f_nabla为∞时，α为0
    D = -dz + α*Di
    return D
def PR_optimization(point0,vec_nabla,Di):
    dz= function_dz(point0[0], point0[1])
    α = np.dot(dz,dz-vec_nabla)/f_length(vec_nabla)**2
    D = -dz + α*Di
    return D

def plot(name,f_values,f_nablas,f_points):
    min_d = -0.25; max_d = 1.25; n_d = 100
    x = np.linspace(min_d, max_d, n_d).flatten()
    y = np.linspace(min_d, max_d, n_d).flatten()
    X, Y = np.meshgrid(x, y)
    z = function_zsqrt(X, Y)

    plt.rcParams["figure.figsize"] = [22, 10]
    plt.rcParams["figure.dpi"] = 300
    plt.rcParams['font.size'] = '18' # 设置字体大小 
    plt.rcParams['lines.color'] = 'k'

    fig = plt.figure()
    grid = plt.GridSpec(8, 8, wspace=0.75, hspace=5)

    ax1=plt.subplot(grid[0:8,0:4]); ax2=plt.subplot(grid[0:4,4:8]); ax3=plt.subplot(grid[4:8,4:8])

    levels = np.arange(0., function_zsqrt(max_d+0.25, 0), 0.05)
    cmap = cm.get_cmap(name='coolwarm', lut=None)
    ax1.contourf(X,Y,z, levels=levels, cmap=cmap)
    ax1.contour(X,Y,z, levels=levels,
                  colors=['0.25', '0.75', '0.75', '0.75', '0.75'],
                  linewidths=[1.0, 0., 0., 0., 0.])
    ax1.set_xlabel(r'$x_1$'); ax1.set_ylabel(r'$x_2$')
    ax1.scatter([f_points[0][0]],[f_points[0][1]],color='',marker='o',edgecolors='r',s=100,label='Init Point')
    ax1.scatter([f_points[-1][0]],[f_points[-1][1]],color='',marker='o',edgecolors='b',s=100,label='End Point')
    
    ax1.text(min_d+0.05, min_d+0.1, r"$min\ f(𝑥_1,𝑥_2) = (1−𝑥_1)^2 + 2(𝑥_2−𝑥_1^2)^2$", fontsize=20)   
    legend1 = ax1.legend(fancybox=False,edgecolor='k',loc=2); frame1=legend1.get_frame(); frame1.set_alpha(1); frame1.set_facecolor('none')
    ax1.spines['top'].set_linewidth('2.0');ax1.spines['left'].set_linewidth('2.0')
    ax1.spines['bottom'].set_linewidth('2.0');ax1.spines['right'].set_linewidth('2.0')
    
    # 画箭头
    for i in range(len(f_points)-1):
        ax1.arrow(f_points[i][0],f_points[i][1], f_points[i+1][0]-f_points[i][0], f_points[i+1][1]-f_points[i][1],
                    width=0.008/(i+1),length_includes_head=True,head_width=0.03/(i+1),head_length=0.08/(i+1),fc='r',ec='r')   
    
    ax2.plot(list(range(len(f_values))), f_values, 'r', label=name+" optimization")
    ax2.set_xlabel('Iterations Times'); ax2.set_ylabel('Function Values')
    ax2.legend(framealpha=0)
    ax2.spines['top'].set_linewidth('2.0');ax2.spines['left'].set_linewidth('2.0')
    ax2.spines['bottom'].set_linewidth('2.0');ax2.spines['right'].set_linewidth('2.0')
    
    
    ax3.plot(list(range(len(f_nablas))), f_nablas, 'r', label=name+" optimization")
    ax3.set_xlabel('Iterations Times'); ax3.set_ylabel('Gradient Absolute Values')
    ax3.legend(framealpha=0)
    ax3.spines['top'].set_linewidth('2.0');ax3.spines['left'].set_linewidth('2.0')
    ax3.spines['bottom'].set_linewidth('2.0');ax3.spines['right'].set_linewidth('2.0')
    
    plt.savefig(name+'迭代次数-函数值'+'.png')
    plt.show()


init_point = [0,0]
def main(init_point,method_name,ε=10**(-10)):   # method_name为所使用的优化方法名称, init_point为优化初始点
    time_start=time.time() # 程序计时
    point = init_point
    f_values = [function_z(point[0],point[1])]  # 优化过程中所经历的函数值的集合
    f_nablas = [f_length(function_dz(point[0],point[1]))] # 优化过程中所经历的梯度绝对值的集合
    f_points = [point]  # 优化过程中所经历的点集
    t = float("inf"); f_nabla = float("inf"); Di = np.zeros(len(f_points)) # 步长和梯度和优化方向
    i = 1
    while f_nabla>ε:
        if method_name=='l1':
            D=l1_optimization(point0=point)
        if method_name=='l2':
            D=l2_optimization(point0=point)
        if method_name=='l∞':
            D=linf_optimization(point0=point)
        if method_name=='FR':
            D=FR_optimization(point0=point,f_nabla=f_nablas[-1],Di=Di)
        if method_name=='PR':
            D=PR_optimization(point0=point,vec_nabla=function_dz(f_points[-1][0],f_points[-1][1]),Di=Di)
        Di=copy.deepcopy(D)
        point = newton_optimization(point0=point,ε=ε,D=D)
        f_nabla = f_length(function_dz(point[0],point[1]))
        
        f_values.append(function_z(point[0],point[1]))
        f_nablas.append(f_nabla)
        f_points.append(point)
        t = f_length(f_points[-1]-f_points[-2])
        i = i+1

    time_end=time.time()
    print('最优解: '+str(f_points[-1])); print('最优值: '+str(f_values[-1]))
    print('优化用时: '+str(time_end-time_start)); print("\n\n\n")
    plot(method_name,f_values,f_nablas,f_points)     
    return point

point_FR = main(init_point,'FR',ε=10**(-10))
point_PR = main(init_point,'PR',ε=10**(-10))