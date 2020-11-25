import random
import numpy as np
import math
import matplotlib.pyplot as plt

import plot as p


name = 'md2_0505'  # Default name
step = 1  # current step
steps = 200  # Total steps
dt = 0.01  # Time step

#simulation parameters
N = 1000  # number of particles
rho = 1.5  # density (number per unit volume)

T = 0.05  # Change the temperature here!
L = 1.0  # linear size of cubical volume

# Data
r = np.zeros([N,3])  # positions
v = np.zeros([N,3])  # velocities
a = np.zeros([N,3])  # accelerations

Ps = np.zeros([N])
Ks = np.zeros([N])

# function declarations

def initialize(T):
	r = initPositions()
	v = initVelocities(T)
	return r,v
	
	
def initPositions():
	global L
	# compute side of cube from number of particles and number density
	L = math.pow(N / rho, 1.0/3) 
	# find M large enough to fit N atoms on an fcc lattice
	M = 1  # number of fcc lattice
	while 4*M**3< N:
		M += 1
	a0 = L / M  # lattice constant of conventional cell
	print('current a0:'+str(a0))
	
	# 4 atomic positions in fcc unit cell
	xCell = [0.25, 0.75, 0.75, 0.25]
	yCell = [0.25, 0.75, 0.25, 0.75]
	zCell = [0.25, 0.25, 0.75, 0.75]
	
	n = 0  # atoms placed so far
	for x in range(M):
		for  y in range(M):
			for z in range(M):
				for k in range(4):
					if n < N:
						r[n][0] = (x + xCell[k]) * a0
						r[n][1] = (y + yCell[k]) * a0
						r[n][2] = (z + zCell[k]) * a0
						n +=1
						
	return r
	

available = False
gset = 0
def gasdev():  # Gaussian distributed random numbers
	global available,gset
	fac = 0
	rsq = 0
	if not available:
		while rsq >= 1.0 or rsq == 0.0:
			v1 = 2.0 * random.random() - 1.0
			v2 = 2.0 * random.random() - 1.0
			rsq = v1 * v1 + v2 * v2
		fac = math.sqrt(-2.0 * math.log(rsq) / rsq)
		gset = v1 * fac
		available = True
		return v2*fac
	else:
		available = False
		return gset
		
	
def rescaleVelocities(T):  # adjust the instanteous temperature to T
	vSqdSum = 0
	for n in range(N):
		for i in range(3):
			vSqdSum += v[n][i] * v[n][i]
	lambd = math.sqrt(3*(N-1)*T/vSqdSum)
	for n in range(N):
		for i in range(3):
			v[n][i] *= lambd
	
		
def initVelocities(T):  # initial Maxwell-Boltzmann velocity distribution
	# Gaussian with unit variance
	for n in range(N):
		for i in range(3):
			v[n][i] = gasdev()
	
	# Adjust velocities so center-of-mass velocity is zero
	vCM = [0, 0, 0]
	for n in range(N):
		for i in range(3):
			vCM[i] += v[n][i]
	for i in range(3):
		vCM[i] /= N
	for n in range(N):
		for i in range(3):
			v[n][i] -= vCM[i]
	
	#  Rescale velocities to get the desired instantaneous temperature
	rescaleVelocities(T)
	return v
	

def computeAccelerations():
	for i in range(N):  # set all accelerations to zero
		for k in range(3):
			a[i][k] = 0
	for i in range(N-1):  # loop over all distinct pairs i,j
		for j in range(i+1,N):
			rij = np.zeros(3)  # position of i relative to j
			rSqd = 0.0
	for k in range(3):
		rij[k] = r[i][k] - r[j][k]
		# closest image convention
		if abs(rij[k]) > 0.5*L:
			if rij[k] > 0:
				rij[k] -= L
			else:
				rij[k] += L
		rSqd += rij[k] * rij[k]
	
	f = 24*(2*math.pow(rSqd,-7) - math.pow(rSqd,-4))
	
	for k in range(3):
		a[i][k] += rij[k]*f
		a[j][k] -= rij[k]*f
	return a
	
	
