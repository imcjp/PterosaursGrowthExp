function [f,g] = logisticFunc(x,M)
A=x(1);
B=x(2);
k=x(3);
c=x(4);
t=M(:,1);
u0=1./(1+B*exp(-k*t));
u1=exp(-k*t).*u0.*u0;
v1=A*u0+c-M(:,2);
f=v1'*v1;
v2=-A*u1;
v3=((A*B)*t).*u1;
M=[u0';v2';v3';ones(1,length(t))];
g=M*v1;
end

