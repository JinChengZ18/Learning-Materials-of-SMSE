clear all
clc
option=gaoptimset('PopulationSize',100,'Generations',5000,'PlotFcns',@gaplotbestf);%��Ⱥ��100,������5000
ga(@zp,3,option)