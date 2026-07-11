close all;
clear;
clc;

v=343;  % m/s
f=1000; % Hz
w=2*pi*f;   % angular frequency
lambda=v/f; % wavelength
k=2*pi/lambda;  % k-vector
x=-2:0.01:2;
y=x;
[X,Y]=meshgrid(x,y);
A=1;    % amplitude
t=linspace(0,pi,50);

snapshots = [10, 25, 40];   % indices of frames to capture

for a=1:length(t)
    r=sqrt(X.^2+Y.^2);
    E=(A./r).*exp(1i.*(k.*r-w.*t(a)));  % wave equation
    pcolor(X,Y,real(E)); shading flat; axis equal; 
    caxis([-5 5]);
    drawnow;
    
    if ismember(a, snapshots)
        saveas(gcf, sprintf('snapshot_t%d.fig', a))
    end
end
%% 
% ------ data from static pictures ------
% in order to calculate the velocity from the pictures:
% from each pictues we will get lambda by caclulating the distance between
% two yellow circles. (r2 - r1) or (x2-x1 when y2 and y1 are 0)
% then the velocity will be: 
% v = lambda * f (f = 1000 Hz)



x1 = 0.35;
x2 = 0.7;
lambda1 = x2 - x1;
v1 = lambda1 * f;
fprintf('%c1 = %.2f - %.2f = %.2f\n',char(955), x2,x1,lambda1);
fprintf('v1 = %.2f\n', v1);

x1 = 0.25;
x2 = 0.6;
lambda2 = x2 - x1;
v2 = lambda2 * f;
fprintf('%c2 = %.2f - %.2f = %.2f\n',char(955), x2,x1,lambda2);
fprintf('v2 = %.2f\n', v2);

x1 = 0.5;
x2 = 0.85;
lambda3 = x2 - x1;
v3 = lambda3 * f;
fprintf('%c3 = %.2f - %.2f = %.2f\n',char(955), x2,x1,lambda3);
fprintf('v3 = %.2f\n', v3);





