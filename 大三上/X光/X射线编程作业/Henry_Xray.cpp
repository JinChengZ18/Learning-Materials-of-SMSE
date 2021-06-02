#include<stdio.h>
#include<stdlib.h> 
#include<math.h>
#include <conio.h>
#include <ctype.h>
#include <string.h>
#define pi 3.1415926
#include<fstream>
#include<iostream>

double cal_dist(int r[3]);//计算晶面距离
double cal_theta(double d);//计算衍射角theta,单位为rad 
void rank(struct plane *pl,int h,int k,int l);//生成新链表与排序 
void cal_i(struct plane *pl);//计算衍射强度
void rel_i(struct plane *pl);//计算相对强度，其中包含对分辨角的计算 


struct plane
{
  struct plane *next; //链表存放下一个地址
  int r[3];  // r0=h,r1=k,r2=l
  double dist; //晶面间距 
  double theta;  // 衍射角theta ,单位为rad 
  double i;  //衍射强度
  int con; //控制变量 ，0=独立，1=开始， 2=结束 ,3=重复上个数据 
};

main()
{
   struct plane *crystal=(struct plane*)malloc(sizeof(struct plane));
   crystal->con=1;
   struct plane *print;
   FILE *fp;//打印指针 
 
 for(int h=0;h<=6;h++)
 {
   for(int k=0;k<=6;k++)
   {
     for(int l=0;l<=6;l++)
     {
         if(h+k+l!=0)
         rank(crystal,h,k,l);
     }      
   }     
 } 
 
   cal_i(crystal);
   rel_i(crystal); 
   //打印 
   fp=fopen("data.txt","wb");
   print=crystal->next;
   while(1)
  {
      if(print->con!=3)     
         fprintf(fp,"%d%d%d   %f   %f   %f\n",print->r[0],print->r[1],print->r[2],print->i,print->dist,print->theta*360/pi);
      else
         fprintf(fp,"%d%d%d\n",print->r[0],print->r[1],print->r[2]);  
      if(print->con==2)
      break;
      else
      print=print->next;
  }
  fclose(fp);
	
 }
 
 
double cal_dist(int r[3])
{
  double d;
  d=1/sqrt(r[0]*r[0]/15.155449+r[1]*r[1]/136.609344+r[2]*r[2]/14.5924);//abc的平方已算出 
  return d;     
}
double cal_theta(double d)
{
  double theta;
  theta=asin(1.54178/(2*d)) ;
  return theta;    
}
void rank(struct plane *pl,int h,int k,int l)
{
        struct plane *temp=(struct plane*)malloc(sizeof(struct plane));//临时存放面 
        struct plane *point=pl  ;//指针
         temp->r[0]=h; temp->r[1]=k;temp->r[2]=l; 
         temp->dist=cal_dist(temp->r);
         temp->theta=cal_theta(temp->dist);  
 
         //开始排序，对角度有限制 
         if(temp->theta<=2.62)
         {
           if (point->con==1)
           {temp->con=2;point->next=temp;point->con=0;}
           else 
           {
                while(1)
             {
               if(temp->dist<point->next->dist)
                    if(point->next->con==2)
                     {point->next->con=0;point->next->next=temp; temp->con=2;break;}
                    else
                     {point=point->next;}
               else
                 {temp->con=0;temp->next=point->next;point->next=temp;break;}     
              }
           }
         }
}

void cal_i(struct plane *pl)
{
     struct plane *point=pl->next  ;//指针
     double P,F_2,LP,fi[4],fj[13];  
     double fi_const[4][9]=
//		a1      b1      a2      b2      a3      b3      a4      b4        c
	{{17.9268,1.35417,9.15310,11.2145,1.76795,22.6599,-33.108,-0.01319,40.2602},	//Y
	{20.1807,3.21367,19.1136,0.283310,10.9054,20.0558,0.77634,51.7460,3.0292},		//Ba
	{11.8168,3.37484,7.11181,0.244078,5.78135,7.98760,1.14523,19.8970,1.14431},		//Cu
	{4.19160,12.8573,1.63969,4.17236,1.52673,47.0179,-20.307,-0.01404,21.9412}}	;	//O
	
	double atom_pos[13][3]=
	//Y
	{{1.0/2,1.0/2,1.0/2},
	//Ba
	{1.0/2,1.0/6,1.0/2},
	{1.0/2,5.0/6,1.0/2},
	//Cu
	{0,0,0},
	{0,1.0/3,0},
	{0,2.0/3,0},
	//O
	{1.0/2,0,0},
	{1.0/2,1.0/3,0},
	{1.0/2,2.0/3,0},
	{0,0,1.0/2},
	{0,1.0/3,1.0/2},
	{0,2.0/3,1.0/2},
	{0,1.0/2,0}};


     while(1)
  {
             //计算P 
      if(point->r[0]*point->r[1]*point->r[2]==0)
        if(point->r[0]+point->r[1]==0||point->r[2]+point->r[1]==0||point->r[0]+point->r[2]==0)
          P=2.0;
        else
          P=4.0;
      else
        P=8.0;
        
      //计算 LP 
      LP=(1+pow(cos(2*point->theta),2))/(pow(sin(point->theta),2)*cos(point->theta));
      //计算F_2
      F_2=0;
      for(int i=0;i<=3;i++)
      {
        fi[i]=0;
        for(int x=0;x<=3;x++)      
       {fi[i]=fi[i]+fi_const[i][2*x]*exp(-fi_const[i][2*x+1]*pow(sin(point->theta)/1.54178,2));}
        fi[i]=fi[i]+fi_const[i][8];
      }
      fj[0]=fi[0];
      fj[1]=fj[2]=fi[1];
      fj[3]=fj[4]=fj[5]=fi[2];
      fj[6]=fj[7]=fj[8]=fj[9]=fj[10]=fj[11]=fj[12]=fi[3];
       for(int j=0;j<=12;j++)
       {
         for(int k=0;k<=12;k++)
         {
           
           F_2=F_2+fj[j]*fj[k]*cos(2*pi*(point->r[0]*(atom_pos[j][0]-atom_pos[k][0])+point->r[1]*(atom_pos[j][1]-atom_pos[k][1])+point->r[2]*(atom_pos[j][2]-atom_pos[k][2])));
         }
       }
      
      //计算i
      point->i=LP*F_2*P; 
      if(point->con==2)
        break;
      else
        point=point->next;
  }
}

void rel_i(struct plane *pl)
{
  struct plane *point=pl->next  ;//指针 
  struct plane *temp;
  double imax=0;
  //检查衍射角分辨率，小于0.05度
    while(1)
  {
     if(point->next->con==2)
        break;      
      if(point->next->theta-point->theta<0.000436111)
        point->next->con=3; 
      point=point->next;    
  } 
  //合并强度
  point=pl->next;
  while(point->con!=2)
  {
    temp=point->next;
    while(temp->con==3)
    {       point->i=point->i+temp->i;temp=temp->next;    }
    if(imax<point->i)
      imax=point->i;
    point=temp;
  }         
  //转为相对强度
  point=pl->next; 
  while(1)
  {
      point->i=point->i*100/imax; 
      if(point->con==2)
        break;
      else
        point=point->next;    
  }
}