def velocityVerlet(dt):  # Time Step
	a = computeAccelerations()
		
	for i in range(N):
		for k in range(3):
			r[i][k] += v[i][k]*dt + 0.5*a[i][k]*dt*dt
			# use periodic boundary conditions
			if r[i][k] < 0:
				r[i][k] += L
			if r[i][k] >= L:
				r[i][k] -= L
			v[i][k] += 0.5*a[i][k]*dt
	
	a = computeAccelerations()
	
	for i in range(N):
		for k in range(3):
			v[i][k] += 0.5*a[i][k]*dt
	
	
def instantaneousTemperature():
	v2_sum = 0
	for i in range(N):
		 for k in range(3):
			 v2_sum += v[i][k]*v[i][k]
	T = v2_sum / (3 * (N - 1))
	return T


def instantaneousKinetic():
	global v,Ks
	k_sum = 0
	for i in range(N):
		for k in range(3):
			Ks[i] += 0.5*v[i][k]*v[i][k]
			k_sum += Ks[i]
	return k_sum/N


def instantaneousPD():
	global r,Ps
	d_aver = 0.0
	d_sum = 0.0
	count = 0
	p_sum = 0
	for i in range(N):  # loop over all distinct pairs i,j
		for j in range(N):
			count += 1
			rij = np.zeros(3)  # position of i relative to j
			rSqd = 0.0
			for k in range(3):
				rij[k] = r[i][k] - r[j][k]
				# closest image convention
				if abs(rij[k]) > 0.5*L:
					if rij[k] > 0:
						rij[k] -= L
					else:
						rij[k] += L
				rSqd += rij[k] * rij[k]
			
			if rSqd != 0:  # 
				Ps[i] += 4*(math.pow(rSqd,-6) - math.pow(rSqd,-3)) # Add j's effect on i
			d_sum += pow(rSqd,0.5)
	d_aver = d_sum/count

	for i in range(N):
		p_sum += Ps[i]
	
	return p_sum/2/N, d_aver  # Divided by 2N here since each particle is counted twice in our calculation




# the main function which steers the simulation
for T in [0.005,0.01,0.05,0.1,0.5,1,2,4]:
	step = 1
	r,v = initialize(T)
	print('current temperature:'+str(T))
	
	P_sums = []; K_sums = []; E_sums = []; d_aver = 0; d_avers = []
	
	while step<=steps:
		K_sum = instantaneousKinetic()
		K_sums.append(K_sum)
		P_sum, d_aver = instantaneousPD()
		P_sums.append(P_sum)
		E_sum = K_sum + P_sum
		E_sums.append(E_sum)
		d_avers.append(d_aver)
		
		velocityVerlet(dt)
		'''
		try:
			print(len(K_sums));print(len(P_sums));print(len(E_sums));print(len(d_avers));
		except:
			print(type(K_sums));print(type(P_sums));print(type(E_sums));print(type(d_avers));
		'''
		if step % 2 == 0:
			p.plot(r,v,N,rho,Ks,Ps,K_sums,P_sums,E_sums,d_avers,L,T,steps,step,name)
			# plot(r,v,N,rho,Ks,Ps,K_sums,P_sums,E_sums,d_avers,L,T,steps,step,name)

		if step % 200 == 0:
			rescaleVelocities(T)
			
		step += 1
		
print('Simulation Finished!\n')
	




# np.savetxt("D_avers_md2.txt",md_avers)
'''
fig = plt.figure()
ax = fig.add_subplot(111)

plt.xlabel('Timestep')
plt.ylabel('Average Distance')

for i in range(record):
	ax.plot(Tsteps, md_avers[i][...],label="$Teperature:"+str(Ts[i])+"$")

plt.legend()
plt.show()
'''
