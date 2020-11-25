clear all
clc
option=gaoptimset('PopulationSize',100,'Generations',5000,'PlotFcns',@gaplotbestf);%种群数100,迭代数5000
ga(@zp,3,option)