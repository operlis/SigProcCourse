close all;
clear;
clc;

% Validate 4 diffrerent values of Temeratures when one is our of the range
% [0,1000]

fprintf("Speed of sound when Temp = 50 celcius:  %s m/s \n", getSpeedOfSoundFromCelciusTemp(50));
fprintf("Speed of sound when Temp = 350 celcius:  %s m/s \n", getSpeedOfSoundFromCelciusTemp(350));
fprintf("Speed of sound when Temp = 750 celcius:  %s m/s \n", getSpeedOfSoundFromCelciusTemp(750));
fprintf("Speed of sound when Temp = 1050 celcius:  %s m/s \n", getSpeedOfSoundFromCelciusTemp(1050));
%%
% Validate 5 temperatures from returned table:
speedOfSoundTable = getSpeedOfSoundTable();
wantedTemps = [50, 350, 500, 750, 950];

temps = speedOfSoundTable(1, :);
speeds = speedOfSoundTable(2, :);

returnedSpeeds = zeros(size(wantedTemps));

for k = 1:length(wantedTemps)
    index = find(temps == wantedTemps(k), 1);
    returnedSpeeds(k) = speeds(index);
    fprintf('T = %d C -> v = %.2f m/s\n', wantedTemps(k), returnedSpeeds(k));
end

%%
% Plot speed of sound as a function of temperature.
speedOfSoundTable = getSpeedOfSoundTable();

temps = speedOfSoundTable(1, :);
speeds = speedOfSoundTable(2, :);

figure(1);
plot(temps, speeds, '-', "Color","#1DAB4B");
hold on;
plot(temps, speeds, 'o', "MarkerFaceColor","#1DAB4B", "MarkerEdgeColor","#1DAB4B");
grid on; grid minor;
title("Speed of sound as a function of a Temperature", "FontSize", 16);
xlabel("Temperature t [ ^oC ]", "FontSize", 14);
ylabel("Speed of sound V [ m/sec ]", "FontSize", 14);
legend(["Theoretical Curve","Experimental points"],"FontSize", 11);


%%
% 01.01.7. Use the equation V1(t)= a+b*t+c*t^2 to interpolate data in the Table (find a,b,c).
% Plot V and V1 in the same graph.
% Plot the “relative error” (V(t)-V1(t))/V(t)*100%. Explain results.


% 01.01.7 - Polynomial interpolation of speed of sound data

speedOfSoundTable = getSpeedOfSoundTable();
T  = speedOfSoundTable(1, :);
V  = speedOfSoundTable(2, :);

% Find coefficients a, b, c for V1(t) = a + b*t + c*t^2
coeffs = polyfit(T, V, 2);
c = coeffs(1);
b = coeffs(2);
a = coeffs(3);

fprintf('a = %.6f\n', a);
fprintf('b = %.6f\n', b);
fprintf('c = %.6f\n', c);

% Compute V1 for all temperatures in the table
V1 = polyval(coeffs, T);

% Relative error
relError = ((V - V1) ./ V) .* 100;

figure(2);
% --- Subplot 1: V and V1 on same graph ---
subplot(2, 1, 1);
plot(T, V,  'b-o', 'MarkerFaceColor', 'b', 'DisplayName', 'V(t) - Exact');
hold on;
plot(T, V1, 'r--s', 'MarkerFaceColor', 'r', 'DisplayName', 'V1(t) = a+bt+ct^2');
hold off;
grid on; grid minor;
title('Speed of Sound: Exact vs Interpolated Approximation', 'FontSize', 14);
xlabel('Temperature t [ ^oC ]', 'FontSize', 12);
ylabel('Speed of Sound V [ m/sec ]', 'FontSize', 12);
legend('FontSize', 11);

% --- Subplot 2: Relative error ---
subplot(2, 1, 2);
plot(T, relError, '-o', "MarkerFaceColor","#1DAB4B", "MarkerEdgeColor","#1DAB4B");
grid on; grid minor;
title('Relative Error: (V(t) - V1(t)) / V(t) * 100%', 'FontSize', 14);
xlabel('Temperature t [ ^oC ]', 'FontSize', 12);
ylabel('Relative Error [ % ]', 'FontSize', 12);

