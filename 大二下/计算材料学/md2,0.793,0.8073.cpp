#include <cmath>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
using namespace std;
#define pi 3.1315926
// simulation parameters

int N = 64;               // number of particles
double rho = 0.8073;         // density (number per unit volume)
double T = 0.793;           // temperature

// function declarations

void initialize();        // allocates memory, calls following 2 functions
void initPositions();     // places particles on an fcc lattice
void initVelocities();    // initial Maxwell-Boltzmann velocity distribution
void rescaleVelocities(); // adjust the instanteous temperature to T
double gasdev();          // Gaussian distributed random numbers

double **r;               // positions
double **v;               // velocities
double **a;               // accelerations

void initialize() {
    r = new double* [N];
    v = new double* [N];
    a = new double* [N];
    for (int i = 0; i < N; i++) {
        r[i] = new double [3];
        v[i] = new double [3];
        a[i] = new double [3];
    }
    initPositions();
    initVelocities();
}
double L;                       // linear size of cubical volume

void initPositions() {

    // compute side of cube from number of particles and number density
    L = pow(N / rho, 1.0/3);

    // find M large enough to fit N atoms on an fcc lattice
    int M = 1;
    while (4 * M * M * M < N)
        ++M;
    double a = L / M;           // lattice constant of conventional cell

    // 4 atomic positions in fcc unit cell
    double xCell[4] = {0.25, 0.75, 0.75, 0.25};
    double yCell[4] = {0.25, 0.75, 0.25, 0.75};
    double zCell[4] = {0.25, 0.25, 0.75, 0.75};

    int n = 0;                  // atoms placed so far
    for (int x = 0; x < M; x++)
        for (int y = 0; y < M; y++)
            for (int z = 0; z < M; z++)
                for (int k = 0; k < 4; k++)
                    if (n < N) {
                        r[n][0] = (x + xCell[k]) * a;
                        r[n][1] = (y + yCell[k]) * a;
                        r[n][2] = (z + zCell[k]) * a;
                        ++n;
                    }
}
double gasdev () 
{
     static bool available = false;
     static double gset;
     double fac, rsq, v1, v2;
     if (!available) 
	 {
        do 
		{
            v1 = rand() / double(RAND_MAX);
            v2 = rand() / double(RAND_MAX);
            rsq = v1 * v1 + v2 * v2;
        } while (rsq == 0.0);
        available = true;
        return sqrt(-2.0 *log(v1))*sin(2*pi*v2);
     } 
	 else {
          available = false;
          return sqrt(-2.0*log(v1))*cos(2*pi*v2);
     }
}

void initVelocities() {

    // Gaussian with unit variance
    for (int n = 0; n < N; n++)
        for (int i = 0; i < 3; i++)
            v[n][i] = gasdev();
    // Adjust velocities so center-of-mass velocity is zero
    double vCM[3] = {0, 0, 0};
    for (int n = 0; n < N; n++)
        for (int i = 0; i < 3; i++)
            vCM[i] += v[n][i];
    for (int i = 0; i < 3; i++)
        vCM[i] /= N;
    for (int n = 0; n < N; n++)
        for (int i = 0; i < 3; i++)
            v[n][i] -= vCM[i];

    // Rescale velocities to get the desired instantaneous temperature
    rescaleVelocities();
}

void rescaleVelocities() {
    double vSqdSum = 0;
    for (int n = 0; n < N; n++)
        for (int i = 0; i < 3; i++)
            vSqdSum += v[n][i] * v[n][i];
    double lambda = sqrt( 3 * (N-1) * T / vSqdSum );
    for (int n = 0; n < N; n++)
        for (int i = 0; i < 3; i++)
            v[n][i] *= lambda;
}
void computeAccelerations() {

    for (int i = 0; i < N; i++)          // set all accelerations to zero
        for (int k = 0; k < 3; k++)
            a[i][k] = 0;

    for (int i = 0; i < N-1; i++)        // loop over all distinct pairs i,j
        for (int j = i+1; j < N; j++) {
            double rij[3];               // position of i relative to j
            double rSqd = 0;
            for (int k = 0; k < 3; k++) {
                rij[k] = r[i][k] - r[j][k];

                // closest image convention
                if (abs(rij[k]) > 0.5 * L) {
                    if (rij[k] > 0)
                        rij[k] -= L;
                    else
                        rij[k] += L;
                }
                rSqd += rij[k] * rij[k];
            }
            double f = 24 * (2 * pow(rSqd, -7) - pow(rSqd, -4));
            for (int k = 0; k < 3; k++) {
                 a[i][k] += rij[k] * f;
                 a[j][k] -= rij[k] * f;
            }
        }
}
void velocityVerlet(double dt) {
    computeAccelerations();
    for (int i = 0; i < N; i++)
        for (int k = 0; k < 3; k++) {
            r[i][k] += v[i][k] * dt + 0.5 * a[i][k] * dt * dt;

            // use periodic boundary conditions
            if (r[i][k] < 0)
                r[i][k] += L;
            if (r[i][k] >= L)
                r[i][k] -= L;
            v[i][k] += 0.5 * a[i][k] * dt;
        }
    computeAccelerations();
    for (int i = 0; i < N; i++)
        for (int k = 0; k < 3; k++)
            v[i][k] += 0.5 * a[i][k] * dt;
}

double instantaneousTemperature() {
    double sum = 0;
    for (int i = 0; i < N; i++)
        for (int k = 0; k < 3; k++)
            sum += v[i][k] * v[i][k];
    return sum / (3 * (N - 1));
}

double compute_ave_kinetic()
{
	double tot_kinetic = 0;
	for(int i = 0; i < N; i++)
		for(int k = 0; k < 3; k++)
			tot_kinetic += v[i][k]*v[i][k];
	return tot_kinetic / N;
}

double compute_ave_potential() //loop over all the particle pairs
{
	double tot_potential = 0;
	for(int i = 0; i < N - 1; i++)	
		for(int j = i + 1; j < N; j++)
		{
			double rij[3];
			double tem_dis = 0;
			for(int k = 0; k<3; k++)
			{
				rij[k] = r[i][k] - r[j][k];
                if ( rij[k] > 0.5 * L || rij[k] < -0.5*L) 
				{
                    if (rij[k] > 0)
                        rij[k] -= L;
                    else
                        rij[k] += L;
					tem_dis += rij[k]*rij[k];
				}
				else
					tem_dis += rij[k]*rij[k];
			}
			tot_potential += 4 * (pow( tem_dis, -6) - pow( tem_dis, -3));
		}
	return tot_potential / N;
}

double compute_ave_dis() //loop over all the particle pairs
{
	int count = 0;
	double tot_dis = 0;
	for (int i = 0; i < N; i++)
		for(int j = i+1; j < N; j++)
		{
			double tem_dis = 0;
			for(int k = 0; k <3; k++)
			{
				tem_dis += (r[i][k]-r[j][k]) * (r[i][k]-r[j][k]);
			}
		tot_dis += sqrt(tem_dis);
		count++;
		}
	return tot_dis / count;
}


int main() {
    initialize();
    double dt = 0.01;
    ofstream file("comprehensive rho=0.8073 T=0.793 mirror.data");
    for (int i = 0; i < 1000; i++) {
        velocityVerlet(dt);
        file << instantaneousTemperature() << " " << compute_ave_potential() << " " << compute_ave_kinetic() << " " << compute_ave_dis() << '\n';
        if (i % 200 == 0)
            rescaleVelocities();
    }
    file.close();
}
