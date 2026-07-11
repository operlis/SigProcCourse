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

% Two coherent sources positioned symmetrically
d = 1;    % distance from center [m]
snapshots = [10, 25, 40];

for a = 1:length(t)
    % Distance from each source to every point
    r1 = sqrt((X - d).^2 + Y.^2);   % source 1 at (+d, 0)
    r2 = sqrt((X + d).^2 + Y.^2);   % source 2 at (-d, 0)
    
    % Superposition of two waves
    E = (A./r1).*exp(1i*(k*r1 - w*t(a))) + ...
        (A./r2).*exp(1i*(k*r2 - w*t(a)));
    
    pcolor(X, Y, real(E)); shading flat; axis equal;
    caxis([-10 10]);
    title(sprintf('Two coherent sources | t = %.4f sec', t(a)), 'FontSize', 13);
    xlabel('x [m]'); ylabel('y [m]');
    drawnow;
    
    if ismember(a, snapshots)
        saveas(gcf, sprintf('interference_t%d.fig', a));
        saveas(gcf, sprintf('interference_t%d.png', a));
    end
end