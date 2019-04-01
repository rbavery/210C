data=load('ding-data1.txt');
variabels =['Var1';'Var2';'Var3';'Var4'];
beta=fitlm(data(:,2:4),data(:,5),'ResponseVar',variabels(4,:),'PredictorVars',variabels(1:3,:))
