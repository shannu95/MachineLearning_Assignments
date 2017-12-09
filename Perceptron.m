clear
inputs=[0.08 0.73; 0.29 0.57; 0.45 0.16; 0.6 0.32; 0.16 1.0; 0.36 0.97; 0.7 0.66; 0.94 0.47];
desiredoutputput=[0;0;0;0;1;1;1;1];
epochs=10000;
bias=1;
w = [0.2;1;-1];
learning_rate=0.1;

for i = 1:epochs
     output = zeros(8,1);
     for j = 1:8
          y = bias*w(1,1)+inputs(j,1)*w(2,1)+inputs(j,2)*w(3,1);
          output(j) = 1/(1+exp(-y));
          delta = desiredoutputput(j)-output(j);
          w(1,1) = w(1,1)+learning_rate*bias*delta;
          w(2,1) = w(2,1)+learning_rate*inputs(j,1)*delta;
          w(3,1) = w(3,1)+learning_rate*inputs(j,2)*delta;
     end
end
output
w
for j=1:8
   x=inputs(j,1);
   y=inputs(j,2);
   scatter(x,y,'filled');
   hold on;
 end
m=(-1)*w(2,1)/w(3,1);
c=w(1,1)/w(3,1);
   if(c>0)
    printf("Y=%0.4dX+%0.4d",m,c);
  else
    printf("Y=%0.4dX%0.4d",m,c);
 endif
 X=0:0.1:1;
 Y=(m*X)-(c)
 plot(X,Y);