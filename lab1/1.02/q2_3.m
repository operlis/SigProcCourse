close all;
clear;
clc;
v = 343;    % m/s
f = 1000;   % Hz
w = 2*pi*f;
lambda = v/f;
k = 2*pi/lambda;
x = -2:0.01:2;
y = x;
[X,Y] = meshgrid(x,y);
A = 1;
t = linspace(0, pi, 50);
d = 0.2;    % distance between adjacent sources [m]
x_sources = [-5:-1, 1:5] * d;   % 10 sources, symmetric, no source at 0  
snapshots = [10, 25, 40];
for a = 1:length(t)
    E = zeros(size(X));                                                      
    for n = 1:length(x_sources)                                             
        r = sqrt((X - x_sources(n)).^2 + Y.^2);
        E = E + (A./r).*exp(1i*(k*r - w*t(a)));
    end
    
    pcolor(X, Y, real(E)); shading flat; axis equal;
    caxis([-10 10]);
    title(sprintf('10 coherent sources | t = %.4f sec', t(a)), 'FontSize', 13);
    xlabel('x [m]'); ylabel('y [m]');
    drawnow;
    
    if ismember(a, snapshots)
        saveas(gcf, sprintf('interference_t%d.fig', a));
        saveas(gcf, sprintf('interference_t%d.png', a));
    end
end