clear all;close all;clc
% This is the code for paper£º
% Chengxi Hong, Jianping Cai, The Growth Pattern of Pterosaurs Based on Logistic Growth Model. Academic Journal of Computing & Information Science (2019) Vol. 2: 142-147. https://doi.org/10.25236/AJCIS.010028.
% Written by Jianping Cai.
%% Analysis of dragon's body weight from the research about Pterosaur
spanData=[0.348636523	0.035696988
0.423758716	0.068129207
0.440623643	0.08007718
0.552551652	0.146779927
0.676875001	0.172521055
0.882597538	0.280135676
0.835668243	0.41118294
1.007835915	1.300274626
1.124210035	0.941204967
1.178111623	0.903941553
1.409783886	1.084145869
1.987490607	2.801356761
2.234356885	4.195725019
2.37832492	6.035340185
2.453751107	9.604088213
2.823887933	9.800045006
3.5969318	11.06266214
3.919406775	12.74274986
5.790443981	38.70074258
9.321622805	285.851418];
% Weight Ratio of Dragon to Pterosaur 
alpha=1.7;
% Wingspan of Drogon
wingspanDrogon=59;
% Wingspan of Balerion
wingspanBalerion=105;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=[log(spanData(:,1)) ones(size(spanData,1),1)];
b=log(spanData(:,2));
w=M\b;
syms x
% Function of pterosaurs on wingspan and weight
pterosaurWeightFunc=exp(w(2))*x^w(1);
len=[-1:0.05:1];
len=10.^len;
y=subs(pterosaurWeightFunc,len);
% Function of dragon on wingspan and weight
dragonWeightFunc=alpha*exp(w(2))*x^w(1);
estimatedWeightOfDrogon=double(subs(dragonWeightFunc,wingspanDrogon));
estimatedWeightOfBalerion=double(subs(dragonWeightFunc,wingspanBalerion));
figure
loglog(spanData(:,1),spanData(:,2),'*');
hold on
loglog(len,y,'-');
axis([0.1 10 0.01 1000]) 
xlabel('Wingspan(m)');
ylabel('Weight(kg)');
disp(sprintf('Fitted equation is y=%g*x^%g ',exp(w(2)),w(1)));
disp(sprintf('Estimated weight of Drogon is %g kg.',estimatedWeightOfDrogon));
disp(sprintf('Estimated weight of Balerion is %g kg.',estimatedWeightOfBalerion));
%% Analysis of the relationship between dragon's age and body weight
M=[0 10; % get from problem
    1 35;% get from problem
    6 estimatedWeightOfDrogon;% get from the function of dragon on wingspan and weight
    220 estimatedWeightOfBalerion% get from the function of dragon on wingspan and weight
    ];
M(:,2)=M(:,2);
x0=[100000;100;0.25;0];
optim=optimset('Algorithm','trust-region-reflective','Gradobj','on');
[x,fval] =fminunc(@(x)logisticFunc(x,M),x0,optim);
A=x(1);
B=x(2);
k=x(3);
c=x(4);
t=0:0.1:230;
res=A./(1+B*exp(-k*t))+c;
m=size(M,1);
avgErr=sqrt(fval/m)/mean(M(:,2));
figure
drawRelationshipBetweenAgeAndWeight(M(:,1),M(:,2),t,res,[0 230 0 200000])
disp(sprintf('Parameter a is %g.',A));
disp(sprintf('Parameter b is %g.',B));
disp(sprintf('Parameter k is %g.',k));
disp(sprintf('Parameter c is %g.',c));
disp(sprintf('Logistic function is y=%g/(1+%g*exp(-%g*t))%g ',A,B,k,c));
disp(sprintf('Relative error is %g %%.',avgErr*100));