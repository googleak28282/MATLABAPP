% x=0:0.1:2*pi;
% y1=sin(x);
% y2=cos(x);
% plot(x,y1);
% hold on
% plot(x,y2);

% x=0:0.1:2*pi;
% y1=sin(x);
% y2=cos(x);
% plot(x,y1);
% figure
% plot(x,y2);

x=0:0.1:2*pi;
y1=sin(x);
y2=cos(x);
X = [x; x];
Y = [y1;y2];
plot(X', Y')